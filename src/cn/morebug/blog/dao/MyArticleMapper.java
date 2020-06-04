package cn.morebug.blog.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.morebug.blog.bean.ArticleDo;
import cn.morebug.blog.bean.ArticleVo;

public interface MyArticleMapper {
	public List<ArticleVo> paging_query(@Param("possible_title") String possible_title,
			@Param("type_id")String type_id,@Param("author_id")Integer author_id);
	public Long deleteArticle(Integer id);
}
