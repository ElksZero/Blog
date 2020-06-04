package cn.morebug.blog.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;

import cn.morebug.blog.bean.AuthorizationDo;
import cn.morebug.blog.bean.UserDo;
import cn.morebug.blog.service.UserManageService;
import cn.morebug.blog.service.UserService;
import cn.morebug.blog.util.MD5Util;
import net.sf.json.JSONObject;

@RequestMapping("manage")
@Controller
public class UserManageController {

	@Autowired
	private UserManageService service;
	@Autowired
	private UserService userService;

	// 分页查询战士
	@RequestMapping("userManage")
	public ModelAndView toUserManage(
			@RequestParam(name = "pageNum", defaultValue = "1", required = false) Integer pageNum,
			@RequestParam(name = "possible_username", defaultValue = "", required = false) String possible_username,
			@RequestParam(name = "possible_nickname", defaultValue = "", required = false) String possible_nickname) {

		ModelAndView modelAndView = new ModelAndView();
		// 设置视图
		modelAndView.setViewName("manage/userManage");

		String username = possible_username;
		String nickname = possible_nickname;
		// 若未提供查询条件，则将其设置为null
		// 拼接模糊成为查询
		if (possible_username.equals("")) {
			possible_username = null;
		} else {
			possible_username = "%" + possible_username + "%";
		}
		if (possible_nickname.equals("")) {
			possible_nickname = null;
		} else {
			possible_nickname = "%" + possible_nickname + "%";
		}
		// 分页信息
		PageInfo<UserDo> pageInfo = new PageInfo<UserDo>(
				service.paging_query(pageNum, 10, possible_username, possible_nickname));
		// 设置模型
		modelAndView.addObject("pageInfo", pageInfo);
		modelAndView.addObject("possible_username", username);
		modelAndView.addObject("possible_nickname", nickname);

		return modelAndView;
	}

	// 添加用户
	@ResponseBody
	@RequestMapping("userManage/addUser")
	public JSONObject addUser(UserDo userDo) {
		// 加密密码
		userDo.setPassword(MD5Util.getMD5String(userDo.getPassword()));
		// 设置（添加）注册时间
		userDo.setRegister_date(new Date());
		// 注册用户
		Integer code = userService.userRegister(userDo);

		JSONObject message = new JSONObject();
		message.put("code", code);
		return message;
	}

	// 添加用户
	@ResponseBody
	@RequestMapping("userManage/getUserById")
	public JSONObject getUserById(@RequestParam("id") Integer id) {
		JSONObject message = new JSONObject();
		message.put("user", userService.getUserDoById(id));
		return message;
	}

	@ResponseBody
	@RequestMapping("userManage/updateUser")
	public JSONObject updateUser(UserDo userDo) {
		JSONObject message = new JSONObject();
		if (userDo.getId() == null || userDo.getId() == 0) {
			message.put("code", -1);// id不可为空
			return message;
		}
		if (userDo.getNickname() == null || userDo.getNickname().equals("")) {
			message.put("code", -2);// 昵称不可为空
			return message;
		}
		if (userDo.getMobile_num() == null || userDo.getMobile_num().equals("")) {
			message.put("code", -3);// 联系号码不可为空
			return message;
		}
		if (userDo.getEmail() == null || userDo.getEmail().equals("")) {
			message.put("code", -4);// 电子邮箱不可为空
			return message;
		}
		if (userService.updateUserInfo(userDo) == -1) {
			message.put("code", -5);// 修改失败
			return message;// 修改失败
		}
		message.put("code", 1);
		return message;// 修改成功
	}

	@ResponseBody
	@RequestMapping("userManage/deleteUser")
	public JSONObject deleteUser(@RequestParam("id") Integer id) {
		JSONObject message = new JSONObject();
		if (id == null || id == 0) {
			message.put("code", "-1");// id不可为空
			return message;
		}
		// 直接将返回值作为状态码
		message.put("code", service.deleteUser(id));
		return message;
	}

	// 添加用户
	@ResponseBody
	@RequestMapping("userManage/getAuthorizationById")
	public AuthorizationDo getAuthorizationById(@RequestParam("id") Integer id) {
		return service.getAuthorizationById(id);
	}

	// 设置权限
	@ResponseBody
	@RequestMapping("userManage/setPower")
	public JSONObject setPower(AuthorizationDo authorizationDo) {
		JSONObject message = new JSONObject();
		if (authorizationDo.getUser_id() == null || authorizationDo.getUser_id() == 0) {
			message.put("code", -1);//id不可为空
			return message;
		}

		message.put("code", service.updateAuthorization(authorizationDo));
		return message;
	}
}
