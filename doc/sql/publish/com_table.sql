drop table COM_LOG;
drop table COM_DATA;
drop table COM_DATA_RESOURCE;
drop table COM_DICT;
drop table COM_FILE;
drop table COM_MENU;
drop table COM_MENU_PERMISSION;
drop table COM_NATIONCODE;
drop table COM_POSITION;
drop table COM_POSITION_DATA;
drop table COM_POSITION_USER;
drop table COM_ROLE;
drop table COM_ROLE_MENU;
drop table COM_ROLE_USER;
drop table COM_USER;

drop sequence SEQ_COM_DICT;
drop sequence SEQ_COM_FILE;
drop sequence SEQ_COM_MENU;
drop sequence SEQ_COM_POSITION;
drop sequence SEQ_COM_ROLE;
drop sequence SEQ_COM_USER;
drop sequence SEQ_DATA;
drop sequence SEQ_DATA_RESOURCE;
drop sequence SEQ_MENU_PERMISSION;

create table COM_LOG (
   log_id            	VARCHAR2(64)         not null,
   log_type         	VARCHAR2(2),
   title             	VARCHAR2(255),
   remote_addr     	 	VARCHAR2(255),
   user_agent        	VARCHAR2(255),
   request_uri      	VARCHAR2(255),
   method            	VARCHAR2(100),
   params             	CLOB,
   exception          	CLOB,
   CREATE_BY            VARCHAR2(50),
   CREATE_DATE          date,
   UPDATE_BY            VARCHAR2(50),
   ip          			VARCHAR2(50),
   UPDATE_DATE          date,
   DEL_FLAG             VARCHAR2(1)          default 'N',
   constraint PK_COM_LOG primary key (log_id)
);

comment on table COM_LOG is'日志表';
comment on column COM_LOG.log_id is'编号';
comment on column COM_LOG.log_type is'日志类型';
comment on column COM_LOG.title is'日志标题';
comment on column COM_LOG.remote_addr is'操作IP地址';
comment on column COM_LOG.user_agent is'用户代理';
comment on column COM_LOG.request_uri is'请求URI';
comment on column COM_LOG.method is'操作方式';
comment on column COM_LOG.params is'操作提交的数据';
comment on column COM_LOG.exception is'异常信息';
comment on column COM_LOG.CREATE_BY is'创建人';
comment on column COM_LOG.CREATE_DATE is'创建日期';
comment on column COM_LOG.UPDATE_BY is'更新人';
comment on column COM_LOG.UPDATE_DATE is'更新日期';
comment on column COM_LOG.DEL_FLAG is'删除标识';
comment on column COM_LOG.ip  is '操作IP';

create table COM_DATA
(
  DATA_ID       NUMBER(20) not null,
  DATA_NAME     VARCHAR2(100) not null,
  DATA_TYPE     VARCHAR2(10) not null,
  CONTROL_FLAG  VARCHAR2(10) not null,
  DATA_OPERATOR VARCHAR2(100) not null,
  DATA_CODE     VARCHAR2(100) not null,
  REMARKS       VARCHAR2(255),
  CREATE_BY     VARCHAR2(50),
  CREATE_DATE   DATE,
  UPDATE_BY     VARCHAR2(50),
  UPDATE_DATE   DATE,
  DEL_FLAG      VARCHAR2(1) default 'N'
);
comment on table COM_DATA
  is '资源主表';
comment on column COM_DATA.DATA_ID
  is '资源主表主键';
comment on column COM_DATA.DATA_NAME
  is '资源名称';
comment on column COM_DATA.DATA_TYPE
  is '资源类型:static：静态类型、dynamic：动态类型、mix：混合类型';
comment on column COM_DATA.CONTROL_FLAG
  is '资源管控策略，0：不管控，1：按授权访问';
comment on column COM_DATA.DATA_OPERATOR
  is '资源操作符';
comment on column COM_DATA.DATA_CODE
  is '资源编码';
comment on column COM_DATA.REMARKS
  is '资源描述';
comment on column COM_DATA.CREATE_BY
  is '创建人';
comment on column COM_DATA.CREATE_DATE
  is '创建时间';
comment on column COM_DATA.UPDATE_BY
  is '更新人';
comment on column COM_DATA.UPDATE_DATE
  is '更新时间';
comment on column COM_DATA.DEL_FLAG
  is '是否删除';
alter table COM_DATA
  add primary key (DATA_ID);

