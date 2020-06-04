package cn.morebug.blog.controller;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;

import cn.morebug.blog.bean.CommentDo;
import cn.morebug.blog.bean.CommentVo;
import cn.morebug.blog.bean.UserVo;
import cn.morebug.blog.service.CommentsManageService;
import cn.morebug.blog.util.MD5Util;
import net.sf.json.JSONObject;

@RequestMapping("manage")
@Controller
public class CommentsManageController {
	
	@Autowired
	private CommentsManageService service;
	
	@RequestMapping("articleCommentsManage")
	public ModelAndView toArticleCommentsManage(@RequestParam(name = "pageNum", defaultValue = "1", required = false) Integer pageNum,
			@RequestParam(name = "possible_title", defaultValue = "", required = false) String possible_title,
			@RequestParam(name = "possible_commenter", defaultValue = "", required = false) String possible_commenter) {
		ModelAndView modelAndView = new ModelAndView();
		// 设置视图
		modelAndView.setViewName("manage/articleCommentsManage");
		
		String title = possible_title;
		String commenter = possible_commenter;
		// 若未提供查询条件，则将其设置为null
		// 拼接模糊成为查询
		if (possible_title.equals("")) {
			possible_title = null;
		} else {
			possible_title = "%" + possible_title + "%";
		}
		if (possible_commenter.equals("")) {
			possible_commenter = null;
		} else {
			possible_commenter = "%" + possible_commenter + "%";
		}
		PageInfo<CommentVo> pageInfo  = new PageInfo<CommentVo>(service.paging_query(pageNum, 10, possible_title, possible_commenter));
//		for(CommentVo vo :pageInfo.getList()) {
//			System.out.println(vo.toString());
//		}
		modelAndView.addObject("pageInfo", pageInfo);
		modelAndView.addObject("possible_title", title);
		modelAndView.addObject("possible_commenter", commenter);
		return modelAndView;
	}
	
	@ResponseBody
	@RequestMapping("submitComment")
	public JSONObject submitComment(HttpSession session,CommentDo commentDo,@RequestParam("pwd")String pwd) {
		JSONObject message = new JSONObject();
		UserVo userVo = (UserVo)session.getAttribute("userVo");
		if(!MD5Util.getMD5String(pwd).equals(userVo.getPassword())) {
			message.put("code", -1);//密码错误
			return message;
		}
		commentDo.setCommenter_id(userVo.getId());
		commentDo.setStatus(0);
		commentDo.setSubmitDate(new Date());
		message.put("code",service.submitComment(commentDo));
		return message;
	}
	
	@ResponseBody
	@RequestMapping("articleCommentsManage/getCommentById")
	public CommentVo getCommentById(@RequestParam("id")Integer id) {
//		JSONObject message = new JSONObject();
		CommentVo comment = service.getCommentById(id);
//		System.out.println(comment.toString());
//		message.put("comment", comment);
		return comment;
	}

	
	@ResponseBody
	@RequestMapping("articleCommentsManage/publishComment")
	public JSONObject publishComment(HttpSession session,@RequestParam("id")Integer id) {
		UserVo userVo = (UserVo)session.getAttribute("userVo");
		
		JSONObject message = new JSONObject();
		if(id == null || id == 0) {
			message.put("code",-1);//id不可为空
			return message;
		}
		//返回值作为状态码
		message.put("code",service.publishComment(id, userVo.getId(),new Date()));
		return message;
	}
	
	
	@ResponseBody
	@RequestMapping("articleCommentsManage/revokeComment")
	public JSONObject revokeComment(@RequestParam("id")Integer id) {
		JSONObject message = new JSONObject();
		if(id == null || id == 0) {
			message.put("code",-1);//id不可为空
			return message;
		}
		//返回值作为状态码
		message.put("code",service.revokeComment(id));
		return message;
	}
	
	@ResponseBody
	@RequestMapping("articleCommentsManage/deleteComment")
	public JSONObject deleteComment(@RequestParam("id")Integer id) {
		JSONObject message = new JSONObject();
		if(id == null || id == 0) {
			message.put("code",-1);//id不可为空
			return message;
		}
		//返回值作为状态码
		message.put("code",service.deleteComment(id));
		return message;
	}
}
