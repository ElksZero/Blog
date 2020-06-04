package cn.morebug.blog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import cn.morebug.blog.bean.AuthorizationDo;
import cn.morebug.blog.bean.UserDo;
import cn.morebug.blog.dao.AuthorizationMapper;
import cn.morebug.blog.dao.UserManageMapper;

@Service
public class UserManageService {
	
	@Autowired
	private UserManageMapper userManageMapper;
	@Autowired
	private AuthorizationMapper authorizationMapper;
	//分页查询
	public List<UserDo> paging_query(Integer pageNum,Integer pageSize,String possible_username,String possible_nickname){
		//设置当前页码以及每页记录条数
		Page<Object> page = PageHelper.startPage(pageNum, pageSize);
		List<UserDo> users = userManageMapper.paging_query(possible_username, possible_nickname);
		if(users.size() == 0)//user列表为空，即没有查询到
			return null;
		return users;
	}
	
	public Integer deleteUser(Integer id) {
		if(userManageMapper.deleteUser(id) == 0)
			return -2;//删除失败
		if(authorizationMapper.deleteAuthorizationById(id) == 0)
			return -3;//权限子表删除失败
		return 1;//删除成功
	}
	
	public AuthorizationDo getAuthorizationById(Integer id) {
		return authorizationMapper.getAuthorizationById(id);
	}
	
	public Integer updateAuthorization(AuthorizationDo authorizationDo) {
		if(authorizationMapper.updateAuthorization(authorizationDo) == 0)
			return -2;
		return 1;
	}
}
