package cn.morebug.blog.dao;

import cn.morebug.blog.bean.UserDo;

public interface UserMapper {
	
	public Long addUser(UserDo userDo);
	public UserDo getUserByUsername(String username);
	public UserDo getUserByMobile_num(String mobile_num);
	public UserDo getUserByEmail(String email);
	public UserDo getUserById(Integer id);
	public Long updateUserInfo(UserDo userDo);
	public Long updateUserPwd(UserDo userDo);
}
