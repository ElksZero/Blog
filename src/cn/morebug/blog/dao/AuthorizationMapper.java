package cn.morebug.blog.dao;

import cn.morebug.blog.bean.AuthorizationDo;

public interface AuthorizationMapper {
	//用户注册，生成新用户的权限表
	public Long userRegister(Integer id);
	//根据id获取权限
	public AuthorizationDo getAuthorizationById(Integer id);
	//根据id删除
	public Long deleteAuthorizationById(Integer id);
	
	public Long updateAuthorization(AuthorizationDo authorizationDo);
}
