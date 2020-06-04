package cn.morebug.blog.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.morebug.blog.bean.ArticleDo;
import cn.morebug.blog.bean.ArticleLabelDo;
import cn.morebug.blog.bean.ArticleVo;
import cn.morebug.blog.dao.ArticleLabelMapper;
import cn.morebug.blog.dao.ArticleMapper;
import cn.morebug.blog.dao.Article_Label_Mapper;

@Service
public class ArticleService {
	
	@Autowired
	private ArticleMapper articleMapper;
	@Autowired
	private UserService userService;
	@Autowired
	private ArticleLabelMapper articleLabelMapper;
	@Autowired
	private Article_Label_Mapper article_Label_Mapper;
	
	public Integer submitArticle(ArticleDo articleDo,String labels) {
		
		Long flag = articleMapper.submitArticle(articleDo);
		if(flag == 0)
			return -1;

		handleLabels(labels,articleDo.getId());
		return 1;
	}
	
	public Integer updateArticle(ArticleDo articleDo,String labels) {
		
		Long flag = articleMapper.updateArticle(articleDo);
		if(flag == 0)
			return -1;

		handleLabels(labels,articleDo.getId());
		return 1;
	}
	
	public ArticleVo getArticleVoById(Integer id) {
		ArticleVo article = articleMapper.getArticleVoById(id);
		Integer checker_id = article.getChecker_id();
		if(checker_id != null) {
			article.setChecker_username(userService.getUserDoById(checker_id).getUsername());
		}
		return article;
	}
	public ArticleDo getArticleDoById(Integer id) {
		return  articleMapper.getArticleDoById(id) ;
	}
	public String getLabels(Integer article_id) {
		List<String> labels = article_Label_Mapper.get_relation(article_id);
//		System.out.println(labels.size());
		if(labels.size() == 0) {
			return "";
		}
		String label = "";
		for(String s:labels) {
			label += s;
		}
		
		return label;
	}
	
	//处理标签
	private void handleLabels(String labels,Integer article_id) {
		//清空文章标签
		article_Label_Mapper.delete_relation(article_id);
		String[] labelArray = {};
		List<Integer> labelIds = new ArrayList<Integer>();
		if(labels == null || labels.equals(""))
			return;
		labelArray = labels.split(";");
		for(String label:labelArray) {
			//封装成标签对象
			ArticleLabelDo templabel = new ArticleLabelDo();
			templabel.setName(label);
			//查询标签，并判断是否存在
			ArticleLabelDo labelDo = articleLabelMapper.getLabelByName(label);
			if(labelDo == null) {//不存在
				articleLabelMapper.addLabel(templabel);//添加标签
				labelIds.add(templabel.getId());
			}else {//存在
				labelIds.add(labelDo.getId());
			}
		}
		//建立文章与标签的关系
		for(Integer label_id:labelIds) {
			article_Label_Mapper.add_relation(article_id, label_id);
		}
	}
}
