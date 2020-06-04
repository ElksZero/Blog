USE Blog;
--用户表
CREATE TABLE db_users (
  id INT NOT NULL IDENTITY(1,1),--id:自增
  username NVARCHAR(50) NOT NULL,--用户名
  nickname NVARCHAR(50) NOT NULL,--用户昵称
  password NVARCHAR(255) NOT NULL,--加密密码
  email NVARCHAR(50) DEFAULT NULL,--电子邮箱
  mobile_num NVARCHAR(20) DEFAULT NULL,--手机号码
  register_date DATETIME DEFAULT NULL,--注册时间
  PRIMARY KEY (id)
) 
--权限表
CREATE TABLE db_authorizations (
  user_id INT NOT NULL,--用户id兼主键
  write INT DEFAULT 0,--写文章的权限
  comment  INT DEFAULT 0,--写评论的权限
  labelSet INT DEFAULT 0,--标签管理权限
  typeSet INT DEFAULT 0,--类别管理权限
  articleSet INT DEFAULT 0,--文章管理权限
  commentSet INT DEFAULT 0,--评论管理权限
  userSet INT DEFAULT 0,--用户管理权限
  PRIMARY KEY (user_id),
  FOREIGN KEY(user_id) REFERENCES  db_users(id)
) 
--分类表
CREATE TABLE db_types(
  id INT NOT NULL IDENTITY(1,1),--id:自增
  name NVARCHAR(50) NOT NULL,--分类名称
  describe NVARCHAR(255) DEFAULT NULL,--分类描述
  PRIMARY KEY(id)
)
--标签表
CREATE TABLE db_labels(
  id INT NOT NULL IDENTITY(1,1),--id:自增
  name NVARCHAR(50) NOT NULL --标签名称
  PRIMARY KEY(id)
)
--文章表
CREATE TABLE db_articles(
  id INT NOT NULL IDENTITY(1,1),--id:自增
  title NVARCHAR(50) NOT NULL,--文章标题
  type_id INT,--文章类别
  author_id INT,--发表用户：作者
  status INT NOT NULL DEFAULT 0,--文章当前状态
  content NVARCHAR(MAX),--文章内容
  createDate DATETIME,--创建时间
  updateDate DATETIME,--最近更新时间
  publishDate DATETIME,--发布时间
  checker_id INT--审核员
  PRIMARY KEY(id),
  FOREIGN KEY(type_id) REFERENCES  db_types(id),
  FOREIGN KEY(author_id) REFERENCES  db_users(id),
  FOREIGN KEY(checker_id) REFERENCES  db_users(id)
)
--文章标签关系表
CREATE TABLE db_article_label(
  id INT NOT NULL IDENTITY(1,1),--id:自增
  article_id INT NOT NULL,--文章id
  label_id INT NOT NULL,--标签id
  PRIMARY KEY(id),
  FOREIGN KEY(article_id) REFERENCES  db_articles(id),
  FOREIGN KEY(label_id) REFERENCES  db_labels(id)
)
--评论表
CREATE TABLE db_comments(
  id INT NOT NULL IDENTITY(1,1),--id:自增
  article_id INT NOT NULL,--文章id
  commenter_id INT NOT NULL,--评论用户
  content NVARCHAR(150),--评论内容
  status INT NOT NULL DEFAULT 0,--评论当前状态
  submitDate DATETIME,--提交时间
  publishDate DATETIME,--发布时间
  checker_id INT--审核员，
  PRIMARY KEY(id),
  FOREIGN KEY(article_id) REFERENCES  db_articles(id),
  FOREIGN KEY(checker_id) REFERENCES  db_users(id)
)



insert into db_users values('Elkszero','Elkszero','4F8F66946DFD8C176DC6BECF51B54A15','15895261466@163.com',15895261466,NULL)
insert into db_authorizations values(1,1,1,1,1,1,1)




