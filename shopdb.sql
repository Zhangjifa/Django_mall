/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 5.7.17-log : Database - shopdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shopdb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `shopdb`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can add permission',2,'add_permission'),
(5,'Can change permission',2,'change_permission'),
(6,'Can delete permission',2,'delete_permission'),
(7,'Can add group',3,'add_group'),
(8,'Can change group',3,'change_group'),
(9,'Can delete group',3,'delete_group'),
(10,'Can add user',4,'add_user'),
(11,'Can change user',4,'change_user'),
(12,'Can delete user',4,'delete_user'),
(13,'Can add content type',5,'add_contenttype'),
(14,'Can change content type',5,'change_contenttype'),
(15,'Can delete content type',5,'delete_contenttype'),
(16,'Can add session',6,'add_session'),
(17,'Can change session',6,'change_session'),
(18,'Can delete session',6,'delete_session');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `detail` */

DROP TABLE IF EXISTS `detail`;

CREATE TABLE `detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(11) unsigned DEFAULT NULL,
  `goodsid` int(11) unsigned DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `price` double(6,2) DEFAULT NULL,
  `num` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `detail` */

insert  into `detail`(`id`,`orderid`,`goodsid`,`name`,`price`,`num`) values 
(2,5,7,'ThinkPad_P52s',9999.00,1),
(3,6,10,'iPhone XS Max',9599.00,1),
(4,7,12,'恒源祥秋冬季夹克衫',298.00,2),
(5,8,8,'ROG 冰刃',9999.99,1),
(6,9,15,'Python编程 从入门到实践',72.70,3);

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2018-11-18 14:04:18.744053'),
(2,'auth','0001_initial','2018-11-18 14:04:25.088783'),
(3,'admin','0001_initial','2018-11-18 14:04:26.491863'),
(4,'admin','0002_logentry_remove_auto_add','2018-11-18 14:04:26.563684'),
(5,'contenttypes','0002_remove_content_type_name','2018-11-18 14:04:27.487171'),
(6,'auth','0002_alter_permission_name_max_length','2018-11-18 14:04:28.077689'),
(7,'auth','0003_alter_user_email_max_length','2018-11-18 14:04:28.560415'),
(8,'auth','0004_alter_user_username_opts','2018-11-18 14:04:28.627238'),
(9,'auth','0005_alter_user_last_login_null','2018-11-18 14:04:29.232604'),
(10,'auth','0006_require_contenttypes_0002','2018-11-18 14:04:29.276451'),
(11,'auth','0007_alter_validators_add_error_messages','2018-11-18 14:04:29.327314'),
(12,'auth','0008_alter_user_username_max_length','2018-11-18 14:04:30.355174'),
(13,'sessions','0001_initial','2018-11-18 14:04:30.859427');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('4l19z3uyvoql3l7e2kmp7lnk8y17f0oi','Y2UyZGNjMDE4M2QzMzAwNjJiOGFhYWQwNTUxZTgyNDQ0NGIzYjlhZTp7InZlcmlmeWNvZGUiOiJFWEQ5IiwidmlwdXNlciI6eyJpZCI6MTcsInVzZXJuYW1lIjoiempmX2hlYXJ0IiwibmFtZSI6Ilx1NWYyMFx1N2VlN1x1NmNkNSIsInBhc3N3b3JkIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAiLCJjb2RlIjoiNDAwMDEwIiwic2V4IjowLCJhZGRyZXNzIjoiXHU2ZTI5XHU2Y2M5XHU5NTQ3XHU0ZTJkXHU1MTczXHU2NzUxXHU1MjFiXHU1YmEyXHU1YzBmXHU5NTQ3MTNcdTUzZjdcdTY5N2MyXHU1MzU1XHU1MTQzOTA0IiwicGhvbmUiOiIxNzYwMDIyMDIwNSIsImVtYWlsIjoiODc3NjIyNTgxQHFxLmNvbSIsInN0YXRlIjoxfSwic2hvcGxpc3QiOnsiOCI6eyJpZCI6OCwidHlwZWlkIjo3LCJnb29kcyI6IlJPRyBcdTUxYjBcdTUyMDMiLCJjb21wYW55IjoiXHU1MzRlXHU3ODU1IiwiY29udGVudCI6IjxoMiBzdHlsZT1cIm1hcmdpbjogMHB4OyBmb250LWZhbWlseTogJnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7LCBTVEhlaXRpLCBzYW5zLXNlcmlmOyBmb250LXdlaWdodDogbm9ybWFsOyBwYWRkaW5nOiAwcHg7IC13ZWJraXQtdGFwLWhpZ2hsaWdodC1jb2xvcjogcmdiYSgwLCAwLCAwLCAwKTsgb3V0bGluZTogbm9uZSAwcHg7IGZvbnQtc2l6ZTogMjRweDsgY29sb3I6IHJnYigzOCwgMzgsIDM4KTsgbGluZS1oZWlnaHQ6IDM2cHg7IHdoaXRlLXNwYWNlOiBub3JtYWw7IGJhY2tncm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwgMjU1KTtcIj5ST0dcdTUxYjBcdTUyMDMgMTUuNlx1ODJmMVx1NWJmOCAxMjBIeiAyNW1zIFx1OTYzMlx1NzBhYlx1NTE0OVx1OTZmZVx1OTc2Mlx1NWM0Zlx1NmUzOFx1NjIwZlx1N2IxNFx1OGJiMFx1NjcyY1x1NzUzNVx1ODExMTwvaDI+PHA+PGJyLz48L3A+IiwicHJpY2UiOjI2OTk5Ljk5LCJwaWNuYW1lIjoiMTU0MzQ3ODQ3Ni44MzI0NDE4LmpwZyIsInN0b3JlIjoxNjcwLCJudW0iOjQsImNsaWNrIjozLCJzdGF0ZSI6MX19LCJhZG1pbnVzZXIiOiJhZG1pbiIsIl9zZXNzaW9uX2V4cGlyeSI6MH0=','2018-12-18 10:09:39.951287'),
('dotm4uo2bv0a48gbp40dsubv4eq9le1y','OTY0MjU5MjYwODgwZDVjYmU5ZTU3NzhjNjIwZDY2YjgwYTZmMmZjNjp7InZlcmlmeWNvZGUiOiIwVEc1Iiwic2hvcGxpc3QiOnt9LCJfc2Vzc2lvbl9leHBpcnkiOjAsImFkbWludXNlciI6ImFkbWluIiwidmlwdXNlciI6eyJpZCI6MTcsInVzZXJuYW1lIjoiempmX2hlYXJ0IiwibmFtZSI6Ilx1NWYyMFx1N2VlN1x1NmNkNSIsInBhc3N3b3JkIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAiLCJjb2RlIjoiNDAwMDEwIiwic2V4IjoxLCJhZGRyZXNzIjoiXHU2ZTI5XHU2Y2M5XHU5NTQ3XHU0ZTJkXHU1MTczXHU2NzUxXHU1MjFiXHU1YmEyXHU1YzBmXHU5NTQ3MTNcdTUzZjdcdTY5N2MyXHU1MzU1XHU1MTQzOTA0IiwicGhvbmUiOiIxNzYwMDIyMDIwNSIsImVtYWlsIjoiODc3NjIyNTgxQHFxLmNvbSIsInN0YXRlIjoxfX0=','2018-12-17 16:09:16.356480'),
('yt2liv5qvqd5bl5behejw02wwx71q58g','ZThiOTRiZTFlMGM0ZjJiNzQxMWE4YWQ2OWE5NjE3MWRiYWZlNGUzMTp7InZlcmlmeWNvZGUiOiIxN09NIiwiYWRtaW51c2VyIjoiYWRtaW4iLCJfc2Vzc2lvbl9leHBpcnkiOjAsInZpcHVzZXIiOnsiaWQiOjE3LCJ1c2VybmFtZSI6InpqZl9oZWFydCIsIm5hbWUiOiJcdTVmMjBcdTdlZTdcdTZjZDUiLCJwYXNzd29yZCI6IjgxZGM5YmRiNTJkMDRkYzIwMDM2ZGJkODMxM2VkMDU1IiwiY29kZSI6IjQwMDAxMCIsInNleCI6MSwiYWRkcmVzcyI6Ilx1NmUyOVx1NmNjOVx1OTU0N1x1NGUyZFx1NTE3M1x1Njc1MVx1NTIxYlx1NWJhMlx1NWMwZlx1OTU0NzEzXHU1M2Y3XHU2OTdjMlx1NTM1NVx1NTE0MzkwNCIsInBob25lIjoiMTc2MDAyMjAyMDUiLCJlbWFpbCI6Ijg3NzYyMjU4MUBxcS5jb20iLCJzdGF0ZSI6MX0sInNob3BsaXN0Ijp7fX0=','2018-12-18 21:07:29.941065');

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `typeid` int(11) unsigned NOT NULL,
  `goods` varchar(32) NOT NULL,
  `company` varchar(50) DEFAULT NULL,
  `content` text,
  `price` double(8,2) unsigned NOT NULL,
  `picname` varchar(255) DEFAULT NULL,
  `store` int(11) unsigned NOT NULL DEFAULT '0',
  `num` int(11) unsigned NOT NULL DEFAULT '0',
  `clicknum` int(11) unsigned NOT NULL DEFAULT '0',
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `typeid` (`typeid`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `goods` */

insert  into `goods`(`id`,`typeid`,`goods`,`company`,`content`,`price`,`picname`,`store`,`num`,`clicknum`,`state`,`addtime`) values 
(7,7,'ThinkPad_P52s','Lenovo','<pre style=\"box-sizing: border-box; -webkit-tap-highlight-color: transparent; text-size-adjust: none; -webkit-font-smoothing: antialiased; overflow: auto; font-family: Consolas, &quot;Liberation Mono&quot;, Menlo, Courier, monospace; font-size: 14px; padding: 0.85em 1em; margin-top: 0px; margin-bottom: 1.275em; line-height: 1.42857; word-break: break-all; overflow-wrap: normal; color: rgb(51, 51, 51); background-color: rgb(247, 247, 247); border: none; border-radius: 4px; white-space: pre-wrap; break-inside: avoid; direction: ltr; letter-spacing: 0.2px;\">联想ThinkPad&nbsp;P52s&nbsp;20LBA007CD&nbsp;&nbsp;15.6英寸轻薄固态笔记本电脑&nbsp;独显商务移动图形工作站</pre><p><br/></p>',9999.00,'1543474873.452332.jpg',250,0,8,1,'2018-11-29 07:01:14'),
(10,5,'iPhone XS Max','APPLE','<h1 data-spm=\"1000983\" data-spm-max-idx=\"1\" data-spm-anchor-id=\"a220o.1000855.0.1000983.22ce37dc9vj6cK\" style=\"margin: 0px; padding: 0px 0px 0.2em; font-size: 16px; font-family: &quot;microsoft yahei&quot;; line-height: 1; white-space: normal; background-color: rgb(255, 255, 255);\"><a target=\"_blank\" href=\"https://detail.tmall.com/item.htm?spm=a220o.1000855.1000983.1.22ce37dc9vj6cK&id=577084336527&standard=1\" data-spm-anchor-id=\"a220o.1000855.1000983.1\" style=\"margin: 0px; padding: 0px; text-decoration-line: none; color: rgb(0, 0, 0); outline: 0px; vertical-align: middle;\">Apple/苹果 iPhone XS Max</a></h1><p><br/></p>',9599.00,'1543479468.7035391.jpg',6666,0,2,1,'2018-11-29 08:17:49'),
(8,7,'ROG 冰刃','华硕','<h2 style=\"margin: 0px; font-family: &quot;Microsoft YaHei&quot;, STHeiti, sans-serif; font-weight: normal; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: none 0px; font-size: 24px; color: rgb(38, 38, 38); line-height: 36px; white-space: normal; background-color: rgb(255, 255, 255);\">ROG冰刃 15.6英寸 120Hz 25ms 防炫光雾面屏游戏笔记本电脑</h2><p><br/></p>',26999.99,'1543478476.8324418.jpg',1670,1,7,1,'2018-11-29 08:01:17'),
(9,6,'iPad Pro 2018','APPLE','<p>iPad Pro 2018全新全面屏平板电脑</p>',6499.00,'1543479066.2592497.jpg',10000,0,2,1,'2018-11-29 08:11:07'),
(11,2,'雅鹿连帽羽绒服','雅鹿','<h1 data-spm=\"1000983\" data-spm-anchor-id=\"a220o.1000855.0.1000983.47615270XEadUY\" style=\"margin: 0px; padding: 0px 0px 0.2em; font-size: 16px; font-family: &quot;microsoft yahei&quot;; line-height: 1; white-space: normal; background-color: rgb(255, 255, 255);\">雅鹿反季男士加厚羽绒服狐狸毛领中长款中年爸爸冬季新款连帽外套</h1><p><br/></p>',699.00,'1543479610.4562628.jpg',450,0,8,1,'2018-11-29 08:20:11'),
(12,2,'恒源祥秋冬季夹克衫','恒源祥','<h1 data-spm=\"1000983\" data-spm-anchor-id=\"a220o.1000855.0.1000983.4d9c494e29GQA4\" style=\"margin: 0px; padding: 0px 0px 0.2em; font-size: 16px; font-family: &quot;microsoft yahei&quot;; line-height: 1; white-space: normal; background-color: rgb(255, 255, 255);\">恒源祥秋冬季男士夹克衫中年立领加绒加厚休闲保暖棉衣外套爸爸装</h1><p><br/></p>',298.00,'1543479763.35928.jpg',700,0,2,1,'2018-11-29 08:22:44'),
(13,2,'恒源祥羊毛衫女','恒源祥','<h1 data-spm=\"1000983\" data-spm-anchor-id=\"a220o.1000855.0.1000983.12246238D8Zugo\" style=\"margin: 0px; padding: 0px 0px 0.2em; font-size: 16px; font-family: &quot;microsoft yahei&quot;; line-height: 1; white-space: normal; background-color: rgb(255, 255, 255);\">恒源祥羊毛衫女半高领秋冬纯羊毛套头针织衫纯色毛衣女休闲打底衫</h1><p><br/></p>',298.00,'1543479985.677891.jpg',777,0,9,1,'2018-11-29 08:26:26'),
(15,17,'Python编程 从入门到实践','人民邮电出版社','<p><span style=\"color: rgb(227, 57, 60); font-family: arial, &quot;microsoft yahei&quot;; font-size: 12px; background-color: rgb(255, 255, 255);\"><span style=\"color: rgb(227, 57, 60); font-family: arial, &quot;microsoft yahei&quot;; font-size: 12px; background-color: rgb(255, 255, 255);\">Python3.5编程入门图书</span></span></p>',72.70,'1543925196.9734619.jpg',990,3,1,1,'2018-12-04 20:06:37');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned DEFAULT NULL,
  `linkman` varchar(32) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `code` char(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `total` double(8,2) unsigned DEFAULT NULL,
  `state` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`id`,`uid`,`linkman`,`address`,`code`,`phone`,`addtime`,`total`,`state`) values 
(7,17,'张继法','温泉镇中关村创客小镇13号楼2单元904','400010','17600220205','2018-12-03 16:04:38',596.00,0),
(6,17,'张继法','温泉镇中关村创客小镇13号楼2单元904','400010','17600220205','2018-12-03 16:00:56',9599.00,0),
(5,1,'管理员','北京市朝阳区大山子007号','100086','13566686868','2018-12-02 16:20:06',9999.00,3),
(8,17,'张继法','温泉镇中关村创客小镇13号楼2单元904','400010','17600220205','2018-12-03 16:09:16',26999.99,0),
(9,17,'张继法','温泉镇中关村创客小镇13号楼2单元904','400010','17600220205','2018-12-04 21:07:29',218.10,3);

/*Table structure for table `type` */

DROP TABLE IF EXISTS `type`;

CREATE TABLE `type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `pid` int(11) unsigned DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `type` */

