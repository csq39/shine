???prompt PL/SQL Developer import file
prompt Created on 2018年9月20日 by Administrator
set feedback off
set define off
prompt Loading COM_DICT...
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000060, '01', '允许登录', 'loginStatus', '登录状态', 1, '10000001', to_date('30-01-2018 17:40:16', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('30-01-2018 17:40:16', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000061, '02', '禁止登录', 'loginStatus', '登录状态', 2, '10000001', to_date('30-01-2018 17:40:49', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('30-01-2018 17:40:49', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000621, '0', '未推送', 'cargotype', '物流状态', 2, '10000001', to_date('20-09-2018 13:58:25', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('20-09-2018 13:58:25', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000042, '03', '医疗机构用户', 'userType', '用户类型', 3, '10000001', to_date('30-01-2018 15:46:10', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('30-01-2018 15:46:10', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000040, '01', '系统管理员', 'userType', '用户类型', 1, '10000001', to_date('30-01-2018 15:43:18', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('30-01-2018 15:43:18', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000041, '02', '平台管理员', 'userType', '用户类型', 2, '10000001', to_date('30-01-2018 15:44:17', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('30-01-2018 15:44:17', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000043, '04', '企业机构用户', 'userType', '用户类型', 4, '10000001', to_date('30-01-2018 15:46:40', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('30-01-2018 15:46:40', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000044, '05', '居间服务管理员', 'userType', '用户类型', 5, '10000001', to_date('30-01-2018 15:47:45', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('30-01-2018 15:47:45', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000620, '1', '已推送', 'cargotype', '物流状态', 1, '10000001', to_date('20-09-2018 13:58:25', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('20-09-2018 13:58:25', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000080, '1', '男', 'gender', '性别', 1, '10000001', to_date('30-01-2018 18:51:52', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('31-01-2018 10:38:48', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000081, '2', '女', 'gender', '性别', 2, '10000001', to_date('30-01-2018 18:52:08', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('30-01-2018 18:52:08', 'dd-mm-yyyy hh24:mi:ss'), 'N');
insert into COM_DICT (dict_id, code, label, type, remark, sort, create_by, create_date, update_by, update_date, del_flag)
values (1000622, '2', '推送错误', 'cargotype', '物流状态', 3, '10000001', null, null, null, 'N');
commit;
prompt 12 records loaded
prompt Loading COM_MENU...
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('7000680', '1000000', '-1,1000000', '订单管理', 2, '/', null, null, 'Y', null, '10000001', to_date('20-09-2018 13:51:58', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('20-09-2018 13:51:58', 'dd-mm-yyyy hh24:mi:ss'), null, 'N');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('7000682', '7000680', '-1,1000000,7000680', '随货同行单', 1, '/ship/cargo', null, null, 'Y', null, '10000001', to_date('20-09-2018 13:53:58', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('20-09-2018 13:53:58', 'dd-mm-yyyy hh24:mi:ss'), null, 'N');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('1000005', '1000001', '1000000,,1000001', '岗位管理', 3, '/positon', null, 'fa fa-list', 'Y', null, '10000001', to_date('03-05-2018 09:52:00', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('07-05-2018 09:57:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('1000006', '1000001', '10,000,001,000,001', '备份管理', 4, '/dbBackup', null, null, 'Y', 'dbBackup', null, null, '10000001', to_date('03-05-2018 09:51:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('1000008', '1000001', '10,000,001,000,001', '公用代码', 6, '/comCode', null, null, 'Y', 'comCode', null, null, '10000001', to_date('03-05-2018 09:52:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('1000000', '-1', '-1', '系统管理', 1, null, null, null, 'Y', null, null, null, null, null, null, 'N');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('1000001', '1000000', '1000000,', '系统管理', 1, '/ss', null, 'fa fa-list', 'Y', null, null, null, '10000001', to_date('24-04-2018 17:19:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('1000002', '1000001', '10,000,001,000,001', '菜单管理', 1, '/menu', null, null, 'Y', 'menu', null, null, null, null, null, 'Y');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('1000003', '1000001', '10,000,001,000,001', '权限管理', 2, '/role', null, null, 'Y', 'role', null, null, '10000001', to_date('03-05-2018 09:53:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('7000580', '1000001', '1000000,,1000001', '科室分类', 7, '/officeCategory', null, null, 'Y', null, '10000001', to_date('12-07-2018 15:54:53', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('17-07-2018 15:30:43', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y');
insert into COM_MENU (menu_id, parent_id, parent_ids, name, sort, href, target, icon, is_show, permission, create_by, create_date, update_by, update_date, remarks, del_flag)
values ('7000600', '1000001', '10,000,001,000,001', '数据权限管理', 7, '/dataResource', null, null, 'Y', 'dbBackup', null, null, '10000001', to_date('03-05-2018 09:51:00', 'dd-mm-yyyy hh24:mi:ss'), null, 'Y');
commit;
prompt 11 records loaded
prompt Loading COM_USER...
insert into COM_USER (user_id, office_id, login_name, password, user_name, email, phone_no, sex, position, mobile_no, user_type, login_ip, login_date, create_by, create_date, update_by, update_date, del_flag, login_flag, remarks, employee_id, org_id, authorize_office_ids, login_first_flag, consume_attr1, consume_attr2, consume_attr3, consume_attr4, consume_attr5, change_pwd_flag)
values ('10000001', '1', 'admin', 'd7c3db257f434fe6b6428cf2b4a329ab0078255924ea327ead993b80', '系统管理员', null, null, null, null, null, null, '0:0:0:0:0:0:0:1', to_date('20-09-2018 20:08:21', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('01-01-2017 01:01:01', 'dd-mm-yyyy hh24:mi:ss'), '10000001', to_date('16-05-2018 19:21:58', 'dd-mm-yyyy hh24:mi:ss'), 'N', 'Y', null, null, '100000', null, null, null, null, null, null, null, 'N');
commit;
prompt 1 records loaded
set feedback on
set define on
prompt Done.
