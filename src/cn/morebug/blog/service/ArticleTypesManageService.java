package cn.morebug.blog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.morebug.blog.bean.ArticleTypeDo;
import cn.morebug.blog.dao.ArticleTypeMapper;

@Service
public class ArticleTypesManageService {
	
	@Autowired
	private ArticleTypeMapper articleTypeMapper;
	//分页查询
	public List<ArticleTypeDo> paging_query(Integer pageNum,Integer pageSize,String possible_names){
		//设置当前页码以及每页记录条数
		Page<Object> page = PageHelper.startPage(pageNum, pageSize);
		List<ArticleTypeDo> types = articleTypeMapper.paging_query(possible_names);		
		if(types.size() == 0)
			return null;
		return  types;
	}
	
	public List<ArticleTypeDo> getAll(){
		return articleTypeMapper.getAll();
	}
	
	//添加分类
	public Integer addType(ArticleTypeDo articleTypeDo) {
		if(articleTypeMapper.getArticleTypeDoByName(articleTypeDo.getName()) != null)
			return -2;//分类分类已存在
		if(articleTypeMapper.addType(articleTypeDo) == 0)
			return -3;//添加失败
		return 1;//添加成功
	}
	//通过id获取分类
	public ArticleTypeDo getArticleTypeById(Integer id) {
		return articleTypeMapper.getArticleTypeById(id);
	}
	//更新分类信息
	public Integer updateType(ArticleTypeDo articleTypeDo) {
		if(articleTypeMapper.getArticleTypeDoByName(articleTypeDo.getName()) != null)
			return -3;//分类已存在
		if(articleTypeMapper.updateType(articleTypeDo) == 0)
			return -4;//修改失败
		return 1;//修改成功
	}
	public Integer deleteType(Integer id) {
		if(articleTypeMapper.deleteType(id) == 0) 
			return -2;//删除失败
		return 1;//删除成功
	}
}
