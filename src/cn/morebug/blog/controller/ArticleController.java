package cn.morebug.blog.controller;

import java.io.UnsupportedEncodingException;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;

import cn.morebug.blog.bean.ArticleDo;
import cn.morebug.blog.bean.ArticleVo;
import cn.morebug.blog.bean.CommentVo;
import cn.morebug.blog.bean.UserVo;
import cn.morebug.blog.exception.showArticleException;
import cn.morebug.blog.service.ArticleService;
import cn.morebug.blog.service.ArticleTypesManageService;
import cn.morebug.blog.service.CommentsManageService;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("article")
public class ArticleController {
	@Autowired
	private ArticleService service;
	@Autowired
	private ArticleTypesManageService articleTypesManageService;
	@Autowired
	private CommentsManageService commentsManageService;
	//映射跳转到新建文章编辑页面
	@RequestMapping("edit")
	public ModelAndView toEdit() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("article/edit");
		modelAndView.addObject("types", articleTypesManageService.getAll());
		return modelAndView;
	}
	//映射跳转到已有文章编辑页面
	@RequestMapping("edit/{id}")
	public ModelAndView toEdit(HttpSession session, @PathVariable("id") Integer id) {
		UserVo userVo = (UserVo) session.getAttribute("userVo");// 获取用户信息
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("article/edit");
		modelAndView.addObject("types", articleTypesManageService.getAll());
		ArticleVo article = service.getArticleVoById(id);
		
		if (userVo == null) {// 用户没有登录
			throw new showArticleException();
		}
		if (userVo.getAuthorization().getArticleSet() == 0 && userVo.getId() != article.getAuthor_id()) {
			// 如果没有文章管理权限，且不是作者本人
			throw new showArticleException();
		}
//		System.out.println(article.getContent());
		modelAndView.addObject("article", article);// 设置模型
		modelAndView.addObject("labels", service.getLabels(id));//标签
		return modelAndView;
	}
	//映射跳转到已有文章展示页面
	@RequestMapping("show/{id}")
	public ModelAndView toShow(HttpSession session, @PathVariable("id") Integer id,
			@RequestParam(name="pageNum",defaultValue = "1",required=false) Integer pageNum) {
		UserVo userVo = (UserVo) session.getAttribute("userVo");// 获取用户信息
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("article/show");// 设置视图
		ArticleVo article = service.getArticleVoById(id);
		if (article.getStatus() != 2) {// 如果文章未发布
			if (userVo == null) {// 且用户没有登录
				throw new showArticleException();
			}
			if (userVo.getAuthorization().getArticleSet() == 0 && userVo.getId() != article.getAuthor_id()) {
				// 如果没有文章管理权限，且不是作者本人
				throw new showArticleException();
			}
		}
//		System.out.println(article.getContent());
		//获取该文章评论
		PageInfo<CommentVo> pageInfo = new PageInfo<CommentVo>(commentsManageService.paging_queryForArticle(pageNum, 10, article.getId()));
//		if(pageInfo.getList() != null) {
//			for(CommentVo vo:pageInfo.getList()) {
//				System.out.println(vo.toString());
//			}
//		}
		modelAndView.addObject("pageInfo", pageInfo);
		modelAndView.addObject("article", article);// 设置模型
		return modelAndView;
	}
	//提交文章(新建文章提交)
	@ResponseBody
	@RequestMapping(value = "submitArticle", method = RequestMethod.POST)
	public JSONObject submitArticle(HttpSession session, ArticleDo articleDo,
			@RequestParam(name = "labels", defaultValue = "", required = false) String labels)
			throws UnsupportedEncodingException {

		UserVo userVo = (UserVo) session.getAttribute("userVo");
		articleDo.setAuthor_id(userVo.getId());// 获取用户id
		articleDo.setCreateDate(new Date());
		articleDo.setUpdateDate(new Date());
		articleDo.setStatus(1);// 状态变为已完成,未发布
		JSONObject message = new JSONObject();
		message.put("code", service.submitArticle(articleDo,labels));
		return message;
	}
	//提交文章(已有文章提交修改)
	@ResponseBody
	@RequestMapping(value = "submitArticle/{id}", method = RequestMethod.POST)
	public JSONObject submitExistingArticle(@PathVariable("id")Integer id,ArticleDo articleDo,
			@RequestParam(name = "labels", defaultValue = "", required = false) String labels)
			throws UnsupportedEncodingException {
		ArticleDo oldArticle =  service.getArticleDoById(id);//获取原本文章
		oldArticle.setUpdateDate(new Date());
		oldArticle.setStatus(1);// 状态变为已完成,未发布
		oldArticle.setTitle(articleDo.getTitle());//修改文章标题
		oldArticle.setType_id(articleDo.getType_id());//修改文章类型
		oldArticle.setContent(articleDo.getContent());//修改内容
		JSONObject message = new JSONObject();
		message.put("code", service.updateArticle(oldArticle,labels));
		return message;
	}
	//保存文章(新建文章保存)
	@ResponseBody
	@RequestMapping(value = "saveArticle", method = RequestMethod.POST)
	public JSONObject saveArticle(HttpSession session, ArticleDo articleDo,
			@RequestParam(name = "labels", defaultValue = "", required = false) String labels)
			throws UnsupportedEncodingException {
		UserVo userVo = (UserVo) session.getAttribute("userVo");
		articleDo.setAuthor_id(userVo.getId());// 获取用户id
		articleDo.setCreateDate(new Date());
		articleDo.setUpdateDate(new Date());
		articleDo.setStatus(0);// 状态变为未完成,未发布
		JSONObject message = new JSONObject();
		message.put("code", service.submitArticle(articleDo,labels));
		return message;
	}
	//保存文章(已有文章保存修改)
	@ResponseBody
	@RequestMapping(value = "saveArticle/{id}", method = RequestMethod.POST)
	public JSONObject saveArticle(@PathVariable("id")Integer id, ArticleDo articleDo,
			@RequestParam(name = "labels", defaultValue = "", required = false) String labels)
			throws UnsupportedEncodingException {
		ArticleDo oldArticle =  service.getArticleDoById(id);//获取原本文章
		oldArticle.setUpdateDate(new Date());
		oldArticle.setStatus(0);// 状态变为未完成,未发布
		oldArticle.setTitle(articleDo.getTitle());//修改文章标题
		oldArticle.setType_id(articleDo.getType_id());//修改文章类型
		oldArticle.setContent(articleDo.getContent());//修改内容
		JSONObject message = new JSONObject();
		message.put("code", service.updateArticle(oldArticle,labels));
		return message;
	}
}
