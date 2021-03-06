package com.zzkun.util.cfapi;

import com.zzkun.model.CFUserInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by Administrator on 2016/7/31.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:springmvc-servlet.xml")
public class CFWebGetterTest {

    @Autowired private CFWebGetter cfWebGetter;

    @Test
    public void getUserInfos() throws Exception {
        List<CFUserInfo> list = cfWebGetter.getUserInfos(Arrays.asList("kun368", "tourist"));
        System.out.println(list);
    }

}