package cn.morebug.blog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;

import cn.morebug.blog.bean.ArticleLabelDo;
import cn.morebug.blog.bean.ArticleTypeDo;
import cn.morebug.blog.service.ArticleLabelsManageService;
import net.sf.json.JSONObject;

@RequestMapping("manage")
@Controller
public class ArticleLabelsManageController {

	@Autowired
	private ArticleLabelsManageService service;

	// 分页查询展示
	@RequestMapping("articleLabelsManage")
	public ModelAndView toArticleLabelsManage(
			@RequestParam(name = "pageNum", defaultValue = "1", required = false) Integer pageNum,
			@RequestParam(name = "possible_names", defaultValue = "", required = false) String possible_names) {
		ModelAndView modelAndView = new ModelAndView("manage/articleLabelsManage");
		if (possible_names.equals("")) {// 如果没有传递possible_names，则使其默认值为null
			possible_names = null;
		}
		PageInfo<ArticleLabelDo> pageInfo = new PageInfo<ArticleLabelDo>(
				service.paging_query(pageNum, 10, possible_names));
		modelAndView.addObject("pageInfo", pageInfo);
		modelAndView.addObject("possible_names", possible_names);
		return modelAndView;
	}

	// 添加分类
	@ResponseBody
	@RequestMapping("articleLabelsManage/addLabel")
	public JSONObject addType(ArticleLabelDo articleLabelDo) {
		JSONObject message = new JSONObject();
		if (articleLabelDo.getName() == null || articleLabelDo.getName().equals("")) {
			message.put("code", -1);// 标签名称不可为空
			return message;
		}
		// 添加分类，返回值设置为code状态码
		message.put("code", service.addLabel(articleLabelDo));
		return message;
	}
	//根据id获取标签
	@ResponseBody
	@RequestMapping("articleLabelsManage/getLabelById")
	public JSONObject getLabelById(@RequestParam("id") Integer id) {
		JSONObject message = new JSONObject();
		message.put("label", service.getLabelById(id));
		return message;
	}
	//修改标签
	@ResponseBody
	@RequestMapping("articleLabelsManage/updateLabel")
	public JSONObject updateLabel(ArticleLabelDo articleLabelDo) {
		JSONObject message = new JSONObject();
		if(articleLabelDo.getId() == null || articleLabelDo.getId() == 0) {
			message.put("code", -1);//标签i不可为空
			return message;
		}
		if(articleLabelDo.getName() == null || articleLabelDo.getName().equals("")) {
			message.put("code", -2);//标签名不可为空
			return message;
		}
		message.put("code", service.updateLabel(articleLabelDo));
		return message;
	}
	
	@ResponseBody
	@RequestMapping("articleLabelsManage/deleteLabel")
	public JSONObject deleteLabel(@RequestParam("id")Integer id) {
		JSONObject message = new JSONObject();
		if(id == null || id == 0) {
			message.put("code", -1);//标签i不可为空
			return message;
		}
		message.put("code", service.deleteLabel(id));
		return message;
	}
}
