package cn.morebug.blog.controller;

import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.morebug.blog.bean.UserDo;
import cn.morebug.blog.bean.UserVo;
import cn.morebug.blog.service.UserService;
import cn.morebug.blog.util.MD5Util;
import net.sf.json.JSONObject;

@RequestMapping("user")
@Controller
public class UserController {
	
	@Autowired
	UserService userServce;
	
	@ResponseBody
	@RequestMapping("register")
	public JSONObject userRegister(UserDo userDo) {
		//加密密码
		userDo.setPassword(MD5Util.getMD5String(userDo.getPassword()));
		//设置注册时间
		userDo.setRegister_date(new Date());
		Integer code = userServce.userRegister(userDo);

		JSONObject message = new JSONObject();
		message.put("code", code);
		return message;
	}
	
	@ResponseBody
	@RequestMapping("login")
	public JSONObject userLogin(UserDo userDo,HttpServletRequest request) {
		JSONObject message = new JSONObject();
		if(userDo.getUsername() == null || userDo.getUsername().equals("")) {
			message.put("code",-1);//用户名不可为空
			return message;
		}
		if(userDo.getPassword() == null || userDo.getPassword().equals("")) {
			message.put("code",-2);//密码不可为空
			return message;
		}
		//加密密码
		userDo.setPassword(MD5Util.getMD5String(userDo.getPassword()));
		
		//根据用户名查找用户信息
		UserVo userVo = userServce.getUserVo(userDo.getUsername());
//		System.out.println(userVo.getId());
		if(userVo == null) {
			message.put("code", -3);//用户不存在
			return message;
		}else if(!userVo.getPassword().equals(userDo.getPassword())) {
			message.put("code", -4);//密码错误
			return message;
		}
		request.getSession().setAttribute("userVo", userVo);//用户登录成功
		message.put("code", 1);//登陆成功
		return message;
	}
	
	@ResponseBody
	@RequestMapping("updateinfo")
	public JSONObject updateUserInfo(UserDo userDo) {
//		System.out.println(userDo.toString());
		JSONObject message = new JSONObject();
		if(userDo.getId() == null || userDo.getId() == 0) {
			message.put("code",-1);//id不可为空
			return message;
		}
		if(userDo.getNickname() == null || userDo.getNickname().equals("")) {
			message.put("code",-2);//昵称不可为空
			return message;
		}
		if(userDo.getMobile_num() == null || userDo.getMobile_num().equals("")) {
			message.put("code",-3);//联系号码不可为空
			return message;
		}
		if(userDo.getEmail() == null || userDo.getEmail().equals("")) {
			message.put("code",-4);//电子邮箱不可为空
			return message;
		}
		if(userServce.updateUserInfo(userDo) == -1) {
			message.put("code",-5);//修改失败
			return message;//修改失败
		}
		message.put("code", 1);
		return message;//修改成功
	}
	
	@ResponseBody
	@RequestMapping("updatepwd")
	public JSONObject updateUserPwd(@RequestParam("id") Integer id,@RequestParam("oldPwd")String oldPwd,
			@RequestParam("newPwd")String newPwd) {
		JSONObject message = new JSONObject();
		if(id == null || id == 0) {
			message.put("code",-1);//id不可为空
			return message;
		}
		oldPwd = MD5Util.getMD5String(oldPwd);
		UserDo userDo = userServce.getUserDoById(id);
		if(userDo == null) {
			message.put("code", -2);//用户不存在
			return message;
		}
		if(userDo.getPassword() != null && userDo.getPassword().equals(oldPwd)) {
			newPwd = MD5Util.getMD5String(newPwd);
			userDo.setPassword(newPwd);
			if(userServce.updateUserPwd(userDo) == -1) {
				message.put("code",-4);//修改失败
				return message;
			}
			message.put("code", 1);//修改成功
			return message;
		}
		message.put("code",-3);//密码错误
		return message;
	}
	
	@ResponseBody
	@RequestMapping("logout")
	public String logout(HttpServletRequest request) {
		request.getSession().removeAttribute("userVo");
//		System.out.println("success");
		return "success";
	}
}
