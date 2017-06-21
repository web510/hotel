package com.controller;

import com.dao.OrderDao;
import com.dao.RoomNumberDao;
import com.entity.Admin;
import com.entity.Order_;
import com.entity.RoomNumber;
import com.service.AdminService;
import com.util.JsonUtils;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Controller
@Transactional
@RequestMapping("admin")
public class AdminPostController {
	@Autowired
	private AdminService userService;
	@Autowired
	private RoomNumberDao roomNumberDao;
	@Autowired
	private OrderDao orderDao;

	@ResponseBody
	@RequestMapping(value="/inMoney",produces = "application/json; charset=utf-8")
	public String inMoney(int order_id) {
		orderDao.inMoney(order_id);
		return JsonUtils.writeStatus(1,"缴费成功");
	}

	@ResponseBody
	@RequestMapping(value="/roomNumberListCanSelect",produces = "application/json; charset=utf-8")
	public String roomNumberListCanSelect(int order_id) {
		List<JSONObject> res = new ArrayList<JSONObject>();
		Order_ order = orderDao.find(order_id);
		List<RoomNumber> roomNumbers = roomNumberDao.roomNumberListCanSelect(order_id);
		for(RoomNumber roomNumber : roomNumbers) {
			if(null != roomNumberDao.roomByWhichOrdered(roomNumber.getId(),order.getInDate())) {
				continue;
			}
			JSONObject obj = new JSONObject();
			obj.put("id",roomNumber.getId());
			obj.put("roomNumber",roomNumber.getNumber());
			res.add(obj);
		}
		return res.toString();
	}

    @ResponseBody
	@RequestMapping(value="/signInPost",produces = "application/json; charset=utf-8")
	public String loginPost(String username, String password, HttpSession session)  {
		Admin user = userService.getUser(username, password);
		if (user != null) {
			session.setAttribute("user", user);
			return JsonUtils.writeStatus(1, user.getClass().toString());
		} else {
			return JsonUtils.writeStatus(0,"用户名或密码错误");
		}
	}
}

