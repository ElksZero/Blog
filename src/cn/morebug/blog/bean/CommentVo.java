package cn.morebug.blog.bean;

import java.util.Date;

public class CommentVo {
	private Integer id;
	private Integer article_id;
	private String article_title;
	private Integer commenter_id;
	private String commenter_username;
	private String content;
	private Integer status;//评论状态码，0为未通过审核，1为审核通过
	private Date submitDate;
	private Date publishDate;
	private Integer checker_id;
	private String checker_username;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getArticle_id() {
		return article_id;
	}
	public void setArticle_id(Integer article_id) {
		this.article_id = article_id;
	}
	public String getArticle_title() {
		return article_title;
	}
	public void setArticle_title(String article_title) {
		this.article_title = article_title;
	}
	public Integer getCommenter_id() {
		return commenter_id;
	}
	public void setCommenter_id(Integer commenter_id) {
		this.commenter_id = commenter_id;
	}
	public String getCommenter_username() {
		return commenter_username;
	}
	public void setCommenter_username(String commenter_username) {
		this.commenter_username = commenter_username;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getSubmitDate() {
		return submitDate;
	}
	public void setSubmitDate(Date submitDate) {
		this.submitDate = submitDate;
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
		return "CommentVo [id=" + id + ", article_id=" + article_id + ", article_title=" + article_title
				+ ", commenter_id=" + commenter_id + ", commenter_username=" + commenter_username + ", content="
				+ content + ", status=" + status + ", submitDate=" + submitDate + ", publishDate=" + publishDate
				+ ", checker_id=" + checker_id + ", checker_username=" + checker_username + "]";
	}
	
	
}
