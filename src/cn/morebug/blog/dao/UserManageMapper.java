package cn.morebug.blog.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.morebug.blog.bean.UserDo;

public interface UserManageMapper {
	public List<UserDo> paging_query(@Param("possible_username")String possible_username,@Param("possible_nickname")String possible_nickname);
	public Long deleteUser(Integer id);
}
