package cn.morebug.blog.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import cn.morebug.blog.bean.ArticleVo;
import cn.morebug.blog.dao.ArticleMapper;
import cn.morebug.blog.dao.CommentMapper;

@Service
public class ArticleManageService {
	
	@Autowired
	private ArticleMapper articleMapper;
	@Autowired
	private UserService userService;
	@Autowired
	private MyArticleManageService myArticleManageService;
	@Autowired 
	private CommentMapper commentMapper;
	
	public List<ArticleVo> paging_query(Integer pageNum,Integer pageSize,String possible_title,String type,String username){
		Page<Object> page = PageHelper.startPage(pageNum, pageSize);
		List<ArticleVo> articles = articleMapper.paging_query(possible_title, type, username);
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
	
	public List<ArticleVo> paging_queryAll(Integer pageNum,Integer pageSize,String possible_title,String type,String username){
		Page<Object> page = PageHelper.startPage(pageNum, pageSize);
		List<ArticleVo> articles = articleMapper.paging_queryAll(possible_title, type, username);
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
		//先删除文章所有评论
		commentMapper.deleteCommentByArticleId(id);
		//再删除文章
		return myArticleManageService.deleteArticle(id);
	}
	
	public Integer publishArticle(Integer id,Integer checker_id,Date publishDate) {
//		System.out.println(publishDate);
		if(articleMapper.publishArticle(id, checker_id,publishDate) == 0)
			return -2;//发布失败
		return 1;//发布成功
	}
	public Integer revokeArticle(Integer id,Integer checker_id) {
		if(articleMapper.revokeArticle(id, checker_id) == 0)
			return -2;//撤销失败
		return 1;//撤销成功
	}
}
