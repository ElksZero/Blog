package cn.morebug.blog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;

import cn.morebug.blog.bean.ArticleVo;
import cn.morebug.blog.service.ArticleManageService;
import cn.morebug.blog.service.ArticleService;
import cn.morebug.blog.service.ArticleTypesManageService;

@Controller
public class IndexController {
	@Autowired
	private ArticleManageService service;
	@Autowired 
	private ArticleTypesManageService articleTypesManageService;
	@RequestMapping("/")
	public ModelAndView toIndex(@RequestParam(name = "pageNum", defaultValue = "1", required = false) Integer pageNum,
			@RequestParam(name = "possible_title", defaultValue = "", required = false) String possible_title,
			@RequestParam(name = "possible_type", defaultValue = "", required = false) String type,
			@RequestParam(name = "possible_author", defaultValue = "", required = false) String possible_author) {
//		System.out.println("pageNum: " + pageNum + ";possible_title: " + possible_title + ";possible_type: " + type
//				+ ";possible_author: " + possible_author);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("showArticles");

		String title = possible_title;
		String author = possible_author;
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
		if (possible_author.equals("")) {
			possible_author = null;
		}else {
			possible_author = "%" + possible_author + "%";
		}
		PageInfo<ArticleVo> pageInfo = new PageInfo<ArticleVo>(service.paging_query(pageNum, 10, possible_title, type, possible_author));
//		for(ArticleVo vo:pageInfo.getList()) {
//			System.out.println(vo.toString());
//		}
		modelAndView.addObject("types", articleTypesManageService.getAll());
		modelAndView.addObject("pageInfo", pageInfo);
		modelAndView.addObject("possible_title", title);
		modelAndView.addObject("possible_type", type);
		modelAndView.addObject("possible_author", author);
		
		return modelAndView;
	}
}
