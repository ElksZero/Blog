package cn.morebug.blog.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;

import cn.morebug.blog.bean.ArticleDo;
import cn.morebug.blog.bean.ArticleVo;
import cn.morebug.blog.bean.UserDo;
import cn.morebug.blog.bean.UserVo;
import cn.morebug.blog.service.ArticleTypesManageService;
import cn.morebug.blog.service.MyArticleManageService;
import net.sf.json.JSONObject;

@RequestMapping("manage")
@Controller
public class MyArticleManageController {

	@Autowired
	private MyArticleManageService service;
	@Autowired
	private ArticleTypesManageService articleTypesManageService;

	// 分页查询展示
	@RequestMapping("myArticleManage")
	public ModelAndView myArticleManage(HttpSession session,
			@RequestParam(name = "pageNum", defaultValue = "1", required = false) Integer pageNum,
			@RequestParam(name = "possible_title", defaultValue = "", required = false) String possible_title,
			@RequestParam(name = "possible_type", defaultValue = "", required = false) String type) {
		UserVo userVo = (UserVo) session.getAttribute("userVo");
//			System.out.println(userVo);
		ModelAndView modelAndView = new ModelAndView();
		// 设置视图
		modelAndView.setViewName("manage/myArticleManage");
		
		String title = possible_title;
		// 若未提供查询条件，则将其设置为null
		// 拼接模糊成为查询
		if (possible_title.equals("")) {
			possible_title = null;
		} else {
			possible_title = "%" + possible_title + "%";
		}
		if (type.equals("")) {
			type = null;
		}
//		System.out.println(userVo.getId());
		// 分页信息
		PageInfo<ArticleVo> pageInfo = new PageInfo<ArticleVo>(
				service.paging_query(pageNum, 10, possible_title, type, userVo.getId()));
		// 设置模型
		modelAndView.addObject("pageInfo", pageInfo);
		modelAndView.addObject("possible_title", title);
		modelAndView.addObject("possible_type", type);
		modelAndView.addObject("types", articleTypesManageService.getAll());

		return modelAndView;
	}
	
	@ResponseBody
	@RequestMapping("myArticleManage/deleteArticle")
	public JSONObject deleteArticle(@RequestParam("id")Integer id) {
		JSONObject message = new JSONObject();
		if(id == null || id == 0) {
			message.put("code",-1);//id不可为空
			return message;
		}
		//返回值作为状态码
		message.put("code",service.deleteArticle(id));
		return message;
	}
}
