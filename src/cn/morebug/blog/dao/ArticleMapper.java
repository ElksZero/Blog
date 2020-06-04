package cn.morebug.blog.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sun.org.glassfish.gmbal.ParameterNames;

import cn.morebug.blog.bean.ArticleDo;
import cn.morebug.blog.bean.ArticleVo;

public interface ArticleMapper {
	
	public Long submitArticle(ArticleDo articleDo);
	public Long updateArticle(ArticleDo articleDo);
	
	public ArticleVo getArticleVoById(Integer id);
	public ArticleDo getArticleDoById(Integer id);
	
	public List<ArticleVo> paging_query(@Param("possible_title") String possible_title,
			@Param("type_id")String type_id,@Param("author_name")String author_name);
	
	public List<ArticleVo> paging_queryAll(@Param("possible_title") String possible_title,
			@Param("type_id")String type_id,@Param("author_name")String author_name);
	
	public Long publishArticle(@Param("id")Integer id,@Param("checker_id")Integer checker_id,@Param("publishDate")Date publishDate);
	public Long revokeArticle(@Param("id")Integer id,@Param("checker_id")Integer checker_id);
}
