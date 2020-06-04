package cn.morebug.blog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import aj.org.objectweb.asm.Label;
import cn.morebug.blog.bean.ArticleLabelDo;
import cn.morebug.blog.dao.ArticleLabelMapper;

@Service
public class ArticleLabelsManageService {
	@Autowired
	private ArticleLabelMapper articleLabelMapper;
	//分页查询
	public List<ArticleLabelDo> paging_query(Integer pageNum,Integer pageSize,String possible_names){
		//设置当前页码以及每页记录条数
		Page<Object> page = PageHelper.startPage(pageNum, pageSize);
		List<ArticleLabelDo> labels = articleLabelMapper.paging_query(possible_names);		
		if(labels.size() == 0) {
			return null;
		}
		return  labels;
	}
	//添加标签
	public Integer addLabel(ArticleLabelDo articleLabelDo) {
		if(articleLabelMapper.getLabelByName(articleLabelDo.getName()) != null)
			return -2;//标签已存在
		if(articleLabelMapper.addLabel(articleLabelDo) == 0)
			return -3;//添加失败
		return 1;
	}
	//根据id获取标签
	public ArticleLabelDo getLabelById(Integer id) {
		return articleLabelMapper.getLabelById(id);
	}
	
	//修改标签
	public Integer updateLabel(ArticleLabelDo articleLabelDo) {
		if(articleLabelMapper.getLabelByName(articleLabelDo.getName()) != null)
			return -3;//该标签已存在
		if(articleLabelMapper.updateLabel(articleLabelDo) == 0)
			return -4;//修改失败
		return 1;//修改成功
	}
	//删除标签
	public Integer deleteLabel(Integer id) {
		if(articleLabelMapper.deleteLabel(id) == 0) 
			return -2;//删除失败
		return 1;//删除成功
	}
}
