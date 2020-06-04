package cn.morebug.blog.bean;

import java.util.Date;


public class UserDo {
	private Integer id;//id
	private String username;//用户名
	private String nickname;//昵称
	private String password;//密码
	private String email;//电子邮箱
	private String mobile_num;//联系号码
	private Date register_date;//注册时间
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getId() {
		return id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile_num() {
		return mobile_num;
	}
	public void setMobile_num(String mobile_num) {
		this.mobile_num = mobile_num;
	}
	public Date getRegister_date() {
		return register_date;
	}
	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}
	@Override
	public String toString() {
		return "user [id=" + id + ", username=" + username + ", nickname=" + nickname + ", password=" + password
				+ ", email=" + email + ", mobile_num=" + mobile_num + ", register_date=" + register_date + "]";
	}
	
}
