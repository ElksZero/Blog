package cn.morebug.blog.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface Article_Label_Mapper {
	
	public Long add_relation(@Param("article_id") Integer article_id,@Param("label_id") Integer label_id);
	public Long delete_relation(@Param("article_id") Integer article_id);
	public List<String> get_relation(@Param("article_id") Integer article_id);
}