create table COM_DATA_RESOURCE
(
  DATA_RESOURCE_ID   NUMBER(20) not null,
  DATA_ID            NUMBER(20) not null,
  DATA_CODE          VARCHAR2(100) not null,
  RESOURCE_NAME      VARCHAR2(100),
  RESOURCE_VALUE     VARCHAR2(100) not null,
  RESOURCE_LINE_TYPE VARCHAR2(10) not null,
  REMARKS            VARCHAR2(255),
  CREATE_BY          VARCHAR2(50),
  CREATE_DATE        DATE,
  UPDATE_BY          VARCHAR2(50),
  UPDATE_DATE        DATE,
  DEL_FLAG           VARCHAR2(1) default 'N'
);
comment on table COM_DATA_RESOURCE
  is '资源子表';
comment on column COM_DATA_RESOURCE.DATA_RESOURCE_ID
  is '资源子表主键';
comment on column COM_DATA_RESOURCE.DATA_ID
  is '资源主表主键';
comment on column COM_DATA_RESOURCE.DATA_CODE
  is '资源编码';
comment on column COM_DATA_RESOURCE.RESOURCE_NAME
  is '资源name';
comment on column COM_DATA_RESOURCE.RESOURCE_VALUE
  is '资源value,动态类型时存放sql';
comment on column COM_DATA_RESOURCE.RESOURCE_LINE_TYPE
  is '资源行条目类型:static：静态类型、dynamic：动态类型';
comment on column COM_DATA_RESOURCE.REMARKS
  is '资源行条目描述';
comment on column COM_DATA_RESOURCE.CREATE_BY
  is '创建人';
comment on column COM_DATA_RESOURCE.CREATE_DATE
  is '创建时间';
comment on column COM_DATA_RESOURCE.UPDATE_BY
  is '更新人';
comment on column COM_DATA_RESOURCE.UPDATE_DATE
  is '更新时间';
comment on column COM_DATA_RESOURCE.DEL_FLAG
  is '是否删除';
alter table COM_DATA_RESOURCE
  add primary key (DATA_RESOURCE_ID);

create table COM_DICT
(
  DICT_ID     NUMBER(10) not null,
  CODE        VARCHAR2(30),
  LABEL       VARCHAR2(100),
  TYPE        VARCHAR2(30),
  REMARK      VARCHAR2(100),
  SORT        NUMBER,
  CREATE_BY   VARCHAR2(50),
  CREATE_DATE DATE,
  UPDATE_BY   VARCHAR2(50),
  UPDATE_DATE DATE,
  DEL_FLAG    VARCHAR2(1) default 'N'
);
comment on table COM_DICT
  is '共同代码表';
comment on column COM_DICT.DICT_ID
  is '编码';
comment on column COM_DICT.CODE
  is '代码';
comment on column COM_DICT.LABEL
  is '标签名';
comment on column COM_DICT.TYPE
  is '分类';
comment on column COM_DICT.REMARK
  is '描述';
comment on column COM_DICT.SORT
  is '排序';
comment on column COM_DICT.CREATE_BY
  is '创建人';
comment on column COM_DICT.CREATE_DATE
  is '创建日期';
comment on column COM_DICT.UPDATE_BY
  is '更新人';
comment on column COM_DICT.UPDATE_DATE
  is '更新日期';
comment on column COM_DICT.DEL_FLAG
  is '删除标识';
alter table COM_DICT
  add constraint PK_COM_DICT primary key (DICT_ID);

CREATE TABLE COM_FILE  (
  FILE_ID             VARCHAR2(100) NOT NULL ,
  FILE_NAME           VARCHAR2(100),
  FILE_SIZE           VARCHAR2(100),
  FILE_PATH            VARCHAR2(100),
  FILE_DIR            VARCHAR2(100),
  FILE_NAME_ORIG      VARCHAR2(100),
  sys_name      	  VARCHAR2(1000),
  custom_value        VARCHAR2(2000),
  CREATE_BY           VARCHAR2(10),
  CREATE_DATE         DATE NOT NULL ,
  UPDATE_BY           VARCHAR2(10),
  UPDATE_DATE         DATE,
  CONSTRAINT PK_COM_FILE PRIMARY KEY (FILE_ID)
);
COMMENT ON TABLE COM_FILE IS '附件表';
COMMENT ON COLUMN COM_FILE.FILE_ID IS '文件名id';
COMMENT ON COLUMN COM_FILE.FILE_NAME IS '文件名';
COMMENT ON COLUMN COM_FILE.FILE_SIZE IS '文件大小';
COMMENT ON COLUMN COM_FILE.FILE_PATH IS '文件路径';
COMMENT ON COLUMN COM_FILE.FILE_DIR IS '文件夹路径';
COMMENT ON COLUMN COM_FILE.sys_name IS '系统名';
COMMENT ON COLUMN COM_FILE.custom_value IS '自定义变量';
COMMENT ON COLUMN COM_FILE.FILE_NAME_ORIG IS '原始文件名';
COMMENT ON COLUMN COM_FILE.CREATE_BY IS '创建者';
COMMENT ON COLUMN COM_FILE.CREATE_DATE IS '创建日期';
COMMENT ON COLUMN COM_FILE.UPDATE_BY IS '更新者';
COMMENT ON COLUMN COM_FILE.UPDATE_DATE IS '更新日期';


