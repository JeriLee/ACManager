package com.zzkun.controller;

import com.zzkun.config.UhuntUpdateStatus;
import com.zzkun.model.User;
import com.zzkun.service.CFService;
import com.zzkun.service.UVaService;
import com.zzkun.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import java.util.List;
import java.util.stream.Collectors;

/**
 * uva相关控制器
 * Created by kun on 2016/7/14.
 */
@Controller
@RequestMapping("/uva")
public class UVaController {

    @Autowired private UVaService uVaService;

    @Autowired private CFService cfService;

    @Autowired private UserService userService;

    @Autowired private UhuntUpdateStatus uhuntUpdateStatus;


    @RequestMapping("/showTable")
    public String showTable(Model model) {
        model.addAttribute("booksName", uVaService.getBookName());
        model.addAttribute("cptsName", uVaService.getChapterName());
        List<User> users = userService.allNormalNotNullUsers();
        List<Integer> uvaids = users.stream().map(User::getUvaId).collect(Collectors.toList());
        model.addAttribute("users", users);
        model.addAttribute("cfInfoMap", cfService.getCFUserInfoMap());
        model.addAttribute("bookCnt", uVaService.getBookCnt(uvaids));
        model.addAttribute("cptCnt", uVaService.getCptCnt(uvaids));
        model.addAttribute("lastUpdate", uhuntUpdateStatus.getLastTime());
        return "tablefile";
    }

    @RequestMapping(value = "/updatedb", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updatedb(@SessionAttribute(required = false) User user) {
        if(user == null || !user.isAdmin())
            return "没有权限操作！";
        if(!uhuntUpdateStatus.canUpdate())
            return "正在更新，或者刚刚更新完毕，请稍后再试...";
        uhuntUpdateStatus.preUpdate();

        uVaService.flushUVaSubmit();
        cfService.flushCFUserInfo();

        uhuntUpdateStatus.afterUpdate();
        return "恭喜，更新完毕！";
    }
}
