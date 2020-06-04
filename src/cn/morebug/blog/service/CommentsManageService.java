package cn.morebug.blog.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import cn.morebug.blog.bean.CommentDo;
import cn.morebug.blog.bean.CommentVo;
import cn.morebug.blog.dao.CommentMapper;

@Service
public class CommentsManageService {

	@Autowired 
	private CommentMapper commentMapper;
	@Autowired
	private UserService userService;
	
	public Integer submitComment(CommentDo commentDo) {
		if(commentMapper.submitComment(commentDo) == 0)
			return -1;
		return 1;
	}
	
	public List<CommentVo> paging_query(Integer pageNum,Integer pageSize,String possible_title,String possible_commenter){
		Page<Object> page = PageHelper.startPage(pageNum, pageSize);
		List<CommentVo> comments = commentMapper.paging_query(possible_title, possible_commenter);
		if(comments.size() == 0)
			return null;
		return comments;
	}
	
	public CommentVo getCommentById(Integer id) {
		CommentVo comment = commentMapper.getCommentById(id);
		Integer checker_id = comment.getChecker_id();
		if( checker_id != null && checker_id != 0) {
			comment.setChecker_username(userService.getUserDoById(checker_id).getUsername());
		}
		return comment;
	}
	

	public Integer publishComment(Integer id,Integer checker_id,Date publishDate) {
//		System.out.println(publishDate);
		if(commentMapper.publishComment(publishDate, checker_id, id) == 0)
			return -2;//发布失败
		return 1;//发布成功
	}
	
	public Integer revokeComment(Integer id) {
		if(commentMapper.revokeComment(id) == 0)
			return -2;//撤销失败
		return 1;//撤销成功
	}
	
	public Integer deleteComment(Integer id) {
		if(commentMapper.deleteComment(id) == 0)
			return -2;//撤销失败
		return 1;//撤销成功
	}
	
	public List<CommentVo> paging_queryForArticle(Integer pageNum,Integer pageSize,Integer article_id){
		Page<Object> page = PageHelper.startPage(pageNum, pageSize);
		List<CommentVo> comments = commentMapper.paging_queryForArticle(article_id);
		if(comments.size() == 0)
			return null;
		return comments;
	}
}
