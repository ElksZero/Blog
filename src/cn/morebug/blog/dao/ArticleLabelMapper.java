package cn.morebug.blog.dao;

import java.util.List;

import cn.morebug.blog.bean.ArticleLabelDo;

public interface ArticleLabelMapper {
	public List<ArticleLabelDo> paging_query(String possible_names);
	public Long addLabel(ArticleLabelDo articleLabelDo);
	public ArticleLabelDo getLabelByName(String name);
	public ArticleLabelDo getLabelById(Integer id);
	public Long updateLabel(ArticleLabelDo articleLabelDo);
	public Long deleteLabel(Integer id);
}
