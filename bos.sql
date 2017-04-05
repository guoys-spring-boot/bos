/*
 Navicat MySQL Data Transfer

 Source Server         : 10.211.55.4
 Source Server Type    : MySQL
 Source Server Version : 50554
 Source Host           : 10.211.55.4
 Source Database       : bos

 Target Server Type    : MySQL
 Target Server Version : 50554
 File Encoding         : utf-8

 Date: 04/04/2017 16:15:40 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `AUTH_FUNCTION`
-- ----------------------------
DROP TABLE IF EXISTS `AUTH_FUNCTION`;
CREATE TABLE `AUTH_FUNCTION` (
  `ID` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PAGE` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `GENERATEMENU` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ZINDEX` int(10) DEFAULT NULL,
  `PID` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`),
  KEY `PID` (`PID`),
  CONSTRAINT `AUTH_FUNCTION_ibfk_1` FOREIGN KEY (`PID`) REFERENCES `AUTH_FUNCTION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `AUTH_FUNCTION`
-- ----------------------------
BEGIN;
INSERT INTO `AUTH_FUNCTION` VALUES ('11', '基础档案', '基础档案功能', null, '1', '0', null), ('113', '取派员设置', null, '0', '1', '2', '11'), ('114', '区域设置', null, '0', '1', '3', '11'), ('115', '管理分区', null, '0', '1', '4', '11'), ('116', '管理定区/调度排版', null, '0', '1', '5', '11'), ('12', '受理', null, null, '1', '1', null), ('121', '业务受理', null, '0', '1', '0', '12'), ('122', '工作单快速录入', null, '0', '1', '1', '12'), ('124', '工作单导入', null, '0', '1', '3', '12'), ('13', '调度', null, null, '1', '2', null), ('131', '查台转单', null, null, '1', '0', '13'), ('132', '人工调度', null, '0', '1', '1', '13');
COMMIT;

-- ----------------------------
--  Table structure for `AUTH_ROLE`
-- ----------------------------
DROP TABLE IF EXISTS `AUTH_ROLE`;
CREATE TABLE `AUTH_ROLE` (
  `ID` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `AUTH_ROLE`
-- ----------------------------
BEGIN;
INSERT INTO `AUTH_ROLE` VALUES ('f9c7ccfaa9bf4fb2bbc28244183a9dd4', 'admin', 'admin');
COMMIT;

-- ----------------------------
--  Table structure for `BASE_ENUM`
-- ----------------------------
DROP TABLE IF EXISTS `BASE_ENUM`;
CREATE TABLE `BASE_ENUM` (
  `EnumType` varchar(20) DEFAULT NULL,
  `EnumName` varchar(50) DEFAULT NULL,
  `EnumAlias` varchar(50) DEFAULT NULL,
  `EnumCode` varchar(2) DEFAULT NULL,
  `EnumText` varchar(30) DEFAULT NULL,
  `EnumState` varchar(1) DEFAULT NULL,
  `id` int(12) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `BASE_ENUM`
-- ----------------------------
BEGIN;
INSERT INTO `BASE_ENUM` VALUES ('auditingStatus', '审核状态', '审核状态', '1', '已通过', '1', '1'), ('auditingStatus', '审核状态', '审核状态', '2', '待审核', '1', '2'), ('auditingStatus', '审核状态', '审核状态', '3', '已拒绝', '1', '3'), ('unitType', '单位类型', '单位类型', '1', '单位', '1', '4'), ('unitProperty', '单位性质', '单位性质', '1', '党政机关', '1', '10'), ('unitProperty', '单位性质', '单位性质', '2', '事业单位', '1', '11'), ('unitProperty', '单位性质', '单位性质', '3', '企业单位', '1', '12'), ('unitProperty', '单位性质', '单位性质', '4', '人民团体', '1', '13'), ('unitProperty', '单位性质', '单位性质', '5', '军队武警', '1', '14'), ('unitLevel', '单位等级', '单位等级', '1', '国家级文明单位', '1', '15'), ('unitLevel', '单位等级', '单位等级', '2', '省级文明单位', '1', '16'), ('unitLevel', '单位等级', '单位等级', '3', '州级最佳文明单位', '1', '17'), ('unitLevel', '单位等级', '单位等级', '4', '州级文明单位', '1', '18'), ('unitLevel', '单位等级', '单位等级', '5', '市级文明单位', '1', '19'), ('unitLevel', '单位等级', '单位等级', '6', '非文明单位', '1', '20'), ('yesOrNo', '是否', '是否', '1', '是', '1', '21'), ('yesOrNo', '是否', '是否', '2', '否', '1', '22');
COMMIT;

-- ----------------------------
--  Table structure for `BASE_UNIT`
-- ----------------------------
DROP TABLE IF EXISTS `BASE_UNIT`;
CREATE TABLE `BASE_UNIT` (
  `id` varchar(40) NOT NULL,
  `parentUnitCode` varchar(40) DEFAULT NULL,
  `ascriptionArea` varchar(200) DEFAULT NULL,
  `organizationCode` varchar(200) DEFAULT NULL,
  `unitFullName` varchar(200) DEFAULT NULL,
  `unitType` varchar(200) DEFAULT NULL,
  `unitProperty` varchar(200) DEFAULT NULL,
  `unitLevel` varchar(200) DEFAULT NULL,
  `unitPersonCount` int(10) DEFAULT NULL,
  `legalEntity` varchar(200) DEFAULT NULL,
  `legalEntityTelNum` varchar(200) DEFAULT NULL,
  `leader` varchar(200) DEFAULT NULL,
  `leaderTelNum` varchar(200) DEFAULT NULL,
  `unitContactPerson` varchar(20) DEFAULT NULL,
  `unitContactPersonTelNum` varchar(20) DEFAULT NULL,
  `contactQQ` varchar(20) DEFAULT NULL,
  `contactEmail` varchar(20) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `auditingStatus` varchar(20) DEFAULT NULL,
  `isAdmin` varchar(1) DEFAULT NULL,
  `unitAddress` varchar(210) DEFAULT NULL,
  `unitShortName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `BASE_UNIT`
-- ----------------------------
BEGIN;
INSERT INTO `BASE_UNIT` VALUES ('1428edac8e2c421e9a7f590dce1cf2a2', '恩施市文明办', '恩施市', '12345678', '州直机关工委', '1', '1', '5', '1', '暂无', '11234,11234', '暂无', '12345', '暂无', '121445', '12433', '11111', 'zzjggw', '21232f297a57a5a743894a0e4a801fc3', '2', '1', '', '修改操作'), ('5f233138b0ac4e9391c5624f5a648de9', '恩施市文明办', '恩施市', '12345678', '州直机关工委', '1', '1', '5', '1', '暂无', '11234,11234', null, '12345', '暂无', '121445', '12433', '11111', 'zzjggw', 'c3284d0f94606de1fd2af172aba15bf3', '2', '1', '', '州直机关工委修改'), ('cb69a55111c241669ff85ea1d3c0829a', '恩施市文明办', '恩施市', '12345678', '州直机关工委', '1', '1', '5', '1', '暂无', '11234,11234', null, '12345', '暂无', '121445', '12433', '11111', 'zzjggw', 'c4ca4238a0b923820dcc509a6f75849b', '2', '1', '单位地址', '州直机关工委简称'), ('ee46ee50b1fa4875a13f9b5171f15680', '1', '1', '1', '1', '1', '1', '1', '111', '1', '1', '1', '1111', '111', '111', '111', '111', '111', '698d51a19d8a121ce581499d7b701668', '已拒绝', null, '111', null);
COMMIT;

-- ----------------------------
--  Table structure for `ROLE_FUNCTION`
-- ----------------------------
DROP TABLE IF EXISTS `ROLE_FUNCTION`;
CREATE TABLE `ROLE_FUNCTION` (
  `FUNCTION_ID` varchar(255) COLLATE utf8_bin NOT NULL,
  `ROLE_ID` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`FUNCTION_ID`),
  KEY `FUNCTION_ID` (`FUNCTION_ID`),
  CONSTRAINT `ROLE_FUNCTION_ibfk_2` FOREIGN KEY (`ROLE_ID`) REFERENCES `AUTH_ROLE` (`ID`),
  CONSTRAINT `ROLE_FUNCTION_ibfk_1` FOREIGN KEY (`FUNCTION_ID`) REFERENCES `AUTH_FUNCTION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `ROLE_FUNCTION`
-- ----------------------------
BEGIN;
INSERT INTO `ROLE_FUNCTION` VALUES ('11', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('113', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('114', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('115', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('116', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('12', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('121', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('122', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('124', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('13', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('131', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4'), ('132', 'f9c7ccfaa9bf4fb2bbc28244183a9dd4');
COMMIT;

-- ----------------------------
--  Table structure for `T_USER`
-- ----------------------------
DROP TABLE IF EXISTS `T_USER`;
CREATE TABLE `T_USER` (
  `ID` varchar(32) COLLATE utf8_bin NOT NULL,
  `USERNAME` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `SALARY` int(2) DEFAULT NULL,
  `BIRTHDAY` datetime DEFAULT NULL,
  `GENDER` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `STATION` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `TELEPHONE` varchar(11) COLLATE utf8_bin DEFAULT NULL,
  `REMARK` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `T_USER`
-- ----------------------------
BEGIN;
INSERT INTO `T_USER` VALUES ('1', 'admin', 'c4ca4238a0b923820dcc509a6f75849b', null, null, null, null, null, null), ('1ba5a8bf30694170a2127370edb25f56', 'user2', '7e58d63b60197ceb55a1c487989a3720', '100000', '2017-04-05 00:00:00', '男', '厅点', '0990', null), ('36b772393cde4b4eb647f0cef525f70a', 'admin2', 'c84258e9c39059a89ab77d846ddab909', '100000', '2017-04-07 00:00:00', '男', '总公司', '11111111111', null), ('375887f3dd324a3eb847a5ed780431c9', 'user4', '3f02ebe3d7929b091e3d8ccfde2f3bc6', '11111', '2017-04-12 00:00:00', '女', '总公司', '100000', null), ('7b69cc8253734e57a4adb19c365837b0', 'root', '63a9f0ea7bb98050796b649e85481845', '100000', '2017-04-04 00:00:00', '男', '分公司', '13888888888', null), ('81e0ac82b3164d7ebe2d5bbd54ba036c', '2323213', '116b1789424407d40146b88635cb9a44', '31231231', '2017-04-06 00:00:00', '女', '总公司', '111122323', null), ('8667e435d38b4235a8531314c229cf48', '11111', 'b59c67bf196a4758191e42f76670ceba', '111', '2017-04-05 00:00:00', '女', '分公司', '111', null), ('9006089de6db48fe959685741096b21d', 'username', '5f4dcc3b5aa765d61d8327deb882cf99', '10000', '2017-04-04 00:00:00', '女', '总公司', '111111', null), ('a1c3c45d55814704b75eff14a5931bbc', 'user3', '92877af70a45fd6a2ed7fe81e1236b78', '10000', '2017-04-03 00:00:00', '女', '分公司', '1099', null), ('b57952e6fb7a4a3c82b383af97b33230', '111111', 'b0baee9d279d34fa1dfd71aadb908c3f', '1111', '2017-04-04 00:00:00', '男', '分公司', '1111', null), ('f7813a858c8c4c968f0cb8591dbdb3e2', 'user1', '24c9e15e52afc47c225b757e7bee1f9d', '100000', '2017-04-04 00:00:00', '男', '总公司', '18812341234', null), ('fc7ff21f70ce4a9e8960cc4e0f0192ed', '1232134', '6b4f1b2680df37fffefa1938c3b7fe1a', '321312', '2017-04-05 00:00:00', '男', '分公司', '112213', null);
COMMIT;

-- ----------------------------
--  Table structure for `USER_ROLE`
-- ----------------------------
DROP TABLE IF EXISTS `USER_ROLE`;
CREATE TABLE `USER_ROLE` (
  `USER_ID` varchar(255) COLLATE utf8_bin NOT NULL,
  `ROLE_ID` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID`,`ROLE_ID`),
  KEY `ROLE_ID` (`ROLE_ID`),
  CONSTRAINT `USER_ROLE_ibfk_2` FOREIGN KEY (`ROLE_ID`) REFERENCES `AUTH_ROLE` (`ID`),
  CONSTRAINT `USER_ROLE_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `T_USER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE `wmb_khxm` (
  `id` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `khxm` varchar(500) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '考核46道内容的标题',
  `xmlx` varchar(2) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '考核类型',
  `totalscore` double(11,2) NOT NULL COMMENT '???',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
