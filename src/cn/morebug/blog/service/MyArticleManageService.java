package cn.morebug.blog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import cn.morebug.blog.bean.ArticleDo;
import cn.morebug.blog.bean.ArticleVo;
import cn.morebug.blog.bean.UserDo;
import cn.morebug.blog.dao.ArticleMapper;
import cn.morebug.blog.dao.MyArticleMapper;

@Service
public class MyArticleManageService {
	
	@Autowired
	private MyArticleMapper myArticleMapper;
	@Autowired
	private UserService userService;
	
	public List<ArticleVo> paging_query(Integer pageNum,Integer pageSize,String possible_title,String type,Integer user_id){
		Page<Object> page = PageHelper.startPage(pageNum, pageSize);
		List<ArticleVo> articles = myArticleMapper.paging_query(possible_title, type,user_id);
		for(ArticleVo articleVo:articles) {
			Integer checker_id = articleVo.getChecker_id();
			if(checker_id != null) {//审核员id不为null的话
				articleVo.setChecker_username(userService.getUserDoById(checker_id).getUsername());
			}
		}
		if(articles.size() == 0)//user列表为空，即没有查询到
			return null;
		return articles;
	}
	
	public Integer deleteArticle(Integer id) {
		if(myArticleMapper.deleteArticle(id) == 0)
			return -2;//删除失败
		return 1;//删除成功
	}
}
