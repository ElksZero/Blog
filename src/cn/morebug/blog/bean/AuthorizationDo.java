package cn.morebug.blog.bean;

public class AuthorizationDo {
	private Integer user_id;//id
	private Integer write = 0;//写文章的权限
	private Integer comment = 0;//写评论的权限
	private Integer labelSet = 0;//标签管理权限
	private Integer  typeSet = 0;//分类管理权限
	private Integer  articleSet = 0;//文章管理权限
	private Integer  commentSet = 0;//评论管理权限
	private Integer  userSet = 0;//用户管理权限
	public Integer getWrite() {
		return write;
	}
	public void setWrite(Integer write) {
		this.write = write;
	}
	public Integer getComment() {
		return comment;
	}
	public void setComment(Integer comment) {
		this.comment = comment;
	}
	public Integer getLabelSet() {
		return labelSet;
	}
	public void setLabelSet(Integer labelSet) {
		this.labelSet = labelSet;
	}
	public Integer getTypeSet() {
		return typeSet;
	}
	public void setTypeSet(Integer typeSet) {
		this.typeSet = typeSet;
	}
	public Integer getArticleSet() {
		return articleSet;
	}
	public void setArticleSet(Integer articleSet) {
		this.articleSet = articleSet;
	}
	public Integer getCommentSet() {
		return commentSet;
	}
	public void setCommentSet(Integer commentSet) {
		this.commentSet = commentSet;
	}
	public Integer getUserSet() {
		return userSet;
	}
	public void setUserSet(Integer userSet) {
		this.userSet = userSet;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	@Override
	public String toString() {
		return "Authorization [user_id=" + user_id + ", write=" + write + ", comment=" + comment + ", labelSet="
				+ labelSet + ", typeSet=" + typeSet + ", articleSet=" + articleSet + ", commentSet=" + commentSet
				+ ", userSet=" + userSet + "]";
	}
	
}
