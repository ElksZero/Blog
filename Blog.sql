USE Blog;
--�û���
CREATE TABLE db_users (
  id INT NOT NULL IDENTITY(1,1),--id:����
  username NVARCHAR(50) NOT NULL,--�û���
  nickname NVARCHAR(50) NOT NULL,--�û��ǳ�
  password NVARCHAR(255) NOT NULL,--��������
  email NVARCHAR(50) DEFAULT NULL,--��������
  mobile_num NVARCHAR(20) DEFAULT NULL,--�ֻ�����
  register_date DATETIME DEFAULT NULL,--ע��ʱ��
  PRIMARY KEY (id)
) 
--Ȩ�ޱ�
CREATE TABLE db_authorizations (
  user_id INT NOT NULL,--�û�id������
  write INT DEFAULT 0,--д���µ�Ȩ��
  comment  INT DEFAULT 0,--д���۵�Ȩ��
  labelSet INT DEFAULT 0,--��ǩ����Ȩ��
  typeSet INT DEFAULT 0,--������Ȩ��
  articleSet INT DEFAULT 0,--���¹���Ȩ��
  commentSet INT DEFAULT 0,--���۹���Ȩ��
  userSet INT DEFAULT 0,--�û�����Ȩ��
  PRIMARY KEY (user_id),
  FOREIGN KEY(user_id) REFERENCES  db_users(id)
) 
--�����
CREATE TABLE db_types(
  id INT NOT NULL IDENTITY(1,1),--id:����
  name NVARCHAR(50) NOT NULL,--��������
  describe NVARCHAR(255) DEFAULT NULL,--��������
  PRIMARY KEY(id)
)
--��ǩ��
CREATE TABLE db_labels(
  id INT NOT NULL IDENTITY(1,1),--id:����
  name NVARCHAR(50) NOT NULL --��ǩ����
  PRIMARY KEY(id)
)
--���±�
CREATE TABLE db_articles(
  id INT NOT NULL IDENTITY(1,1),--id:����
  title NVARCHAR(50) NOT NULL,--���±���
  type_id INT,--�������
  author_id INT,--�����û�������
  status INT NOT NULL DEFAULT 0,--���µ�ǰ״̬
  content NVARCHAR(MAX),--��������
  createDate DATETIME,--����ʱ��
  updateDate DATETIME,--�������ʱ��
  publishDate DATETIME,--����ʱ��
  checker_id INT--���Ա
  PRIMARY KEY(id),
  FOREIGN KEY(type_id) REFERENCES  db_types(id),
  FOREIGN KEY(author_id) REFERENCES  db_users(id),
  FOREIGN KEY(checker_id) REFERENCES  db_users(id)
)
--���±�ǩ��ϵ��
CREATE TABLE db_article_label(
  id INT NOT NULL IDENTITY(1,1),--id:����
  article_id INT NOT NULL,--����id
  label_id INT NOT NULL,--��ǩid
  PRIMARY KEY(id),
  FOREIGN KEY(article_id) REFERENCES  db_articles(id),
  FOREIGN KEY(label_id) REFERENCES  db_labels(id)
)
--���۱�
CREATE TABLE db_comments(
  id INT NOT NULL IDENTITY(1,1),--id:����
  article_id INT NOT NULL,--����id
  commenter_id INT NOT NULL,--�����û�
  content NVARCHAR(150),--��������
  status INT NOT NULL DEFAULT 0,--���۵�ǰ״̬
  submitDate DATETIME,--�ύʱ��
  publishDate DATETIME,--����ʱ��
  checker_id INT--���Ա��
  PRIMARY KEY(id),
  FOREIGN KEY(article_id) REFERENCES  db_articles(id),
  FOREIGN KEY(checker_id) REFERENCES  db_users(id)
)



insert into db_users values('Elkszero','Elkszero','4F8F66946DFD8C176DC6BECF51B54A15','15895261466@163.com',15895261466,NULL)
insert into db_authorizations values(1,1,1,1,1,1,1)




