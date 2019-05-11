-- Create table
create table CARGO_DRAFT(
  id                VARCHAR2(24) not null,
  import_id       	VARCHAR2(20),
  billcode          VARCHAR2(100),
  delivery_billcode VARCHAR2(100),
  org_code          VARCHAR2(20),
  type              VARCHAR2(10),
  carrier_id        VARCHAR2(20),
  driver            VARCHAR2(20),
  mobile            VARCHAR2(100),
  sale_billcode     VARCHAR2(20),
  shipper           VARCHAR2(100),
  ordertime         DATE,
  shpr_province     VARCHAR2(100),
  shpr_town         VARCHAR2(100),
  shpr_county       VARCHAR2(100),
  shpr_add          VARCHAR2(400),
  shpr_contacts     VARCHAR2(100),
  shpr_phone        VARCHAR2(100),
  shpr_area_code    VARCHAR2(30),
  shpr_mobile       VARCHAR2(50),
  consignee         VARCHAR2(100),
  cnee_province     VARCHAR2(100),
  cnee_town         VARCHAR2(100),
  cnee_county       VARCHAR2(100),
  cnee_add          VARCHAR2(400),
  cnee_contacts     VARCHAR2(100),
  cnee_phone        VARCHAR2(100),
  cnee_area_code    VARCHAR2(100),
  cnee_mobile       VARCHAR2(100),
  saler             VARCHAR2(100),
  saler_phone       VARCHAR2(100),
  documentmaker     VARCHAR2(100),
  documents_time    VARCHAR2(100),
  shipment_date     DATE,
  shipment_timea    DATE,
  shipment_timeb    DATE,
  delivery_date     DATE,
  delivery_timea    DATE,
  delivery_timeb    DATE,
   CREATE_BY       VARCHAR2(50),
  CREATE_DATE     DATE,
  UPDATE_BY       VARCHAR2(50),
  UPDATE_DATE     DATE,
  remarks           VARCHAR2(400),
  ec_status         VARCHAR2(10),
  output_msg         VARCHAR2(200),
  TRANSPORT_NO         VARCHAR2(200),
  CARRIER         VARCHAR2(200),
  custid         VARCHAR2(200),
  output_status     VARCHAR2(10)  default 1
);
-- Add comments to the columns 
comment on column CARGO_DRAFT.id
  is '唯一编号';
  comment on column CARGO_DRAFT.import_id
  is '外部主键';
comment on column CARGO_DRAFT.billcode
  is 'sap交货单号，随货同行单';
comment on column CARGO_DRAFT.delivery_billcode
  is '交货单号-对应发货单';
comment on column CARGO_DRAFT.org_code
  is '区域名称,对应otms权限划分';
comment on column CARGO_DRAFT.type
  is '参考运输类型，（0物流，1快递）sap给出的参考运输类型';
comment on column CARGO_DRAFT.carrier_id
  is '承运商';
comment on column CARGO_DRAFT.driver
  is '司机';
comment on column CARGO_DRAFT.mobile
  is '司机电话';
comment on column CARGO_DRAFT.sale_billcode
  is '销售订单号';
comment on column CARGO_DRAFT.shipper
  is '发货方(营销公司编码)';
comment on column CARGO_DRAFT.ordertime
  is '订单过账时间';
comment on column CARGO_DRAFT.shpr_province
  is '发货地址-省份';
comment on column CARGO_DRAFT.shpr_town
  is '发货地址-城市';
comment on column CARGO_DRAFT.shpr_county
  is '发货地址-区县';
comment on column CARGO_DRAFT.shpr_add
  is '发货方地址-详细地址';
comment on column CARGO_DRAFT.shpr_contacts
  is '发货人';
comment on column CARGO_DRAFT.shpr_phone
  is '发货人联系方式--座机';
comment on column CARGO_DRAFT.shpr_area_code
  is '发货人联系方式-座机区号';
comment on column CARGO_DRAFT.shpr_mobile
  is '发货人联系方式-手机(组合业务员电话)';
comment on column CARGO_DRAFT.consignee
  is '收货方';
  comment on column CARGO_DRAFT.cnee_province
  is '收货方省';
comment on column CARGO_DRAFT.cnee_town
  is '收货方市';
comment on column CARGO_DRAFT.cnee_county
  is '收货方区';
comment on column CARGO_DRAFT.cnee_add
  is '收货方-详细地址';
comment on column CARGO_DRAFT.cnee_contacts
  is '收货人';
comment on column CARGO_DRAFT.cnee_phone
  is '收货人座机';
