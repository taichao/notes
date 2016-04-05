CREATE TABLE `sh_activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `creat_time` datetime NOT NULL,
  `sh_goods_id` int(11) unsigned NOT NULL COMMENT '商品id',
  `current_period` int(11) NOT NULL DEFAULT '1' COMMENT '当前第几期,对应 activity_period 表period_number',
  `max_period` int(11) NOT NULL DEFAULT '9999999' COMMENT '最大期数',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '1.00' COMMENT '单价，默认一人次一个夺宝币',
  `begin_date` datetime NOT NULL COMMENT '活动开始日期',
  `end_date` datetime NOT NULL COMMENT '活动截止日期',
  `need_times` int(11) unsigned NOT NULL COMMENT '所需人次',
  `user_id` int(11) NOT NULL COMMENT '最后操作人',
  `update_time` datetime NOT NULL COMMENT '最后修改时间',
  `is_online` tinyint(1) NOT NULL COMMENT '0：下线，1：上线',
  `is_auto` tinyint(1) NOT NULL COMMENT '0：手动，1：自动',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_sh_activity_sh_goods1_idx` (`sh_goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 COMMENT='活动表\n和活动期数表1-n';

CREATE TABLE `sh_activity_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_period_id` int(11) NOT NULL,
  `sh_period_user_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `code_num` int(6) NOT NULL COMMENT '夺宝号码',
  `buy_time` varchar(32) CHARACTER SET utf8 NOT NULL,
  `buy_time_date` varchar(32) CHARACTER SET utf8 NOT NULL,
  `buy_time_code` varchar(32) CHARACTER SET utf8 NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `buy_id` varchar(45) DEFAULT NULL COMMENT '购买ID',
  PRIMARY KEY (`id`),
  KEY `sh_activity_code_activityPeriodId` (`activity_period_id`),
  KEY `sh_activity_code_userId` (`user_id`),
  KEY `sh_activity_code_buyId` (`buy_id`),
  KEY `sh_activity_code_buyTimeDate` (`buy_time_date`)
) ENGINE=InnoDB AUTO_INCREMENT=10117120 DEFAULT CHARSET=latin1;

CREATE TABLE `sh_activity_code_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_period_id` int(11) NOT NULL,
  `sh_period_user_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `code_num` int(6) NOT NULL COMMENT '夺宝号码',
  `buy_time` varchar(32) CHARACTER SET utf8 NOT NULL,
  `buy_time_date` varchar(32) CHARACTER SET utf8 NOT NULL,
  `buy_time_code` varchar(32) CHARACTER SET utf8 NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=384401 DEFAULT CHARSET=latin1;

CREATE TABLE `sh_activity_period` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `period_number` int(11) unsigned NOT NULL COMMENT '活动第几期',
  `sh_activity_id` int(11) unsigned NOT NULL COMMENT '活动id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `current_times` int(11) NOT NULL COMMENT '当前人次',
  `real_need_times` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '实际所需人次，从活动表读取保存',
  `real_price` decimal(10,2) NOT NULL COMMENT '实际单价',
  `flag` char(1) NOT NULL DEFAULT '1' COMMENT '0：过期，1：未过期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7734 DEFAULT CHARSET=utf8 COMMENT='活动期数表\n和活动表n-1\n和用户参与表1-n\n每新一期新增一条，结束的期flag=0,';

CREATE TABLE `sh_admin_authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL COMMENT '访问地址',
  `url_notes` varchar(255) DEFAULT NULL COMMENT '访问权限注释',
  `auth` varchar(64) DEFAULT NULL,
  `remark` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uidx_admin_authority` (`auth`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='访问权限表';

CREATE TABLE `sh_admin_authority_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `authority_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COMMENT='管理组对应的访问权限';

CREATE TABLE `sh_admin_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_admin_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sh_company_id` int(11) unsigned NOT NULL,
  `realname` varchar(64) DEFAULT NULL COMMENT '管理用户真实姓名',
  `nickname` varchar(64) NOT NULL COMMENT '管理用户昵称（登陆名）',
  `password` varchar(64) NOT NULL COMMENT '登陆密码',
  `sex` enum('0','1') DEFAULT '1' COMMENT '性别：0-女，1-男，默认为1',
  `address` varchar(64) DEFAULT NULL COMMENT '通讯地址',
  `email` varchar(32) DEFAULT NULL COMMENT '邮箱',
  `tel` varchar(24) DEFAULT NULL COMMENT '联系电话',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `enabled` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否启用管理用户：0-不启用，1-启用',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `position` varchar(16) DEFAULT NULL COMMENT '职位',
  `head_pic` varchar(255) DEFAULT NULL COMMENT '头像',
  `remember_token` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uix_sh_admin_user` (`sh_company_id`,`nickname`),
  KEY `fk_sh_admin_user_sh_company1_idx` (`sh_company_id`),
  CONSTRAINT `fk_sh_admin_user_sh_company1` FOREIGN KEY (`sh_company_id`) REFERENCES `sh_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='后台管理用户表';

CREATE TABLE `sh_admin_user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='管理用户对应的管理组';

