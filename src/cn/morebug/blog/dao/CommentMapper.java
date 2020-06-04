package cn.morebug.blog.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.morebug.blog.bean.CommentDo;
import cn.morebug.blog.bean.CommentVo;

public interface CommentMapper {
	
	public Long submitComment(CommentDo commentDo);
	public List<CommentVo> paging_query(@Param("possible_title") String possible_title,
			@Param("possible_commenter")String possible_commenter);
	
	public CommentVo getCommentById(Integer id);
	public Long publishComment(@Param("publishDate")Date publishDate,@Param("checker_id")Integer checker_id,@Param("id") Integer id);
	public Long revokeComment(Integer id);
	public Long deleteComment(Integer id);
	public Long deleteCommentByArticleId(Integer article_id);
	
	public List<CommentVo> paging_queryForArticle(@Param("article_id")Integer article_id);
}
