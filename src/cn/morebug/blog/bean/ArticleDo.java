package cn.morebug.blog.bean;

import java.util.Date;

public class ArticleDo {
	private Integer id;//文章id
	private String title;//文章标题
	private Integer type_id;//文章类型id
	private Integer author_id;//作者id
	private Integer status = 0;//文章状态 0：未完成,1: 已完成,未发布,2: 已完成,已发布
	private String content;//文章内容
	private Date createDate;//创建时间
	private Date updateDate;//最近更新时间
	private Date publishDate;//发布时间
	private Integer checker_id;//审核员id
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getType_id() {
		return type_id;
	}
	public void setType_id(Integer type_id) {
		this.type_id = type_id;
	}
	public Integer getAuthor_id() {
		return author_id;
	}
	public void setAuthor_id(Integer author_id) {
		this.author_id = author_id;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public Date getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}
	public Integer getChecker_id() {
		return checker_id;
	}
	public void setChecker_id(Integer checker_id) {
		this.checker_id = checker_id;
	}
	@Override
	public String toString() {
		return "ArticleDo [id=" + id + ", title=" + title + ", type_id=" + type_id + ", author_id=" + author_id
				+ ", status=" + status + ", content=" + content + ", createDate=" + createDate + ", updateDate="
				+ updateDate + ", publishDate=" + publishDate + ", checker_id=" + checker_id + "]";
	}
	
}