CREATE TABLE `sh_alipay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notify_type` varchar(20) NOT NULL DEFAULT '' COMMENT '通知的类型',
  `notify_id` varchar(38) NOT NULL COMMENT '通知校验ID',
  `sign_type` varchar(3) NOT NULL DEFAULT '' COMMENT '签名方式',
  `sign` varchar(130) NOT NULL DEFAULT '' COMMENT '签名',
  `notify_time` datetime NOT NULL COMMENT '通知时间',
  `out_trade_no` varchar(64) NOT NULL DEFAULT '' COMMENT '商户网站唯一订单号',
  `subject` varchar(128) NOT NULL DEFAULT '' COMMENT '商品名称',
  `payment_type` varchar(8) NOT NULL DEFAULT '' COMMENT '支付类型 1为夺宝，2为充值，3',
  `trade_no` varchar(64) NOT NULL DEFAULT '' COMMENT '支付宝交易号',
  `trade_status` varchar(15) NOT NULL DEFAULT '' COMMENT '交易状态',
  `seller_id` varchar(30) NOT NULL DEFAULT '' COMMENT '卖家支付宝用户号',
  `seller_email` varchar(15) NOT NULL DEFAULT '' COMMENT '卖家支付宝账号',
  `buyer_id` varchar(30) NOT NULL DEFAULT '' COMMENT '买家支付宝用户号',
  `buyer_email` varchar(15) NOT NULL DEFAULT '' COMMENT '买家支付宝账号',
  `total_fee` decimal(12,2) NOT NULL COMMENT '交易金额',
  `quantity` int(11) NOT NULL COMMENT '购买数量',
  `price` decimal(12,2) NOT NULL COMMENT '商品单价',
  `body` text NOT NULL COMMENT '商品描述',
  `gmt_create` datetime NOT NULL COMMENT '交易创建时间',
  `gmt_payment` datetime NOT NULL COMMENT '交易付款时间',
  `is_total_fee_adjust` varchar(3) NOT NULL DEFAULT '' COMMENT '是否调整总价',
  `use_coupon` varchar(3) NOT NULL DEFAULT '' COMMENT '是否使用红包买家',
  `discount` decimal(6,2) NOT NULL COMMENT '折扣',
  `refund_status` varchar(18) NOT NULL DEFAULT '' COMMENT '退款状态',
  `gmt_refund` datetime NOT NULL COMMENT '退款时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_alipay_period` (
  `alipay_id` int(11) NOT NULL COMMENT '支付宝支付id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `activity_period_id` int(11) DEFAULT NULL COMMENT '活动期数id',
  `buy_order_id` int(10) unsigned NOT NULL COMMENT '夺宝订单号',
  PRIMARY KEY (`alipay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录阿里与业务的关联';

CREATE TABLE `sh_app_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(45) NOT NULL COMMENT '消息发送类型',
  `adddate` datetime NOT NULL COMMENT '添加日期',
  `sh_period_result_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(11) NOT NULL COMMENT '中奖用户id',
  `ticker` varchar(128) NOT NULL COMMENT '通知栏提示文字',
  `title` varchar(128) NOT NULL COMMENT '通知标题',
  `text` varchar(256) NOT NULL COMMENT '通知文字描述',
  `after_open` varchar(45) NOT NULL COMMENT '点击"通知"的后续行为，默认为打开app,值可以为:  "go_app": 打开应用, "go_url": 跳转到URL, "go_activity": 打开特定的activity  "go_custom": 用户自定义内容',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `send_flag` varchar(1) NOT NULL COMMENT '发送状态：0=待发送，1=发送中，2=发送成功，3=发送失败，4=状态未明   5=测试不发送',
  `alias` varchar(45) DEFAULT NULL,
  `alias_type` varchar(45) DEFAULT NULL,
  `is_real` int(11) NOT NULL,
  `error_code` varchar(45) DEFAULT NULL COMMENT '错误码',
  `error_msg` varchar(512) DEFAULT NULL COMMENT '错误信息',
  `msg_type` varchar(45) NOT NULL COMMENT '消息类型：win:中奖消息   normal: 普通消息    ',
  `display_type` varchar(45) NOT NULL COMMENT '消息类型  notification-通知，message-消息',
  PRIMARY KEY (`id`),
  KEY `fk_sh_period_result_id_idx` (`sh_period_result_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5968 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_app_version` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `version_number` varchar(24) NOT NULL COMMENT '版本号',
  `version_desc` varchar(256) DEFAULT NULL COMMENT '版本说明',
  `is_force` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否强制更新：1：是   0：否',
  `os_type` tinyint(1) NOT NULL COMMENT '系统类型    1：android   2:ios',
  `url` varchar(256) NOT NULL COMMENT '安装包下载地址',
  `sh_admin_user_id` int(10) unsigned DEFAULT NULL COMMENT '上传人',
  PRIMARY KEY (`id`),
  KEY `fk_admin_user_id_idx` (`sh_admin_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_area` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned DEFAULT NULL COMMENT '父级id',
  `code` varchar(32) DEFAULT NULL COMMENT '区域代码',
  `name` varchar(64) DEFAULT NULL COMMENT '区域名称',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开启该地区：1-开启，0-关闭',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1562 DEFAULT CHARSET=utf8 COMMENT='区域表';

CREATE TABLE `sh_autopay_activity_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sh_autopay_main_setting_id` int(11) NOT NULL COMMENT '刷单方案id',
  `sh_activity_id` int(11) NOT NULL COMMENT '活动id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`sh_activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='刷单方案对应活动表';

CREATE TABLE `sh_autopay_main_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) NOT NULL COMMENT '方案名称',
  `frequency` int(11) NOT NULL COMMENT '频率',
  `flag` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用，0:启用，1:关闭',
  `scope_and_rate` varchar(1024) NOT NULL COMMENT '购买人次范围及概率,如：1~10|80,5~50|5',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime NOT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='刷单方案表';

CREATE TABLE `sh_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `link_url` varchar(255) NOT NULL COMMENT '跳转地址，可以是url或一个id，根据type字段区分',
  `pic_url` varchar(255) NOT NULL COMMENT '图片地址',
  `type` tinyint(4) NOT NULL COMMENT '0: 移动端跳转，1：web页面跳转，2：欢迎页大图, 3: 移动端跳转充值页, 4:充值页面图片',
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sort` int(11) NOT NULL DEFAULT '99' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='广告轮播';

CREATE TABLE `sh_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `out_trade_no` varchar(16) NOT NULL DEFAULT '',
  `trade_no` varchar(64) NOT NULL COMMENT '交易号',
  `type` tinyint(1) NOT NULL COMMENT '异常类型：0为漏单，1为虚假订单，2为真实重复订单',
  `buyer_id` varchar(30) NOT NULL COMMENT '卖家账号id',
  `total_fee` decimal(12,2) NOT NULL COMMENT '交易金额',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '是否处理，0为未处理，1为已处理',
  `notify_time` datetime NOT NULL COMMENT '交易时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=385 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_bill_action` (
  `bill_id` int(11) NOT NULL COMMENT '异常表id',
  `trade_no` varchar(45) NOT NULL COMMENT '订单号',
  `sh_user_money_from` varchar(45) DEFAULT '0' COMMENT '用户原余额',
  `sh_user_money_to` varchar(45) NOT NULL DEFAULT '0' COMMENT '用户新余额',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sh_buy_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sh_activity_period_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '第几期',
  `num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买人次',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '购买状态: 0-默认,1-充值成功，2-购买失败，3-已下线，4-用户不存在，5-剩余次数不足，6-数据库事务操作失败，7-夺宝币不足，8-购买成功',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1-支付宝，2-多宝币，3-充值',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级分类id',
  `cat_name` varchar(24) NOT NULL DEFAULT '' COMMENT '分类名称',
  `cat_sign` varchar(24) NOT NULL DEFAULT '' COMMENT '分类标识',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开启：0-否，1-是',
  `create_time` datetime NOT NULL COMMENT '分类创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新分类时间',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `level` tinyint(4) NOT NULL COMMENT '层',
  `left_num` int(10) unsigned NOT NULL,
  `right_num` int(10) unsigned NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `sort` tinyint(3) unsigned NOT NULL COMMENT '排序',
  `top_id` int(10) unsigned NOT NULL COMMENT '顶层id',
  `is_end` tinyint(1) NOT NULL COMMENT '结尾id',
  `pid_path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `img_url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片路径',
  `is_delete` tinyint(4) NOT NULL,
  `goods_num` int(10) unsigned NOT NULL COMMENT '商品数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='分类表';

CREATE TABLE `sh_company` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `company_name` varchar(64) NOT NULL COMMENT '公司名称',
  `address` varchar(128) DEFAULT NULL COMMENT '地址',
  `name` varchar(32) DEFAULT NULL COMMENT '联系人',
  `tel` varchar(32) DEFAULT NULL COMMENT '电话',
  `enabled` enum('0','1') NOT NULL DEFAULT '1' COMMENT '是否启用该公司：0-禁用，1-启用',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='企业表';

CREATE TABLE `sh_count_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trade_num` int(16) NOT NULL COMMENT '交易总次数',
  `trade_money` decimal(12,2) NOT NULL COMMENT '交易总金额',
  `luck_money` decimal(12,2) NOT NULL COMMENT '奖品总金额',
  `create_time` datetime NOT NULL COMMENT '交易时间',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户真假，0为虚拟用户，1为真实用户',
  `start_time` datetime NOT NULL COMMENT '脚本开始时间',
  `end_time` datetime NOT NULL COMMENT '脚本结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COMMENT='交易数据统计表';

CREATE TABLE `sh_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品的自增id',
  `sh_goods_type_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品展示方式表id',
  `sh_app_block_id` int(11) unsigned NOT NULL,
  `sh_area_id` int(11) unsigned NOT NULL,
  `sh_category_id` int(11) unsigned NOT NULL COMMENT '商品所属分类id',
  `sh_user_id` int(11) unsigned NOT NULL COMMENT '用户id ',
  `goods_sn` varchar(60) NOT NULL COMMENT '商品的唯一货号',
  `goods_weight` decimal(10,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '商品的重量，以千克为单位',
  `goods_name` varchar(120) NOT NULL COMMENT '商品的名称',
  `goods_name_style` varchar(60) NOT NULL DEFAULT '+' COMMENT '商品名称显示的样式；包括颜色和字体样式；格式如#ff00ff+strong',
  `click_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品点击数',
  `brand_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '品牌id，取值于ecs_brand 的brand_id',
  `provider_name` varchar(100) NOT NULL COMMENT '供货人的名称，程序还没实现该功能',
  `goods_num` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品库存数量',
  `market_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '市场售价',
  `shop_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本店售价',
  `promote_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '促销价格',
  `promote_start_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '促销价格开始日期',
  `promote_end_date` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '促销价结束日期',
  `warn_num` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '商品报警数量',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '商品关键字，放在商品页的关键字中，为搜索引擎收录用',
  `suppliers_id` smallint(5) unsigned DEFAULT NULL COMMENT '供货商ID',
  `goods_brief` varchar(255) NOT NULL COMMENT '商品的简短描述',
  `goods_desc` text NOT NULL COMMENT '商品的详细描述',
  `goods_thumb` varchar(255) NOT NULL COMMENT '商品在前台显示的微缩图片，如在分类筛选时显示的小图片',
  `goods_img` varchar(255) NOT NULL COMMENT '商品的实际大小图片，如进入该商品页时介绍商品属性所显示的大图片',
  `original_img` varchar(255) NOT NULL COMMENT '应该是上传的商品的原始图片',
  `is_real` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否是实物，1，是；0，否；比如虚拟卡就为0，不是实物',
  `extension_code` varchar(30) NOT NULL COMMENT '商品的扩展属性，比如像虚拟卡',
  `goods_color` varchar(30) NOT NULL COMMENT '商品颜色',
  `is_on_sale` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '该商品是否开放销售，1，是；0，否',
  `is_alone_sale` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否能单独销售，1，是；0，否；如果不能单独销售，则只能作为某商品的配件或者赠品销售',
  `integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买该商品可以使用的积分数量，估计应该是用积分代替金额消费；但程序好像还没有实现该功能',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品的添加时间',
  `sort_order` smallint(4) unsigned NOT NULL DEFAULT '0' COMMENT '应该是商品的显示顺序，不过该版程序中没实现该功能',
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商品是否已经删除，0，否；1，已删除',
  `is_best` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否推荐；0，否；1，是',
  `is_new` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否是新品；0，否；1，是',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否热门，0，否；1，是',
  `is_promote` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否特价促销；0，否；1，是',
  `bonus_type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '购买该商品所能领到的红包类型',
  `last_update` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次更新商品配置的时间',
  `is_shipping` tinyint(1) unsigned NOT NULL COMMENT '是否包邮 0包邮 1 不包邮',
  `goods_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品所属类型id，取值表goods_type的cat_id',
  `seller_note` varchar(255) NOT NULL COMMENT '商品的商家备注，仅商家可见',
  `give_integral` int(11) NOT NULL DEFAULT '-1' COMMENT '购买该商品时每笔成功交易赠送的积分数量。',
  `store_id` int(10) DEFAULT NULL COMMENT '店铺id',
  `tmp_163_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comments` int(11) unsigned NOT NULL,
  `purchase_url` varchar(255) DEFAULT '' COMMENT '采购链接',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `sh_goods_type_id_idx_idx` (`sh_goods_type_id`),
  KEY `sh_app_block_id_idx` (`sh_app_block_id`),
  KEY `sh_area_id_idx` (`sh_area_id`),
  KEY `sh_category_id_idx` (`sh_category_id`),
  KEY `sh_user_id_idx` (`sh_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=332 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品表';

CREATE TABLE `sh_goods_163_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(32) NOT NULL,
  `goods_img` varchar(255) NOT NULL,
  `goods_desc` tinytext NOT NULL,
  `is_real` int(11) NOT NULL,
  `market_price` int(11) NOT NULL,
  `goods_category_id` int(11) NOT NULL,
  `wangyi_goods_id` int(11) NOT NULL,
  `goods_img_qiniu` varchar(255) DEFAULT NULL COMMENT '七牛链接',
  `goods_desc_qiniu` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_goods_163_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_163_id` int(11) NOT NULL,
  `link_url` varchar(255) NOT NULL,
  `pic_url` varchar(255) NOT NULL,
  `pic_url_qiniu` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_goods_163_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) NOT NULL,
  `IPAddress` varchar(255) NOT NULL,
  `nickname` int(11) NOT NULL,
  `avatarPrefix` varchar(255) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_goods_163_winrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) NOT NULL,
  `ip_address` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `avatar_prefix` varchar(255) NOT NULL,
  `create_time` datetime NOT NULL,
  `record_id` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `wangyi_goods_id` int(11) NOT NULL,
  `images` varchar(255) NOT NULL,
  `page` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51321 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_goods_pic` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sh_goods_id` int(11) unsigned NOT NULL COMMENT '商品表id',
  `link_url` varchar(255) NOT NULL DEFAULT '' COMMENT '访问路径',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片服务器存储路径',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否展示图片:1-展示,0:不展示',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '图片类型：0-小图，1-大图',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=906 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_ip_factory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) NOT NULL,
  `country` varchar(20) DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `county` varchar(20) DEFAULT NULL,
  `sp` varchar(6) DEFAULT NULL,
  `remark` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ipfactory_1` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=1878976 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_jnl_alipay` (
  `trade_no` varchar(64) NOT NULL COMMENT '支付宝交易号',
  `notify_type` varchar(20) NOT NULL DEFAULT '' COMMENT '通知的类型',
  `notify_id` varchar(38) NOT NULL COMMENT '通知校验ID',
  `sign_type` varchar(3) NOT NULL DEFAULT '' COMMENT '签名方式',
  `sign` varchar(255) NOT NULL DEFAULT '' COMMENT '签名',
  `notify_time` datetime NOT NULL COMMENT '通知时间',
  `out_trade_no` varchar(64) NOT NULL DEFAULT '' COMMENT '商户网站唯一订单号',
  `subject` varchar(128) NOT NULL DEFAULT '' COMMENT '商品名称',
  `payment_type` varchar(8) NOT NULL DEFAULT '' COMMENT '支付类型 1为夺宝，2为充值，3',
  `trade_status` varchar(15) NOT NULL DEFAULT '' COMMENT '交易状态',
  `seller_id` varchar(30) NOT NULL DEFAULT '' COMMENT '卖家支付宝用户号',
  `seller_email` varchar(15) NOT NULL DEFAULT '' COMMENT '卖家支付宝账号',
  `buyer_id` varchar(30) NOT NULL DEFAULT '' COMMENT '买家支付宝用户号',
  `buyer_email` varchar(15) NOT NULL DEFAULT '' COMMENT '买家支付宝账号',
  `total_fee` decimal(12,2) NOT NULL COMMENT '交易金额',
  `quantity` int(11) NOT NULL COMMENT '购买数量',
  `price` decimal(12,2) NOT NULL COMMENT '商品单价',
  `body` text NOT NULL COMMENT '商品描述',
  `gmt_create` datetime NOT NULL COMMENT '交易创建时间',
  `gmt_payment` datetime NOT NULL COMMENT '交易付款时间',
  `is_total_fee_adjust` varchar(3) NOT NULL DEFAULT '' COMMENT '是否调整总价',
  `use_coupon` varchar(3) NOT NULL DEFAULT '0' COMMENT '是否使用红包买家',
  `discount` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '折扣',
  `refund_status` varchar(18) NOT NULL DEFAULT '0' COMMENT '退款状态',
  `gmt_refund` datetime NOT NULL COMMENT '退款时间',
  PRIMARY KEY (`trade_no`),
  KEY `ix_jnl_alipay_outtradeno` (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sh_jnl_deduct` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `trans_jnl_no` varchar(64) NOT NULL COMMENT '对应得交易流水ID',
  `amount` double NOT NULL COMMENT '交易金额',
  `latest_balance` double NOT NULL COMMENT '交易后最新余额',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_jnl_deduct` (`trans_jnl_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1048391 DEFAULT CHARSET=utf8 COMMENT='用户扣款流水表';

CREATE TABLE `sh_jnl_order_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) NOT NULL COMMENT '订单号',
  `send_time` datetime NOT NULL,
  `send_flag` varchar(1) NOT NULL COMMENT '发送状态：0：待发送  1：发送中  2：发送成功   3：发送失败   4：未知错误',
  `sms_template` varchar(45) NOT NULL COMMENT '短信模板号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_jnl_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `recharge_channel` varchar(6) DEFAULT NULL COMMENT '充值渠道，0=支付宝，1=微信，2=红包,其他待扩展',
  `channel_trade_no` varchar(64) DEFAULT NULL COMMENT '充值渠道厂商的交易流水号',
  `trans_jnl_no` varchar(64) DEFAULT NULL COMMENT '对应得交易流水ID',
  `amount` double NOT NULL COMMENT '交易金额',
  `latest_balance` double NOT NULL COMMENT '交易后最新余额',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_jnl_recharge_jnlno` (`trans_jnl_no`)
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8 COMMENT='用户充值流水表';

CREATE TABLE `sh_jnl_sign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '签到时间',
  `ip` varchar(45) NOT NULL,
  `os_type` varchar(2) NOT NULL,
  `cookie` varchar(128) NOT NULL,
  `continue_num` int(11) NOT NULL COMMENT '连续签到天数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COMMENT='签到表';

CREATE TABLE `sh_jnl_trans` (
  `jnl_no` varchar(64) NOT NULL COMMENT '交易流水号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `trans_code` varchar(45) NOT NULL COMMENT '用于表示此交易类型的字符串',
  `jnl_status` varchar(10) NOT NULL COMMENT '状态.0=新建，1=付款成功，2=付款失败，3=超时未处理，4=交易完成,其他待扩展',
  `jnl_message` varchar(64) DEFAULT NULL COMMENT '交易状态描述',
  `pay_type` varchar(10) DEFAULT NULL COMMENT '支付类型,0=大订单，1=子订单，其他待扩展',
  `recharge_channel` varchar(6) DEFAULT NULL COMMENT '充值渠道，0=支付宝，1=微信，2=红包，其他待扩展',
  `amount` double NOT NULL COMMENT '交易总金额',
  `amount_balance` double DEFAULT NULL COMMENT '交易总金额中所需的余额部分',
  `amount_pay` double DEFAULT NULL COMMENT '交易总金额中所需的支付部分',
  `amount_other` double DEFAULT NULL COMMENT '交易总金额中所需的其他部分(积分、红包等待扩展)',
  `jnl_recharge_id` int(11) DEFAULT NULL COMMENT '充值流水ID，用于关联充值信息,动帐后必须更新此值',
  `repacket_id` bigint(18) DEFAULT NULL COMMENT '红包ID，用于关联红包信息,动帐后必须更新此值',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`jnl_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易日志表';

CREATE TABLE `sh_jnl_trans_duobao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_jnl_no` varchar(64) NOT NULL COMMENT '对应的交易流水号',
  `sh_activity_period_id` int(11) NOT NULL,
  `num` int(11) NOT NULL,
  `status` varchar(1) NOT NULL COMMENT '夺宝状态，0=新建,1=夺宝成功，2=夺宝失败',
  `message` varchar(64) DEFAULT NULL COMMENT '结果描述信息',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_jnl_duobao_jnlno` (`trans_jnl_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1050891 DEFAULT CHARSET=utf8 COMMENT='每笔交易下单夺宝信息';

CREATE TABLE `sh_jnl_weixin` (
  `transaction_id` varchar(64) NOT NULL COMMENT '微信支付订单号',
  `out_trade_no` varchar(64) NOT NULL DEFAULT '' COMMENT '商户网站唯一订单号',
  `total_fee` int(16) NOT NULL COMMENT '总金额',
  `nonce_str` varchar(32) NOT NULL COMMENT '随机字符串',
  `sign` varchar(32) NOT NULL COMMENT '签名',
  `create_time` datetime NOT NULL COMMENT '交易起始时间',
  `time_expire` datetime NOT NULL COMMENT '交易结束时间',
  `time_end` varchar(14) NOT NULL COMMENT '交易完成时间',
  `is_subscribe` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否关注公众账号',
  `trade_type` varchar(16) NOT NULL DEFAULT 'APP' COMMENT '交易类型',
  `bank_type` varchar(16) NOT NULL DEFAULT 'CFT' COMMENT '付款银行',
  `fee_type` varchar(8) NOT NULL DEFAULT 'CNY' COMMENT '货币种类',
  `cash_fee` int(16) NOT NULL DEFAULT '0' COMMENT '现金支付金额',
  `appid` varchar(32) NOT NULL COMMENT '公众账号ID',
  `mch_id` varchar(32) NOT NULL COMMENT '商户号',
  `openid` varchar(32) NOT NULL COMMENT '用户标识',
  `return_code` varchar(10) NOT NULL COMMENT '返回结果',
  PRIMARY KEY (`transaction_id`),
  KEY `sh_jnl_weixin_outtradeno` (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微信支付订单表';

CREATE TABLE `sh_lottery_shishi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `expect` varchar(12) NOT NULL COMMENT '开奖期数',
  `open_code` varchar(9) NOT NULL COMMENT '开奖号码',
  `open_time` datetime NOT NULL COMMENT '开奖时间',
  `open_time_stamp` varchar(13) NOT NULL COMMENT '开奖时间戳',
  `real_open_time` datetime DEFAULT NULL COMMENT '真正开奖时间',
  `lottery_code` varchar(24) NOT NULL COMMENT '时时彩类型，如：重庆时时彩：ccssc、黑龙江时时彩：hljssc',
  `source` char(1) NOT NULL DEFAULT '1' COMMENT '来源：1:百度，2:彩票控',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `expect` (`expect`,`open_time`,`lottery_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4291085 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_order_action` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '被操作的交易号',
  `user_id` int(11) NOT NULL COMMENT '操作该次的人员id',
  `user_type` char(1) NOT NULL COMMENT '0:普通用户，1:管理员',
  `order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '作何操作.0，未确认；1，已确认；2，已取消；3，无效；4，退货；',
  `shipping_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态。0，未发货；1，已发货；2，已收货；3，备货中',
  `pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态.0,未付款;1,付款中;2,已付款;',
  `action_note` varchar(255) NOT NULL COMMENT '操作备注',
  `log_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8 COMMENT='对订单操作日志表';

CREATE TABLE `sh_order_info` (
  `order_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单基本信息自增ID',
  `order_sn` varchar(20) NOT NULL COMMENT '订单号，唯一',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id，同co_users的user_id',
  `order_status` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '订单状态。0，未确认；1，已确认；2，已完成；3，已取消；4，无效；5，退货；6,已删除',
  `shipping_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商品配送情况，0，未发货；1，已发货；2，已收货；3，备货中',
  `pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态；0，未付款；1，付款中；2，已付款',
  `consignee` varchar(60) NOT NULL DEFAULT '' COMMENT '收货人的姓名，用户页面填写，默认取值于表user_address',
  `country` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的国家，用户页面填写，默认取值于表user_address，其id对应的值在co_region',
  `province` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的省份，用户页面填写，默认取值于表user_address，其id对应的值在co_region',
  `city` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的城市，用户页面填写，默认取值于表user_address，其id对应的值在co_region',
  `district` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '收货人的地区，用户页面填写，默认取值于表user_address，其id对应的值在co_region',
  `address` varchar(255) NOT NULL COMMENT '收货人的详细地址，用户页面填写，默认取值于表user_address',
  `zipcode` varchar(60) NOT NULL COMMENT '收货人的邮编，用户页面填写，默认取值于表user_address',
  `tel` varchar(60) NOT NULL COMMENT '收货人的电话，用户页面填写，默认取值于表user_address',
  `mobile` varchar(60) NOT NULL COMMENT '收货人的手机，用户页面填写，默认取值于表user_address',
  `email` varchar(60) NOT NULL DEFAULT '' COMMENT '收货人的邮箱，用户页面填写，默认取值于表user_address',
  `best_time` varchar(120) NOT NULL COMMENT '收货人的最佳送货时间，用户页面填写，默认取值于表user_address',
  `sign_building` varchar(120) NOT NULL COMMENT '收货人的地址的标志性建筑，用户页面填写，默认取值于表user_address',
  `postscript` varchar(255) NOT NULL COMMENT '订单附言，由用户提交订单前填写',
  `shipping_id` tinyint(3) NOT NULL DEFAULT '0' COMMENT '用户选择的配送方式id，取值表ecs_shipping',
  `shipping_name` varchar(120) NOT NULL COMMENT '用户选择的配送方式的名称，取值表ecs_shipping',
  `pay_id` tinyint(3) NOT NULL DEFAULT '0' COMMENT '用户选择的支付方式的id，取值表ecs_payment',
  `pay_name` varchar(120) NOT NULL COMMENT '用户选择的支付方式的名称，取值表ecs_payment',
  `how_oos` varchar(120) NOT NULL COMMENT '缺货处理方式，等待所有商品备齐后再发； 取消订单；与店主协商',
  `how_surplus` varchar(120) NOT NULL COMMENT '根据字段猜测应该是余额处理方式，程序未作这部分实现',
  `pack_name` varchar(120) NOT NULL DEFAULT '' COMMENT '包装名称，取值表co_pack',
  `card_name` varchar(120) NOT NULL DEFAULT '' COMMENT '贺卡的名称，取值co_card ',
  `card_message` varchar(255) NOT NULL COMMENT '贺卡内容，由用户提交',
  `inv_payee` varchar(120) NOT NULL COMMENT '发票抬头，用户页面填写',
  `inv_content` varchar(120) NOT NULL DEFAULT '' COMMENT '发票内容，用户页面选择，取值co_shop_config的code字段的值为invoice_content的value',
  `goods_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品总金额',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '配送费用',
  `insure_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '保价费用',
  `pay_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '支付费用,跟支付方式的配置相关，取值表co_payment',
  `pack_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '包装费用，取值表取值表co_pack',
  `card_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '贺卡费用，取值co_card ',
  `money_paid` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已付款金额',
  `surplus` decimal(10,2) unsigned zerofill NOT NULL DEFAULT '00000000.00' COMMENT '该订单使用余额的数量，取用户设定余额，用户可用余额，订单金额中最小者',
  `integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用的积分的数量，取用户使用积分，商品可用积分，用户拥有积分中最小者',
  `integral_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '使用积分金额',
  `bonus` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '使用红包金额',
  `order_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应付款金额',
  `from_ad` smallint(5) NOT NULL DEFAULT '0' COMMENT '订单由某广告带来的广告id，应该取值于co_ad',
  `referer` varchar(255) NOT NULL COMMENT '订单的来源页面',
  `add_time` datetime NOT NULL COMMENT '订单生成时间',
  `confirm_time` datetime NOT NULL COMMENT '订单确认时间',
  `pay_time` datetime NOT NULL COMMENT '订单支付时间',
  `shipping_time` datetime DEFAULT NULL COMMENT '订单配送时间',
  `receive_time` datetime DEFAULT NULL COMMENT '收货时间',
  `pack_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '包装id，取值取值表co_pack',
  `card_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '贺卡id，用户在页面选择，取值取值ecs_card ',
  `bonus_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '红包的id，co_user_bonus的bonus_id',
  `invoice_no` varchar(50) NOT NULL COMMENT '发货单号，发货时填写，可在订单查询查看',
  `extension_code` varchar(30) NOT NULL COMMENT '通过活动购买的商品的代号；GROUP_BUY是团购；AUCTION，是拍卖；SNATCH，夺宝奇兵；正常普通产品该处为空',
  `extension_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '通过活动购买的物品的id，取值co_goods_activity；如果是正常普通商品，该处为0',
  `to_buyer` varchar(255) NOT NULL COMMENT '商家给客户的留言,当该字段有值时可以在订单查询看到',
  `pay_note` varchar(255) NOT NULL COMMENT '付款备注，在订单管理里编辑修改',
  `agency_id` smallint(5) unsigned NOT NULL COMMENT '该笔订单被指派给的办事处的id，根据订单内容和办事处负责范围自动决定，也可以有管理员修改，取值于表ecs_agency',
  `inv_type` varchar(60) NOT NULL DEFAULT '' COMMENT '发票类型，用户页面选择，取值co_shop_config的code字段的值为invoice_type的value',
  `tax` decimal(10,2) NOT NULL COMMENT '发票税额',
  `is_separate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0，未分成或等待分成；1，已分成；2，取消分成；',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '能获得推荐分成的用户id，id取值于表co_users',
  `discount` decimal(10,2) NOT NULL COMMENT '折扣金额',
  `sh_period_result_id` int(11) unsigned NOT NULL,
  `express_company` varchar(256) DEFAULT NULL COMMENT '快递公司',
  `is_shaidan` char(1) DEFAULT '0' COMMENT '0：未晒单 ，1：已晒单',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_sn` (`order_sn`),
  UNIQUE KEY `sh_period_result_id` (`sh_period_result_id`),
  KEY `user_id` (`user_id`),
  KEY `order_status` (`order_status`),
  KEY `shipping_status` (`shipping_status`),
  KEY `pay_status` (`pay_status`),
  KEY `shipping_id` (`shipping_id`),
  KEY `pay_id` (`pay_id`),
  KEY `extension_code` (`extension_code`,`extension_id`),
  KEY `agency_id` (`agency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8899 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='订单的配送，贺卡等详细信息';

CREATE TABLE `sh_pay_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `tel` varchar(24) NOT NULL COMMENT '用户手机号',
  `trans_jnl_no` varchar(64) NOT NULL DEFAULT '' COMMENT '对应得交易流水ID',
  `trans_code` varchar(45) DEFAULT '0' COMMENT '用于表示此交易类型的字符串',
  `jnl_status` varchar(10) NOT NULL DEFAULT '0' COMMENT '状态.0=新建，1=付款成功，2=付款失败，3=超时未处理，4=交易完成,其他待扩展',
  `pay_type` varchar(10) NOT NULL DEFAULT '' COMMENT '支付类型,0=余额，1=充值，其他待扩展',
  `amount` double NOT NULL COMMENT '交易总金额',
  `create_time` datetime NOT NULL,
  `recharge_channel` varchar(6) NOT NULL DEFAULT '0' COMMENT '充值渠道，0=支付宝，1=微信，2=红包,其他待扩展',
  `duobao_id` int(11) NOT NULL DEFAULT '0' COMMENT '夺宝id',
  `bill_id` int(11) NOT NULL DEFAULT '0' COMMENT '异常id',
  `status` int(1) NOT NULL COMMENT '夺宝状态，0=新建,1=夺宝成功，2=夺宝失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13963 DEFAULT CHARSET=utf8 COMMENT='交易记录表';

CREATE TABLE `sh_period_result` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sh_activity_period_id` int(11) NOT NULL COMMENT '活动期数',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `a_code` varchar(64) NOT NULL COMMENT '数值A\n',
  `lottery_code` varchar(64) NOT NULL COMMENT '福彩开奖号码（数值B）',
  `lottery_period` varchar(64) NOT NULL COMMENT '福彩期号',
  `remainder` int(11) unsigned NOT NULL COMMENT '余数',
  `proto_code` varchar(45) DEFAULT NULL COMMENT '原始数',
  `luck_code` varchar(64) NOT NULL COMMENT '幸运号',
  `a_code_create_time` datetime NOT NULL COMMENT 'A数值生成时间',
  `lottery_code_create_time` datetime NOT NULL COMMENT '福彩开奖时间',
  `luck_code_create_time` datetime NOT NULL COMMENT '幸运号开奖时间',
  `pre_luck_code_create_time` datetime NOT NULL COMMENT '预计幸运号开奖时间',
  PRIMARY KEY (`id`),
  KEY `index2` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7689 DEFAULT CHARSET=utf8 COMMENT='中奖表\n一期一条记录，对应一个中奖用户，';

CREATE TABLE `sh_period_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sh_activity_period_id` int(11) unsigned NOT NULL COMMENT '活动期数',
  `create_time` datetime NOT NULL COMMENT '夺宝时间',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `times` int(11) NOT NULL COMMENT '参与人次',
  `buy_id` varchar(45) DEFAULT NULL COMMENT '购买ID',
  `is_pay` tinyint(1) DEFAULT '0' COMMENT '是否支付\n1—支付\n0—未支付',
  `ip` varchar(45) DEFAULT NULL COMMENT 'ip地址',
  `ip_address` varchar(45) DEFAULT NULL COMMENT 'ip对应的地理信息',
  PRIMARY KEY (`id`),
  KEY `sh_period_user_shActivityPeriodId` (`sh_activity_period_id`),
  KEY `sh_period_user_userId` (`user_id`),
  KEY `sh_period_user_buyId` (`buy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1685700 DEFAULT CHARSET=utf8 COMMENT='用户参与期数表\n与活动期数表n-1';

CREATE TABLE `sh_rbac_access` (
  `role_id` smallint(6) unsigned NOT NULL,
  `node_id` smallint(6) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sh_rbac_node` (
  `node_id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `action` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `remark` varchar(255) NOT NULL DEFAULT '"',
  `sort` smallint(6) unsigned NOT NULL,
  `pid` smallint(6) unsigned NOT NULL,
  `pid_path` varchar(255) NOT NULL COMMENT '完整路径',
  `level` tinyint(1) unsigned NOT NULL,
  `is_end` tinyint(1) NOT NULL DEFAULT '0',
  `top_id` int(10) unsigned NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '节点类型：目录，页面，页面模块',
  `url` varchar(255) NOT NULL DEFAULT '"' COMMENT '页面url',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`node_id`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_rbac_role` (
  `role_id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` int(11) unsigned NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_rbac_role_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_rbac_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(32) NOT NULL,
  `nick_name` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `salt` char(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `login_name_UNIQUE` (`login_name`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_recharge` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sh_user_id` int(11) unsigned NOT NULL COMMENT '用户表id',
  `payment_type` enum('0','1','2','3') NOT NULL DEFAULT '0' COMMENT '0为支付宝，1为微信，2为网银，3为其他',
  `create_time` datetime NOT NULL COMMENT '充值时间',
  `total_fee` decimal(12,2) NOT NULL COMMENT '交易金额',
  `payment_status` enum('0','1') NOT NULL DEFAULT '0' COMMENT '1为已付款，0为未付款',
  PRIMARY KEY (`id`),
  KEY `fk_sh_recharge_sh_user_idx` (`sh_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1533 DEFAULT CHARSET=utf8 COMMENT='用户充值表';

CREATE TABLE `sh_red_money` (
  `id` bigint(18) unsigned NOT NULL COMMENT '红包编号',
  `sh_red_money_batch_id` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '红包批次表ID',
  `sh_red_money_price_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '批次单价表ID',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态，0未发放，1已发放',
  `issue_time` datetime DEFAULT NULL COMMENT '发放时间',
  `sh_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `is_new_red_money` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0新红包，1旧红包',
  `is_receive` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0未领取，1已领取',
  `is_use` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0未使用，1已使用',
  `is_overdue` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0未过期，1已过期',
  `receive_time` datetime DEFAULT NULL COMMENT '领取时间',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  `overdue_time` datetime DEFAULT NULL COMMENT '过期时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包详情表';

CREATE TABLE `sh_red_money_activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sh_red_money_batch_id` bigint(11) NOT NULL DEFAULT '0' COMMENT '红包批次表ID',
  `sh_activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动表ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=480 DEFAULT CHARSET=utf8 COMMENT='批次与活动关系表';

CREATE TABLE `sh_red_money_batch` (
  `id` bigint(16) unsigned NOT NULL,
  `red_money_name` varchar(40) NOT NULL COMMENT '红包名称',
  `is_auto` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：自动，1：手动',
  `recharge` tinyint(1) NOT NULL DEFAULT '0' COMMENT '充值送,0否，1为充30，2为充50，3为充100，其他',
  `sign` tinyint(1) NOT NULL DEFAULT '0' COMMENT '签到连续,0否，1是5天，2为10天，其他',
  `buy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '累计购买次数送,0否，1为100，2为150，其他',
  `new_user` tinyint(1) NOT NULL DEFAULT '0' COMMENT '新用户领取,0否，1是',
  `inviter` tinyint(1) NOT NULL DEFAULT '0' COMMENT '邀请者奖励,0否，1是',
  `num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `end_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '剩余数量',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总价',
  `consumption` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '消费限制，0.00为无限制',
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '最后操作人',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：不取消，1：取消',
  `begin_date` datetime NOT NULL COMMENT '活动开始日期',
  `end_date` datetime NOT NULL COMMENT '活动截止日期',
  `create_time` datetime NOT NULL COMMENT '活动创建时间',
  `is_start` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0为不启用，1为启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='红包批次表';

CREATE TABLE `sh_red_money_price` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sh_red_money_batch_id` bigint(16) NOT NULL DEFAULT '0' COMMENT '红包批次表ID',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单价',
  `num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `end_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '剩余数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='批次与单价关系表';

CREATE TABLE `sh_red_packet` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tel` varchar(24) NOT NULL COMMENT '手机号',
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `expiry_time` datetime NOT NULL COMMENT '有效期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `sh_activity_id` int(11) unsigned NOT NULL COMMENT '活动id',
  `flag` varchar(2) NOT NULL DEFAULT '0' COMMENT '0: 初始状态（未使用）	1：红包转余额',
  `os_type` tinyint(1) NOT NULL DEFAULT '3' COMMENT '系统类型    1：android   2:ios  3: 未知',
  `channel` varchar(10) NOT NULL DEFAULT '7' COMMENT '渠道标志：1：微信朋友圈  2：微信好友   3：新浪微博   4：QQ   5: QQ空间  6：电子邮件   7：商户推广',
  `source` varchar(45) NOT NULL DEFAULT '1' COMMENT '来源：1：商户  2：客户端邀请好友  3：官方(世和)',
  `send_flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=940 DEFAULT CHARSET=utf8 COMMENT='红包表';

CREATE TABLE `sh_report` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `sh_report_shaidan` (
  `sh_shaidan_id` int(11) NOT NULL COMMENT '晒单id',
  `sh_report_id` int(11) NOT NULL COMMENT '举报详情id',
  `report_num` int(11) NOT NULL DEFAULT '0' COMMENT '已举报次数',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  `update_time` datetime NOT NULL COMMENT '更新日期',
  `report_user_id` int(10) DEFAULT NULL COMMENT '举报人id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sh_searchword` (
  `word` varchar(8) NOT NULL COMMENT '关键词',
  `num` varchar(45) DEFAULT NULL COMMENT '搜索次数',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户搜索的关键词';

CREATE TABLE `sh_shaidan_img` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sh_user_shaidan_id` int(11) DEFAULT NULL,
  `img_url` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_shop` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '合作商家信息表',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `head_name` varchar(60) NOT NULL COMMENT '商家名称',
  `branch_name` varchar(60) DEFAULT NULL COMMENT '分店名称',
  `country` smallint(5) NOT NULL DEFAULT '0' COMMENT '商家所属国家',
  `province` smallint(5) NOT NULL DEFAULT '0' COMMENT '商家所属省份',
  `city` smallint(5) NOT NULL DEFAULT '0' COMMENT '商家所属城市',
  `district` varchar(120) NOT NULL DEFAULT '0' COMMENT '商家所属的地区',
  `address` varchar(120) NOT NULL COMMENT '详细地址',
  `area` decimal(12,2) NOT NULL COMMENT '店铺面积（㎡）',
  `table_num` int(11) NOT NULL COMMENT '餐桌数',
  `max_customer_num` int(11) NOT NULL COMMENT '可容纳人数（人）',
  `avg_repeat_table` decimal(12,2) DEFAULT NULL COMMENT '日均翻桌率（次)',
  `avg_orders_num` int(11) DEFAULT NULL COMMENT '日均账单数',
  `avg_meal_time` decimal(12,2) DEFAULT NULL COMMENT '平均每桌用餐时间（分钟）',
  `avg_customer_num` int(11) DEFAULT NULL COMMENT '日均人流量（人）',
  `workday_customer_rate` int(11) DEFAULT NULL COMMENT '工作日人流量（人）',
  `holiday_customer_rate` int(11) DEFAULT NULL COMMENT '节假日人流量(人)',
  `rush_hours` varchar(120) DEFAULT NULL COMMENT '每日高峰时段',
  `rush_hours_rate` int(11) DEFAULT NULL COMMENT '高峰时段平均人流量（人）',
  `is_outside_order` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否提供外送服务 1:是  0:否',
  `avg_outside_order` int(11) DEFAULT NULL COMMENT '日均外送订单数（单）',
  `wifi_name` varchar(45) DEFAULT NULL COMMENT '店铺WiFi网络名称',
  `wifi_pwd` varchar(45) DEFAULT NULL COMMENT '店铺WiFi网络密码',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用：0：否   1：是',
  `duobao_sum` int(11) NOT NULL DEFAULT '0' COMMENT '总计夺宝人次 ',
  `red_amount` double NOT NULL DEFAULT '0' COMMENT '消费金额(仅红包)',
  `no_red_amount` double NOT NULL DEFAULT '0' COMMENT '消费金额(不含红包)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='商户表';

CREATE TABLE `sh_shop_download` (
  `sh_shop_id` int(11) DEFAULT NULL COMMENT '商家id',
  `sh_shop_sub_id` int(11) NOT NULL DEFAULT '0',
  `cookie` varchar(63) NOT NULL COMMENT 'cookie',
  `user_agent` varchar(64) NOT NULL,
  `user_ip` varchar(64) NOT NULL DEFAULT '',
  `phone_num` varchar(11) NOT NULL,
  `scene` varchar(1) NOT NULL COMMENT '场景：1：桌贴，2：桌立，3：易拉宝，4：厕所',
  `os_type` tinyint(1) NOT NULL COMMENT '系统类型    1：android   2:ios  3: 未知',
  `channel` varchar(45) NOT NULL DEFAULT '7' COMMENT '1：微信朋友圈  2：微信好友   3：新浪微博   4：QQ   5: QQ空间  6：电子邮件   7：商户推广',
  `source` varchar(45) NOT NULL DEFAULT '1' COMMENT '来源：1：商户  2：客户端邀请好友  3：官方(世和)',
  `create_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sh_shop_scan` (
  `sh_shop_id` int(11) DEFAULT NULL COMMENT '商家id',
  `sh_shop_sub_id` int(11) NOT NULL DEFAULT '0',
  `cookie` varchar(63) NOT NULL COMMENT 'cookie',
  `user_agent` varchar(64) NOT NULL,
  `user_ip` varchar(64) NOT NULL DEFAULT '',
  `scene` varchar(1) NOT NULL COMMENT '场景：1：桌贴，2：桌立，3：易拉宝，4：厕所',
  `os_type` tinyint(1) NOT NULL COMMENT '系统类型    1：android   2:ios  3: 未知',
  `channel` varchar(45) NOT NULL DEFAULT '7' COMMENT '1：微信朋友圈  2：微信好友   3：新浪微博   4：QQ   5: QQ空间  6：电子邮件   7：商户推广',
  `source` varchar(45) NOT NULL DEFAULT '1' COMMENT '来源：1：商户  2：客户端邀请好友  3：官方(世和)',
  `create_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='扫码';

CREATE TABLE `sh_shop_share` (
  `sh_shop_id` int(10) unsigned NOT NULL COMMENT '商家ID',
  `days` int(11) NOT NULL DEFAULT '0' COMMENT '累计推广天数',
  `scan_sum` int(11) NOT NULL DEFAULT '0' COMMENT '扫码人数',
  `scan_sum_android` int(11) NOT NULL DEFAULT '0' COMMENT 'android扫码数',
  `scan_sum_ios` int(11) NOT NULL DEFAULT '0' COMMENT 'ios扫码数',
  `avg_scan_sum` int(11) NOT NULL DEFAULT '0' COMMENT '平均每天的扫码数',
  `scan_num` int(11) NOT NULL DEFAULT '0' COMMENT '领红包人数',
  `red_packet_android` int(11) NOT NULL DEFAULT '0' COMMENT 'android 领红包人数',
  `red_packet_ios` int(11) NOT NULL DEFAULT '0' COMMENT 'ios 领红包人数',
  `real_num` int(11) NOT NULL DEFAULT '0' COMMENT '注册用户',
  `avg_real_num` int(11) NOT NULL DEFAULT '0' COMMENT '平均每天注册人数',
  `percent` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT '用户转化率(注册人数real_num/领红包人数scan_num)',
  `scene_one` int(11) NOT NULL DEFAULT '0' COMMENT '场景1：桌贴  领红包人数',
  `scene_two` int(11) NOT NULL DEFAULT '0' COMMENT '场景2：桌立 领红包人数',
  `scene_three` int(11) NOT NULL DEFAULT '0' COMMENT '场景三：易拉宝 领红包人数',
  `scene_four` int(11) NOT NULL DEFAULT '0' COMMENT '场景四：厕所 领红包人数',
  `insert_date` datetime NOT NULL,
  `scene_one_scan` int(11) NOT NULL DEFAULT '0' COMMENT '场景1：桌贴  扫码人数',
  `scene_two_scan` int(11) NOT NULL DEFAULT '0' COMMENT '场景2：桌立 扫码人数',
  `scene_three_scan` int(11) NOT NULL DEFAULT '0' COMMENT '场景三：易拉宝 扫码人数',
  `scene_four_scan` int(11) NOT NULL DEFAULT '0' COMMENT '场景四：厕所 扫码人数',
  `red_packet_percent` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT '领红包率（领红包人数scan_num/扫码人数scan_sum）',
  `duobao_sum` int(11) NOT NULL DEFAULT '0' COMMENT '共计夺宝(人次)',
  `red_amount` double NOT NULL DEFAULT '0' COMMENT '消费金额(仅红包)',
  `no_red_amount` double NOT NULL DEFAULT '0' COMMENT '消费金额(不含红包)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户推广总计';

CREATE TABLE `sh_shop_share_history` (
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `date` varchar(24) NOT NULL COMMENT '日期',
  `avg_customer_sum` int(11) NOT NULL DEFAULT '0' COMMENT '日均客流量',
  `avg_scan_sum` int(11) NOT NULL DEFAULT '0',
  `scan_sum` int(11) NOT NULL DEFAULT '0' COMMENT '扫码人数',
  `scan_sum_android` int(11) NOT NULL DEFAULT '0',
  `scan_sum_ios` int(11) NOT NULL DEFAULT '0',
  `red_packet_sum` int(11) NOT NULL DEFAULT '0' COMMENT '领取红包人数',
  `red_packet_android` int(11) NOT NULL DEFAULT '0',
  `red_packet_ios` int(11) NOT NULL DEFAULT '0',
  `percent_scan` varchar(45) NOT NULL DEFAULT '0.00%' COMMENT '扫码率',
  `avg_real_sum` int(11) NOT NULL DEFAULT '0',
  `real_sum` int(11) NOT NULL DEFAULT '0' COMMENT '注册用户',
  `percent` varchar(45) NOT NULL DEFAULT '0.00%' COMMENT '用户转化率',
  `scene_one_sum` int(11) NOT NULL DEFAULT '0' COMMENT '桌贴领红包人数',
  `scene_two_sum` int(11) NOT NULL DEFAULT '0' COMMENT '桌立描码人数',
  `scene_three_sum` int(11) NOT NULL DEFAULT '0' COMMENT '易拉宝描码人数',
  `scene_four_sum` int(11) NOT NULL DEFAULT '0' COMMENT '厕所描码人数',
  `scene_one_scan` int(11) NOT NULL DEFAULT '0' COMMENT '桌贴描码人数',
  `scene_two_scan` int(11) NOT NULL DEFAULT '0',
  `scene_three_scan` int(11) NOT NULL DEFAULT '0',
  `scene_four_scan` int(11) NOT NULL DEFAULT '0',
  `duobao_sum` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每天商户推广总计表';

CREATE TABLE `sh_shop_system` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '商家ID',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `linkman` varchar(60) NOT NULL DEFAULT '' COMMENT '联系人',
  `shop_name` varchar(60) NOT NULL DEFAULT '' COMMENT '商家名称',
  `branch_name` varchar(60) DEFAULT NULL COMMENT '分店名称',
  `country` smallint(5) NOT NULL DEFAULT '0' COMMENT '商家所属国家',
  `province` smallint(5) NOT NULL DEFAULT '0' COMMENT '商家所属省份',
  `city` smallint(5) NOT NULL DEFAULT '0' COMMENT '商家所属城市',
  `district` varchar(120) DEFAULT NULL COMMENT '商家所属的地区',
  `address` varchar(120) NOT NULL COMMENT '详细地址',
  `area` decimal(12,2) NOT NULL COMMENT '店铺面积（㎡）',
  `zipcode` varchar(60) DEFAULT NULL COMMENT '收货人的邮编',
  `tel` varchar(60) NOT NULL DEFAULT '' COMMENT '联系方式',
  `sign_building` varchar(120) DEFAULT NULL COMMENT '收货地址的标志性建筑名',
  `best_time` varchar(120) DEFAULT NULL COMMENT '收货人的最佳收货时间',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认收货地址：0否，1是',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='商户表';

CREATE TABLE `sh_shop_tel` (
  `sh_shop_id` int(10) unsigned NOT NULL COMMENT '商家id',
  `sh_shop_channel_id` int(11) NOT NULL DEFAULT '0' COMMENT '商家渠道ID',
  `sh_user_tel` varchar(24) NOT NULL COMMENT '用户手机号',
  `create_time` datetime NOT NULL,
  `scene` varchar(1) NOT NULL DEFAULT '1' COMMENT '1：桌贴，2：桌立，3：易拉宝，4：厕所',
  KEY `fk_sh_shop_id_idx` (`sh_shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户推广的用户表';

CREATE TABLE `sh_show_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `title` varchar(256) NOT NULL,
  `content` varchar(2048) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sh_period_num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='晒单表';

CREATE TABLE `sh_sms_notify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adddate` datetime NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `tel` varchar(24) NOT NULL COMMENT '收信人手机号',
  `content` varchar(256) NOT NULL COMMENT '短信内容',
  `send_time` datetime NOT NULL COMMENT '发送时间',
  `send_flag` varchar(1) NOT NULL COMMENT '0=待发送，1=发送中，2=发送成功，3=发送失败，4=状态未明   5=测试不发送',
  `sh_period_result_id` int(10) unsigned NOT NULL,
  `is_real` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sh_period_result_id_idx` (`sh_period_result_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5927 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='短信通知';

CREATE TABLE `sh_system_config` (
  `ios_audit` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'iOS 审核开关',
  `alipay_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '支付宝支付显示',
  `weixinpay_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '微信支付显示',
  PRIMARY KEY (`ios_audit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统设置';

CREATE TABLE `sh_system_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '通知id',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `title` varchar(45) NOT NULL COMMENT '通知标题',
  `content` varchar(1024) NOT NULL COMMENT '通知内容',
  `user_id` int(11) DEFAULT NULL COMMENT '发布人ID',
  `status` varchar(1) NOT NULL DEFAULT '1' COMMENT '状态：1：可用，0：禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='手机消息推送';

CREATE TABLE `sh_system_opinion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='系统意见反馈';

CREATE TABLE `sh_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `tel` varchar(24) NOT NULL COMMENT '用户手机号',
  `email` varchar(32) NOT NULL DEFAULT '' COMMENT '邮箱',
  `real_name` varchar(32) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `nick_name` varchar(32) NOT NULL COMMENT '用户昵称',
  `password` varchar(40) NOT NULL COMMENT '用户密码',
  `locked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '冻结账户登陆：0-不冻结，1-冻结',
  `sh_id` varchar(32) NOT NULL COMMENT '世和id',
  `signature` varchar(64) NOT NULL DEFAULT '' COMMENT '个性签名',
  `salt` varchar(16) NOT NULL DEFAULT '' COMMENT '密码加密随机生成的字符串',
  `create_time` int(10) NOT NULL COMMENT '注册时间',
  `token` varchar(50) NOT NULL DEFAULT '' COMMENT '帐号激活码',
  `token_exptime` int(10) NOT NULL COMMENT '激活码有效期',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0-未激活，1-已激活',
  `is_delete` tinyint(4) NOT NULL,
  `head_pic` varchar(255) NOT NULL DEFAULT '',
  `money` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `is_real` int(11) NOT NULL DEFAULT '1' COMMENT '是否真实用户默认为1,1：真实用户；0:假用户',
  `login_sms_code` varchar(6) NOT NULL DEFAULT '',
  `login_sms_code_expire` int(10) unsigned NOT NULL DEFAULT '0',
  `set_cookie` varchar(512) DEFAULT NULL COMMENT 'cookie',
  `os_type` varchar(10) NOT NULL DEFAULT '10' COMMENT '第一位代表android,第二位代表ios, (1:登陆过  0:从未登陆)',
  `session_id` char(40) NOT NULL DEFAULT '' COMMENT '单点登录验证session id',
  `is_new_user` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是新用户  0为新用户，1为不是新用户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39283 DEFAULT CHARSET=utf8 COMMENT='用户常用信息表';

CREATE TABLE `sh_user_address` (
  `address_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `consignee` varchar(60) NOT NULL COMMENT '收货人的名字',
  `email` varchar(60) NOT NULL COMMENT '收货人的email',
  `country` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的国家',
  `province` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的省份',
  `city` smallint(5) NOT NULL DEFAULT '0' COMMENT '收货人的城市',
  `district` varchar(120) NOT NULL DEFAULT '0' COMMENT '收货人的地区',
  `address` varchar(120) NOT NULL COMMENT '收货人的详细地址',
  `zipcode` varchar(60) NOT NULL COMMENT '收货人的邮编',
  `tel` varchar(60) NOT NULL COMMENT '收货人的电话',
  `mobile` varchar(60) NOT NULL COMMENT '收货人的手机',
  `sign_building` varchar(120) NOT NULL COMMENT '收货地址的标志性建筑名',
  `best_time` varchar(120) NOT NULL COMMENT '收货人的最佳收货时间',
  `is_default` tinyint(1) DEFAULT '0' COMMENT '是否默认收货地址：0否，1是',
  PRIMARY KEY (`address_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8 COMMENT='收货人的信息表';

CREATE TABLE `sh_user_friends` (
  `sh_user_id` int(10) NOT NULL COMMENT '用户ID:  0：客户端登陆外  -1：世和官方',
  `tel` varchar(24) NOT NULL,
  `create_time` datetime NOT NULL,
  `channel` int(11) NOT NULL DEFAULT '2' COMMENT '渠道标志：1：微信朋友圈  2：微信好友   3：新浪微博   4：QQ   5: QQ空间  6：电子邮件',
  `source` varchar(5) NOT NULL DEFAULT '2' COMMENT '1：商户  2：客户端邀请好友  3：官方(世和)',
  UNIQUE KEY `idx_userid_tel` (`sh_user_id`,`tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `sh_user_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sh_user_id` int(11) unsigned NOT NULL COMMENT '用户信息表id',
  `sh_user_level_id` int(11) unsigned NOT NULL COMMENT '用户等级表id',
  `age` int(4) NOT NULL DEFAULT '0' COMMENT '年龄',
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别：0-女，1-男',
  `head_pic` varchar(64) NOT NULL DEFAULT '' COMMENT '用户头像',
  `points` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分：根据积分划分等级',
  `ip_address` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `create_time` int(10) NOT NULL COMMENT '添加时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开启等级：1-开启，0-关闭',
  `born` varchar(32) NOT NULL DEFAULT '' COMMENT '出生日期',
  `job` varchar(32) NOT NULL DEFAULT '' COMMENT '职业',
  `article_num` int(11) unsigned NOT NULL COMMENT '文章数量',
  `good_num` int(11) unsigned NOT NULL COMMENT '商品数量',
  `resources_num` int(11) unsigned NOT NULL COMMENT '资源数量',
  PRIMARY KEY (`id`),
  KEY `fk_sh_user_info_sh_user_idx` (`sh_user_id`),
  KEY `fk_sh_user_info_sh_user_level_idx` (`sh_user_level_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34417 DEFAULT CHARSET=utf8 COMMENT='用户详情信息表';

CREATE TABLE `sh_user_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sh_user_id` int(11) unsigned NOT NULL COMMENT '用户信息表id',
  `action` varchar(45) DEFAULT NULL COMMENT '用户动作',
  `note` varchar(200) DEFAULT NULL COMMENT '注释动作',
  `create_time` int(10) NOT NULL COMMENT '动作时间',
  PRIMARY KEY (`id`),
  KEY `fk_sh_user_log_sh_user_idx` (`sh_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1802543 DEFAULT CHARSET=utf8 COMMENT='用户登陆日志表';

CREATE TABLE `sh_user_shaidan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sh_user_id` int(11) DEFAULT NULL,
  `content` text COMMENT '晒单内容',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `sh_order_id` int(11) DEFAULT NULL,
  `sh_goods_id` int(11) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8 COMMENT='用户晒单';

CREATE TABLE `sh_user_vertify_code` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vertify_code` varchar(8) NOT NULL COMMENT '验证码',
  `tel` varchar(24) NOT NULL COMMENT '手机号码',
  `live_time` int(11) unsigned NOT NULL COMMENT '有效时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8 COMMENT='用户验证码表';
