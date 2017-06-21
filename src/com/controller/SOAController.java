package com.controller;

import com.dao.OrderDao;
import com.dao.RoomDao;
import com.entity.Room;
import com.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.transaction.Transactional;
import java.sql.Date;

/**
 * Created by onlymzzhang on 2017/6/21.
 */
@Controller
@RequestMapping("SOA")
@Transactional
public class SOAController {
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private RoomDao roomDao;

    @ResponseBody
    @RequestMapping(value="/orderRoom",produces = "application/json; charset=utf-8")
    //订房
    public String orderRoom(String sfzh, String name, Date inDate, Date outDate, String roomType,String phone) {
        //Room room = roomDao.find(roomType);
        //orderDao.insert(inDate,outDate,name,sfzh,phone,room);
        return JsonUtils.writeStatus(1,"");
    }
    //查询房间剩余信息
    @ResponseBody
    @RequestMapping(value="/queryRoom",produces = "application/json; charset=utf-8")
    public String queryRoom(String sfzh, String name, String inDate, String outDate, String roomType) {
        return JsonUtils.writeStatus(1,"");
    }
}