create table COM_MENU
(
  MENU_ID     VARCHAR2(10) not null,
  PARENT_ID   VARCHAR2(10) not null,
  PARENT_IDS  VARCHAR2(2000),
  NAME        VARCHAR2(255),
  SORT        NUMBER,
  HREF        VARCHAR2(2000),
  TARGET      VARCHAR2(255),
  ICON        VARCHAR2(500),
  IS_SHOW     VARCHAR2(1) default 'Y',
  PERMISSION  VARCHAR2(200),
  CREATE_BY   VARCHAR2(50),
  CREATE_DATE DATE,
  UPDATE_BY   VARCHAR2(50),
  UPDATE_DATE DATE,
  REMARKS     VARCHAR2(500),
  DEL_FLAG    VARCHAR2(1) default 'N'
);
comment on column COM_MENU.MENU_ID
  is '编号';
comment on column COM_MENU.PARENT_ID
  is '父级编号';
comment on column COM_MENU.PARENT_IDS
  is '所有父级编号';
comment on column COM_MENU.NAME
  is '名称';
comment on column COM_MENU.SORT
  is '排序';
comment on column COM_MENU.HREF
  is '链接';
comment on column COM_MENU.TARGET
  is '目标';
comment on column COM_MENU.ICON
  is '图标';
comment on column COM_MENU.IS_SHOW
  is '是否在菜单中显示';
comment on column COM_MENU.PERMISSION
  is '权限标识';
alter table COM_MENU
  add primary key (MENU_ID);

create table COM_MENU_PERMISSION
(
  MENU_PERMISSION_ID VARCHAR2(10) not null,
  MENU_ID            VARCHAR2(10),
  PERMISSION_CODE    VARCHAR2(50),
  PERMISSION_NAME    VARCHAR2(255) not null,
  CREATE_BY          VARCHAR2(50),
  CREATE_DATE        DATE,
  UPDATE_BY          VARCHAR2(50),
  UPDATE_DATE        DATE,
  DEL_FLAG           VARCHAR2(1) default 'N'
);
comment on table COM_MENU_PERMISSION
  is '菜单权限表';
comment on column COM_MENU_PERMISSION.MENU_PERMISSION_ID
  is '权限编号';
comment on column COM_MENU_PERMISSION.MENU_ID
  is '菜单ID';
comment on column COM_MENU_PERMISSION.PERMISSION_CODE
  is '权限编码';
comment on column COM_MENU_PERMISSION.PERMISSION_NAME
  is '权限名称';
comment on column COM_MENU_PERMISSION.CREATE_BY
  is '创建人';
comment on column COM_MENU_PERMISSION.CREATE_DATE
  is '创建日期';
comment on column COM_MENU_PERMISSION.UPDATE_BY
  is '更新人';
comment on column COM_MENU_PERMISSION.UPDATE_DATE
  is '更新日期';
comment on column COM_MENU_PERMISSION.DEL_FLAG
  is '删除标识';
alter table COM_MENU_PERMISSION
  add constraint PK_COM_MENU_PERMISSION primary key (MENU_PERMISSION_ID);

create table COM_NATIONCODE
(
  NATION_CODE    VARCHAR2(50) not null,
  NATION_NAME    VARCHAR2(500),
  NATION_EN_NAME VARCHAR2(500)
);
comment on table COM_NATIONCODE
  is '国家代码表';
comment on column COM_NATIONCODE.NATION_CODE
  is '代码';
comment on column COM_NATIONCODE.NATION_NAME
  is '国家';
comment on column COM_NATIONCODE.NATION_EN_NAME
  is '英文名';
