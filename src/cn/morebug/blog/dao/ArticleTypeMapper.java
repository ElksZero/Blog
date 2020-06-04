package cn.morebug.blog.dao;

import java.util.List;

import cn.morebug.blog.bean.ArticleTypeDo;

public interface ArticleTypeMapper {
	public List<ArticleTypeDo> paging_query(String possible_names);
	public ArticleTypeDo getArticleTypeDoByName(String articleTypeName);
	public Long addType(ArticleTypeDo articleTypeDo);
	public ArticleTypeDo getArticleTypeById(Integer id);
	public Long updateType(ArticleTypeDo articleTypeDo);
	public Long deleteType(Integer id);
	public List<ArticleTypeDo> getAll();
}
