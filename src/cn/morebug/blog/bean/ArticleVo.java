package cn.morebug.blog.bean;

import java.util.Date;

public class ArticleVo {
	private Integer id;//文章id
	private String title;//文章标题
	private Integer type_id;//文章类型id
	private String type_name;//文章类型名称
	private Integer author_id;//作者id
	private String author_username;//作者名称
	private Integer status = 0;//文章状态 0：未完成,1: 已完成,未发布,2: 已完成,已发布
	private String content;//文章内容
	private Date createDate;//创建时间
	private Date updateDate;//最近更新时间
	private Date publishDate;//发布时间
	private Integer checker_id;//审核员id
	private String checker_username;//审核员名称
	
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

	public String getType_name() {
		return type_name;
	}

	public void setType_name(String type_name) {
		this.type_name = type_name;
	}

	public Integer getAuthor_id() {
		return author_id;
	}

	public void setAuthor_id(Integer author_id) {
		this.author_id = author_id;
	}

	public String getAuthor_username() {
		return author_username;
	}

	public void setAuthor_username(String author_username) {
		this.author_username = author_username;
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

	public String getChecker_username() {
		return checker_username;
	}

	public void setChecker_username(String checker_username) {
		this.checker_username = checker_username;
	}

	@Override
	public String toString() {
		return "ArticleVo [id=" + id + ", title=" + title + ", type_id=" + type_id + ", type_name=" + type_name
				+ ", author_id=" + author_id + ", author_username=" + author_username + ", status=" + status
				+ ", content=" + content + ", createDate=" + createDate + ", updateDate=" + updateDate
				+ ", publishDate=" + publishDate + ", checker_id=" + checker_id + ", checker_username="
				+ checker_username + "]";
	}
	
}