alter table COM_NATIONCODE
  add constraint PK_COM_NATIONCODE primary key (NATION_CODE);

create table COM_POSITION
(
  POSITON_ID      VARCHAR2(11) not null,
  POSITON_NAME    VARCHAR2(100) not null,
  POSITON_EN_NAME VARCHAR2(100),
  ORG_ID          NUMBER(20) not null,
  REMARKS         VARCHAR2(255),
  CONSUME_ATTR1   VARCHAR2(50),
  CONSUME_ATTR2   VARCHAR2(50),
  CONSUME_ATTR3   VARCHAR2(50),
  CONSUME_ATTR4   VARCHAR2(50),
  CONSUME_ATTR5   VARCHAR2(50),
  CREATE_BY       VARCHAR2(50),
  CREATE_DATE     DATE,
  UPDATE_BY       VARCHAR2(50),
  UPDATE_DATE     DATE,
  DEL_FLAG        VARCHAR2(1) default 'N'
);
comment on table COM_POSITION
  is '用户岗位表';
comment on column COM_POSITION.POSITON_ID
  is '岗位id';
comment on column COM_POSITION.POSITON_NAME
  is '岗位名称';
comment on column COM_POSITION.POSITON_EN_NAME
  is '岗位英文名称';
comment on column COM_POSITION.ORG_ID
  is '组织id';
comment on column COM_POSITION.REMARKS
  is '备注';
comment on column COM_POSITION.CONSUME_ATTR1
  is '备用字段1';
comment on column COM_POSITION.CONSUME_ATTR2
  is '备用字段2';
comment on column COM_POSITION.CONSUME_ATTR3
  is '备用字段3';
comment on column COM_POSITION.CONSUME_ATTR4
  is '备用字段4';
comment on column COM_POSITION.CONSUME_ATTR5
  is '备用字段5';
comment on column COM_POSITION.CREATE_BY
  is '创建人';
comment on column COM_POSITION.CREATE_DATE
  is '创建时间';
comment on column COM_POSITION.UPDATE_BY
  is '更新人';
comment on column COM_POSITION.UPDATE_DATE
  is '更新时间';
comment on column COM_POSITION.DEL_FLAG
  is '是否删除';
alter table COM_POSITION
  add primary key (POSITON_ID);

create table COM_POSITION_DATA
(
  DATA_ID          NUMBER(20) not null,
  POSITON_ID       VARCHAR2(11) not null,
  DATA_RESOURCE_ID VARCHAR2(1000) not null,
  DATA_TYPE        VARCHAR2(10) not null,
  REMARKS          VARCHAR2(255),
  CREATE_BY        VARCHAR2(50),
  CREATE_DATE      DATE,
  UPDATE_BY        VARCHAR2(50),
  UPDATE_DATE      DATE,
  DEL_FLAG         VARCHAR2(1) default 'N'
);
comment on table COM_POSITION_DATA
  is '数据资源关系表';
comment on column COM_POSITION_DATA.DATA_ID
  is '资源主表主键';
comment on column COM_POSITION_DATA.POSITON_ID
  is '岗位主表主键';
comment on column COM_POSITION_DATA.DATA_RESOURCE_ID
  is 'data_resource_id用逗号拼接';
comment on column COM_POSITION_DATA.DATA_TYPE
  is '资源类型';
comment on column COM_POSITION_DATA.REMARKS
  is '备注';
comment on column COM_POSITION_DATA.CREATE_BY
  is '创建人';
comment on column COM_POSITION_DATA.CREATE_DATE
  is '创建时间';
comment on column COM_POSITION_DATA.UPDATE_BY
  is '更新人';
comment on column COM_POSITION_DATA.UPDATE_DATE
  is '更新时间';
comment on column COM_POSITION_DATA.DEL_FLAG
  is '是否删除';

create table COM_POSITION_USER
(
  POSITON_ID  VARCHAR2(11) not null,
  USER_ID     VARCHAR2(15) not null,
  REMARKS     VARCHAR2(255),
  CREATE_BY   VARCHAR2(50),
  CREATE_DATE DATE,
  UPDATE_BY   VARCHAR2(50),
  UPDATE_DATE DATE,
  DEL_FLAG    VARCHAR2(1) default 'N'
);
comment on table COM_POSITION_USER
  is '用户岗位关系表';
comment on column COM_POSITION_USER.POSITON_ID
  is '角色编号';
comment on column COM_POSITION_USER.USER_ID
  is '用户编号';
comment on column COM_POSITION_USER.REMARKS
  is '备注';
