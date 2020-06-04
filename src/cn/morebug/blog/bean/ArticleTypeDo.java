package cn.morebug.blog.bean;

public class ArticleTypeDo {
	
	private Integer id;//分类id
	private String name;//分类名称
	private String describe;//分类描述
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	@Override
	public String toString() {
		return "ArticleTypeDo [id=" + id + ", name=" + name + ", describe=" + describe + "]";
	}
	
}