insert  into `type`(`id`,`name`,`pid`,`path`) values 
(1,'服装',0,'0,'),
(2,'男装',1,'0,1,'),
(3,'女装',1,'0,1,'),
(4,'数码电子',0,'0,'),
(5,'智能手机',4,'0,4,'),
(6,'便携平板',4,'0,4,'),
(7,'笔记本电脑',4,'0,4,'),
(8,'台式机',4,'0,4,'),
(9,'生活家电',0,'0,'),
(10,'平板电视',9,'0,9,'),
(11,'空调',9,'0,9,'),
(12,'冰箱',9,'0,9,'),
(13,'洗衣机',9,'0,9,'),
(16,'学习书籍',0,'0,'),
(17,'IT编程',16,'0,16,');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `name` varchar(16) DEFAULT NULL,
  `password` char(32) NOT NULL,
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `address` varchar(255) DEFAULT NULL,
  `code` char(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`name`,`password`,`sex`,`address`,`code`,`phone`,`email`,`state`,`addtime`) values 
(1,'admin','admin','21232f297a57a5a743894a0e4a801fc3',0,'北京市朝阳区大山子007号','100086','13566686868','122794105@qq.com',0,'2018-04-07 21:20:08'),
(5,'zjf_0205','zhangsan','96e79218965eb72c92a549dd5a330112',1,'温泉镇中关村创客小镇13号楼2单元904','400010','17093570255','877622581@qq.com',1,'2018-11-18 10:56:38'),
(6,'testUser','lisi','e10adc3949ba59abbe56e057f20f883e',0,'111','1111','99999999999','11111',1,'2018-11-18 10:57:12'),
(7,'X90zHn','wangwu','81dc9bdb52d04dc20036dbd8313ed055',1,'温泉镇中关村创客小镇13号楼2单元904','400010','11111111111','877622581@qq.com',1,'2018-11-18 10:57:46'),
(8,'877622581@qq.com','ZhangJif','202cb962ac59075b964b07152d234b70',0,'温泉镇中关村创客13号楼2单元904','4000','1760022','877622581@q',1,'2018-11-20 13:00:57'),
(12,'12345','么玛西亚','202cb962ac59075b964b07152d234b70',0,'北京市朝阳区霄云路48号','1111','99999999999','877622581@qq.com',1,'2018-11-21 11:23:35'),
(19,'zhanghui','','202cb962ac59075b964b07152d234b70',1,'','','','',1,'2018-12-04 21:04:56'),
(17,'zjf_heart','张继法','81dc9bdb52d04dc20036dbd8313ed055',1,'温泉镇中关村创客小镇13号楼2单元904','400010','17600220205','877622581@qq.com',1,'2018-12-03 15:45:31');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