comment on column COM_POSITION_USER.CREATE_BY
  is '创建人';
comment on column COM_POSITION_USER.CREATE_DATE
  is '创建时间';
comment on column COM_POSITION_USER.UPDATE_BY
  is '更新人';
comment on column COM_POSITION_USER.UPDATE_DATE
  is '更新时间';
comment on column COM_POSITION_USER.DEL_FLAG
  is '是否删除';

create table COM_ROLE
(
  ROLE_ID     VARCHAR2(10) not null,
  ROLE_NAME   VARCHAR2(100) not null,
  ROLE_ENNAME VARCHAR2(100) not null,
  ROLE_TYPE   VARCHAR2(255),
  DATA_SCOPE  VARCHAR2(1),
  IS_SYS      VARCHAR2(1),
  REMARKS     VARCHAR2(255),
  CREATE_BY   VARCHAR2(50),
  CREATE_DATE DATE,
  UPDATE_BY   VARCHAR2(50),
  UPDATE_DATE DATE,
  DEL_FLAG    VARCHAR2(1) default 'N'
);
comment on column COM_ROLE.ROLE_ID
  is '编号';
comment on column COM_ROLE.ROLE_NAME
  is '角色名称';
comment on column COM_ROLE.ROLE_ENNAME
  is '英文名称';
comment on column COM_ROLE.ROLE_TYPE
  is '角色类型';
comment on column COM_ROLE.DATA_SCOPE
  is '数据范围';
comment on column COM_ROLE.IS_SYS
  is '是否系统数据';
alter table COM_ROLE
  add primary key (ROLE_ID);

create table COM_ROLE_MENU
(
  ROLE_ID         VARCHAR2(10) not null,
  MENU_ID         VARCHAR2(10) not null,
  REMARKS         VARCHAR2(255),
  CREATE_BY       VARCHAR2(50),
  CREATE_DATE     DATE,
  UPDATE_BY       VARCHAR2(50),
  UPDATE_DATE     DATE,
  PERMISSION_CODE VARCHAR2(500)
);
comment on table COM_ROLE_MENU
  is '角色菜单分配表';
comment on column COM_ROLE_MENU.ROLE_ID
  is '角色编号';
comment on column COM_ROLE_MENU.MENU_ID
  is '菜单编号';
comment on column COM_ROLE_MENU.REMARKS
  is '备注';
comment on column COM_ROLE_MENU.CREATE_BY
  is '创建人';
comment on column COM_ROLE_MENU.CREATE_DATE
  is '创建日期';
comment on column COM_ROLE_MENU.UPDATE_BY
  is '更新人';
comment on column COM_ROLE_MENU.UPDATE_DATE
  is '更新日期';
comment on column COM_ROLE_MENU.PERMISSION_CODE
  is '权限编码,多个PERMISSION_CODE以逗号分隔';
alter table COM_ROLE_MENU
  add constraint PK_COM_ROLE_MENU primary key (ROLE_ID, MENU_ID);

create table COM_ROLE_USER
(
  ROLE_ID     VARCHAR2(10) not null,
  USER_ID     VARCHAR2(15) not null,
  REMARKS     VARCHAR2(255),
  CREATE_BY   VARCHAR2(50),
  CREATE_DATE DATE,
  UPDATE_BY   VARCHAR2(50),
  UPDATE_DATE DATE,
  DEL_FLAG    VARCHAR2(1) default 'N'
);
comment on column COM_ROLE_USER.ROLE_ID
  is '角色编号';
comment on column COM_ROLE_USER.USER_ID
  is '用户编号';

create table COM_USER
(
  USER_ID              VARCHAR2(15) not null,
  OFFICE_ID            VARCHAR2(64),
  LOGIN_NAME           VARCHAR2(64) not null,
  PASSWORD             VARCHAR2(64) not null,
  USER_NAME            VARCHAR2(100) not null,
  EMAIL                VARCHAR2(100),
  PHONE_NO             VARCHAR2(50),
  SEX                  NUMBER(1),
  POSITION             VARCHAR2(1),
  MOBILE_NO            VARCHAR2(50),
  USER_TYPE            VARCHAR2(2),
  LOGIN_IP             VARCHAR2(50),
  LOGIN_DATE           DATE,
  CREATE_BY            VARCHAR2(50),
  CREATE_DATE          DATE,
  UPDATE_BY            VARCHAR2(50),
  UPDATE_DATE          DATE,
  DEL_FLAG             VARCHAR2(1) default 'N',
  LOGIN_FLAG           VARCHAR2(1) default 'Y',
  REMARKS              VARCHAR2(500),
  EMPLOYEE_ID          VARCHAR2(50),
  ORG_ID               VARCHAR2(64),
  AUTHORIZE_OFFICE_IDS VARCHAR2(100),
  LOGIN_FIRST_FLAG     VARCHAR2(1),
  CONSUME_ATTR1        VARCHAR2(50),
  CONSUME_ATTR2        VARCHAR2(50),
  CONSUME_ATTR3        VARCHAR2(50),
  CONSUME_ATTR4        VARCHAR2(50),
  CONSUME_ATTR5        VARCHAR2(50),
  CHANGE_PWD_FLAG      VARCHAR2(1) default 'N'
);
comment on table COM_USER
  is '用户信息表';
