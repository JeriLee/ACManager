package com.zzkun.uhunt;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

/**
 * Created by kun on 2016/7/8.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:springmvc-servlet.xml")
public class ChapterManagerTest {

    @Autowired
    private ChapterManager chapterManager;

    @Test
    public void getChapterMap() throws Exception {
        System.out.println(chapterManager.getChapterMap());
    }

    @Test
    public void getBookMap() throws Exception {
        System.out.println(chapterManager.getBookMap());
        System.out.println(chapterManager.getBookMap().size());
    }

}