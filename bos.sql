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

 Date: 04/02/2017 22:11:31 PM
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
INSERT INTO `T_USER` VALUES ('1ba5a8bf30694170a2127370edb25f56', 'user2', '7e58d63b60197ceb55a1c487989a3720', '100000', '2017-04-05 00:00:00', '男', '厅点', '0990', null), ('375887f3dd324a3eb847a5ed780431c9', 'user4', '3f02ebe3d7929b091e3d8ccfde2f3bc6', '11111', '2017-04-12 00:00:00', '女', '总公司', '100000', null), ('3ccad465ecfa4aa0bd1d305328bd60cc', '11111', '96e79218965eb72c92a549dd5a330112', '11111', '2017-04-19 00:00:00', '女', '总公司', '111', null), ('6aef56af47f6411397ecdac1e706409f', 'root', '63a9f0ea7bb98050796b649e85481845', '10000', '2017-04-06 00:00:00', '男', '分公司', '1000', null), ('81e0ac82b3164d7ebe2d5bbd54ba036c', '2323213', '116b1789424407d40146b88635cb9a44', '31231231', '2017-04-06 00:00:00', '女', '总公司', '111122323', null), ('8667e435d38b4235a8531314c229cf48', '11111', 'b59c67bf196a4758191e42f76670ceba', '111', '2017-04-05 00:00:00', '女', '分公司', '111', null), ('a1c3c45d55814704b75eff14a5931bbc', 'user3', '92877af70a45fd6a2ed7fe81e1236b78', '10000', '2017-04-03 00:00:00', '女', '分公司', '1099', null), ('a71e2fe3bc104ad2ad366b8a1340cbbb', 'admin', '21232f297a57a5a743894a0e4a801fc3', '11111', '2017-04-05 00:00:00', '女', '总公司', '18812341234', null), ('b57952e6fb7a4a3c82b383af97b33230', '111111', 'b0baee9d279d34fa1dfd71aadb908c3f', '1111', '2017-04-04 00:00:00', '男', '分公司', '1111', null), ('f7813a858c8c4c968f0cb8591dbdb3e2', 'user1', '24c9e15e52afc47c225b757e7bee1f9d', '100000', '2017-04-04 00:00:00', '男', '总公司', '18812341234', null), ('fc7ff21f70ce4a9e8960cc4e0f0192ed', '1232134', '6b4f1b2680df37fffefa1938c3b7fe1a', '321312', '2017-04-05 00:00:00', '男', '分公司', '112213', null);
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