comment on column COM_USER.USER_ID
  is '用户名';
comment on column COM_USER.OFFICE_ID
  is '部门ID';
comment on column COM_USER.LOGIN_NAME
  is '登录名';
comment on column COM_USER.PASSWORD
  is '登录密码';
comment on column COM_USER.USER_NAME
  is '用户姓名';
comment on column COM_USER.EMAIL
  is '邮箱';
comment on column COM_USER.PHONE_NO
  is '座机';
comment on column COM_USER.SEX
  is '性别1 男 2 女';
comment on column COM_USER.POSITION
  is '人员岗位';
comment on column COM_USER.MOBILE_NO
  is '手机';
comment on column COM_USER.USER_TYPE
  is '用户分类';
comment on column COM_USER.LOGIN_IP
  is '登录IP';
comment on column COM_USER.LOGIN_DATE
  is '登录日期';
comment on column COM_USER.CREATE_BY
  is '创建人';
comment on column COM_USER.CREATE_DATE
  is '创建日期';
comment on column COM_USER.UPDATE_BY
  is '更新人';
comment on column COM_USER.UPDATE_DATE
  is '更新日期';
comment on column COM_USER.DEL_FLAG
  is '删除标识';
comment on column COM_USER.LOGIN_FLAG
  is '是否允许登录';
comment on column COM_USER.REMARKS
  is '备注';
comment on column COM_USER.EMPLOYEE_ID
  is '外部系统员工号';
comment on column COM_USER.ORG_ID
  is '公司/医院ID';
comment on column COM_USER.AUTHORIZE_OFFICE_IDS
  is '授权部门，以逗号分隔';
comment on column COM_USER.LOGIN_FIRST_FLAG
  is '首次登陆是否需要修改密码(Y:是 N:否)';
comment on column COM_USER.CONSUME_ATTR1
  is '备用字段1';
comment on column COM_USER.CONSUME_ATTR2
  is '备用字段2';
comment on column COM_USER.CONSUME_ATTR3
  is '备用字段3';
comment on column COM_USER.CONSUME_ATTR4
  is '备用字段4';
comment on column COM_USER.CONSUME_ATTR5
  is '备用字段5';
comment on column COM_USER.CHANGE_PWD_FLAG
  is '是否修改过密码(Y:是 N:否)';
alter table COM_USER
  add constraint PK_COM_USER primary key (USER_ID);


create sequence SEQ_COM_DICT
minvalue 1000000
maxvalue 9999999
start with 1000620
increment by 1
cache 20;

create sequence SEQ_COM_FILE
minvalue 1000000
maxvalue 9999999
start with 1000000
increment by 1
cache 20;

create sequence SEQ_COM_MENU
minvalue 1000000
maxvalue 9999999
start with 7000680
increment by 1
cache 20;

create sequence SEQ_COM_POSITION
minvalue 10000000
maxvalue 99999999
start with 10000240
increment by 1
cache 20;

create sequence SEQ_COM_ROLE
minvalue 10000000
maxvalue 99999999
start with 10000140
increment by 1
cache 20;

create sequence SEQ_COM_USER
minvalue 1000000
maxvalue 9999999
start with 1000640
increment by 1
cache 20;

create sequence SEQ_DATA
minvalue 10000000
maxvalue 99999999
start with 10000009
increment by 1
nocache;

create sequence SEQ_DATA_RESOURCE
minvalue 10000000
maxvalue 99999999
start with 10000200
increment by 1
nocache;

create sequence SEQ_MENU_PERMISSION
minvalue 1000000
maxvalue 9999999
start with 1000040
increment by 1
cache 20;
