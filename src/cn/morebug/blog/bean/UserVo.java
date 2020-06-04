package cn.morebug.blog.bean;

import java.util.Date;

public class UserVo {
	private Integer id;
	private String username;
	private String nickname;
	private String password;
	private String email;
	private String mobile_num;
	private Date register_date;
	private AuthorizationDo authorization;
	//设置UserDo
	public void setUserDo(UserDo userDo) {
		this.id = userDo.getId();
		this.username = userDo.getUsername();
		this.nickname = userDo.getNickname();
		this.password = userDo.getPassword();
		this.email = userDo.getEmail();
		this.mobile_num = userDo.getMobile_num();
		this.register_date = userDo.getRegister_date();
	}
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
	public AuthorizationDo getAuthorization() {
		return authorization;
	}
	public void setAuthorization(AuthorizationDo authorization) {
		this.authorization = authorization;
	}
	@Override
	public String toString() {
		return "UserVo [id=" + id + ", username=" + username + ", nickname=" + nickname + ", password=" + password
				+ ", email=" + email + ", mobile_num=" + mobile_num + ", register_date=" + register_date
				+ ", authorization=" + authorization + "]";
	}
	
}
