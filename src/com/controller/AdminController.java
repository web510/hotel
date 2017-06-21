package com.controller;

import com.entity.Admin;
import com.service.AdminService;
import com.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

@Controller
@Transactional
@RequestMapping("admin")
public class AdminController {
	@Autowired
	private AdminService userService;

    @ResponseBody
	@RequestMapping(value="/loginPost",produces = "application/json; charset=utf-8")
	public String loginPost(String userName, String password, HttpSession session)  {
		Admin user = userService.getUser(userName, password);
		if (user != null) {
			session.setAttribute("user", user);
			return JsonUtils.writeStatus(1, user.getClass().toString());
		} else {
			return JsonUtils.writeStatus(0,"用户名或密码错误");
		}
	}
}

