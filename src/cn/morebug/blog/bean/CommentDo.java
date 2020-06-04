package cn.morebug.blog.bean;

import java.util.Date;

public class CommentDo {
	private Integer id;
	private Integer article_id;
	private Integer commenter_id;
	private String content;
	private Integer status;//评论状态码，0为未通过审核，1为审核通过
	private Date submitDate;
	private Date publishDate;
	private Integer checker_id;
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
	public Integer getCommenter_id() {
		return commenter_id;
	}
	public void setCommenter_id(Integer commenter_id) {
		this.commenter_id = commenter_id;
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
	@Override
	public String toString() {
		return "ArticleCommentDo [id=" + id + ", article_id=" + article_id + ", commenter_id=" + commenter_id
				+ ", content=" + content + ", status=" + status + ", submitDate=" + submitDate + ", publishDate="
				+ publishDate + ", checker_id=" + checker_id + "]";
	}
	
}