comment on column CARGO_DRAFT.cnee_area_code
  is '收货人座机区号';
comment on column CARGO_DRAFT.cnee_mobile
  is '收货人手机';
comment on column CARGO_DRAFT.saler
  is '业务员';
comment on column CARGO_DRAFT.saler_phone
  is '业务员电话，业务员电话和收货人电话拼到一起';
comment on column CARGO_DRAFT.documentmaker
  is '制单人';
comment on column CARGO_DRAFT.documents_time
  is '订单制单时间';
comment on column CARGO_DRAFT.shipment_date
  is '计划提货日期';
comment on column CARGO_DRAFT.shipment_timea
  is '计划提货开始时间';
comment on column CARGO_DRAFT.shipment_timeb
  is '计划提货结算时间';
comment on column CARGO_DRAFT.delivery_date
  is '计划送达日期';
comment on column CARGO_DRAFT.delivery_timea
  is '计划送达开始时间';
comment on column CARGO_DRAFT.delivery_timeb
  is '计划送达结束时间';
comment on column CARGO_DRAFT.remarks
  is '备注,目前传收货方电话,电话格式不规则';
comment on column CARGO_DRAFT.ec_status
  is '往EC传递状态,0未推送,1已推送';
comment on column CARGO_DRAFT.output_status
  is '往otms推送状态,1未推送,2已推送,,3推送错误';
  comment on column CARGO_DRAFT.output_msg
  is '推送消息或错误代码';
  comment on column CARGO_DRAFT.CARRIER
  is '承运商，SF  SMS';
  comment on column CARGO_DRAFT.TRANSPORT_NO
  is 'EC单号';
  comment on column CARGO_DRAFT.custid
  is '月结账号';
--alter table CARGO_DRAFT
  --add constraint PK_CARGO_DRAFT primary key (id);
  
  
  -- Create table
create table CARGO_DRAFT_B
(
  id              VARCHAR2(24),
  import_id       VARCHAR2(20),
  cargo_id        VARCHAR2(100),
  hanghao         VARCHAR2(10),
  delivery_rownum VARCHAR2(20),
  org_code        VARCHAR2(10),
  material_code   VARCHAR2(100),
  material_name   VARCHAR2(200),
  material_type   VARCHAR2(100),
  unit            VARCHAR2(100),
  quantity        NUMBER(14,5),
  volume          NUMBER(14,6),
  weight          NUMBER(14,2),
  batch           VARCHAR2(100),
   CREATE_BY       VARCHAR2(50),
  CREATE_DATE     DATE,
  UPDATE_BY       VARCHAR2(50),
  UPDATE_DATE     DATE,
  release_date    DATE,
  expiring_date   DATE,
  remarks         VARCHAR2(400)
);
-- Add comments to the table 
comment on table CARGO_DRAFT_B
  is '随货同行单子表';
-- Add comments to the columns 
comment on column CARGO_DRAFT_B.id
  is '主键，唯一编号';
comment on column CARGO_DRAFT_B.import_id
  is '外部主键';
comment on column CARGO_DRAFT_B.cargo_id
  is '随货同行单单号';
comment on column CARGO_DRAFT_B.hanghao
  is 'Sap交货单行号';
comment on column CARGO_DRAFT_B.delivery_rownum
  is '交货单行号';
comment on column CARGO_DRAFT_B.org_code
  is '区域名称,对应otms权限划分';
comment on column CARGO_DRAFT_B.material_code
  is '商品编号';
comment on column CARGO_DRAFT_B.material_name
  is '商品名称';
comment on column CARGO_DRAFT_B.material_type
  is '商品类型';
comment on column CARGO_DRAFT_B.unit
  is '数量单位';
comment on column CARGO_DRAFT_B.quantity
  is '商品数量';
comment on column CARGO_DRAFT_B.volume
  is '单个商品体积(立方米)';
comment on column CARGO_DRAFT_B.weight
  is '单个商品重量(公斤)';
comment on column CARGO_DRAFT_B.batch
  is '商品批号';
comment on column CARGO_DRAFT_B.release_date
  is '商品生产日期';
comment on column CARGO_DRAFT_B.expiring_date
  is '商品效期';
comment on column CARGO_DRAFT_B.remarks
  is '备注';
--alter table CARGO_DRAFT_B
  --add constraint PK_CARGO_DRAFT_B primary key (id);
  
  
  create sequence SEQ_cargo_draft
minvalue 10000000000000
maxvalue 99999999999999
start with 10000000000000
increment by 1
cache 20;