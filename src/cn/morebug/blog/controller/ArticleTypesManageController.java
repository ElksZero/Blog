package cn.morebug.blog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;

import cn.morebug.blog.bean.ArticleTypeDo;
import cn.morebug.blog.service.ArticleTypesManageService;
import net.sf.json.JSONObject;

@RequestMapping("manage")
@Controller
public class ArticleTypesManageController {
	
	@Autowired
	private ArticleTypesManageService service;
	//标签分页查询展示
	@RequestMapping("articleTypesManage")
	public ModelAndView toArticleTypesManage(@RequestParam(name="pageNum",defaultValue="1",required=false) Integer pageNum,
			@RequestParam(name="possible_names",defaultValue="",required=false) String possible_names) {
		ModelAndView modelAndView = new ModelAndView("manage/articleTypesManage");
//		System.out.println("pageNum : " + pageNum + ";possible_names : " + possible_names);
		if(possible_names.equals("")) {//如果没有传递possible_names，则使其默认值为null
			possible_names = null;
		}
		PageInfo<ArticleTypeDo> pageInfo = new PageInfo<ArticleTypeDo>(service.paging_query(pageNum, 10, possible_names));
//		for(ArticleTypeDo a:pageInfo.getList()) {
//			System.out.println(a.toString());
//		}
		modelAndView.addObject("pageInfo", pageInfo);
		modelAndView.addObject("possible_names",possible_names);
		return modelAndView;
	}
	//添加分类
	@ResponseBody
	@RequestMapping("articleTypesManage/addType")
	public JSONObject addType(ArticleTypeDo articleTypeDo) {
		JSONObject message = new JSONObject();
		if(articleTypeDo.getName() == null || articleTypeDo.getName().equals("")) {
			message.put("code", -1);//分类名称不可为空
			return message;
		}
		if(articleTypeDo.getDescribe() == null || articleTypeDo.getDescribe().equals("")) {
			articleTypeDo.setDescribe("");
		}
		//添加分类，返回值设置为code状态码
		message.put("code", service.addType(articleTypeDo));
		return message;
	}
	//获取分类
	@ResponseBody
	@RequestMapping("articleTypesManage/getArticleTypeById")
	public JSONObject getArticleTypeById(@RequestParam("id")Integer id ) {
		JSONObject message = new JSONObject();
		message.put("type", service.getArticleTypeById(id));
		return message;
	}
	
	
	//修改分类
	@ResponseBody
	@RequestMapping("articleTypesManage/updateType")
	public JSONObject updateType(ArticleTypeDo articleTypeDo ) {
		JSONObject message = new JSONObject();
//		System.out.println(articleTypeDo.toString());
		if(articleTypeDo.getId() == null || articleTypeDo.getId() == 0) {
			message.put("code", -1);//分类id不可为空
			return message;
		}
		if(articleTypeDo.getName() == null || articleTypeDo.getName().equals("")) {
			message.put("code", -2);//分类名称不可为空
			return message;
		}
		if(articleTypeDo.getDescribe() == null || articleTypeDo.getDescribe().equals("")) {
			articleTypeDo.setDescribe("");
		}
		//修改分类，返回值设置为code状态码
		message.put("code", service.updateType(articleTypeDo));
		return message;
	}
	@ResponseBody
	@RequestMapping("articleTypesManage/deleteType")
	public JSONObject deleteType(@RequestParam("id") Integer id) {
		JSONObject message = new JSONObject();
		if(id == null || id == 0) {
			message.put("code", -1);//分类id不可为空
			return message;
		}
		//添加分类，返回值设置为code状态码
				message.put("code", service.deleteType(id));
		return message;
	}
	
	
}
