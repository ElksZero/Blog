package cn.morebug.blog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.morebug.blog.bean.AuthorizationDo;
import cn.morebug.blog.bean.UserDo;
import cn.morebug.blog.bean.UserVo;
import cn.morebug.blog.dao.AuthorizationMapper;
import cn.morebug.blog.dao.UserMapper;
import net.sf.json.JSONObject;

@Service
public class UserService {
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private AuthorizationMapper authorizationMapper;
	//用户注册
	public Integer userRegister(UserDo userDo) {
		//查找改用户名是否存在
		if(userMapper.getUserByUsername(userDo.getUsername()) != null)
			return -1;//用户已存在
		if(userMapper.getUserByMobile_num(userDo.getMobile_num())!= null) 
			return -2;//联系号码已存在
		if(userMapper.getUserByEmail(userDo.getEmail())!= null) 
			return -3;//电子邮箱已存在
		Long flag = userMapper.addUser(userDo);
//		System.out.println(userDo.getId());
		if(flag == 0)
			return -4;//添加失败
//		System.out.println(userDo.getId());
//		System.out.println(authorizationMapper);
		if(authorizationMapper.userRegister(userDo.getId()) == 0)//设置权限表
			return -5;//权限表设置失败
		return 1;//添加成功
	}
	//获取userVo
	public UserVo getUserVo(String username) {
		UserVo userVo = new UserVo();
		//根据用户名获取用户信息
		UserDo userDo = userMapper.getUserByUsername(username);
		if(userDo == null)
			return null;
		userVo.setUserDo(userDo);//设置用户基本信息
//		System.out.println(userDo.toString());
		
		AuthorizationDo authorizationDo = authorizationMapper.getAuthorizationById(userDo.getId());
		if(authorizationDo == null)
			return userVo;
		userVo.setAuthorization(authorizationDo);//用户权限信息
//		System.out.println(authorizationDo.toString());
//		
//		
//		System.out.println(userVo.toString());
		return userVo;
	}
	//更新用户个人信息
	public Integer updateUserInfo(UserDo userDo) {
		Long flag = userMapper.updateUserInfo(userDo);
		if(flag == 0)
			return -1;//修改失败
		return 1;//修改成功
	}
	//通过id获取用户信息
	public UserDo getUserDoById(Integer id) {
		return userMapper.getUserById(id);
	}
	//更新用户密码
	public Integer updateUserPwd(UserDo userDo) {
		Long flag = userMapper.updateUserPwd(userDo);
		if(flag == 0)
			return -1;//修改失败
		return 1;//修改成功
	}
}
