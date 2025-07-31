/*
 Navicat Premium Dump SQL

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 80026 (8.0.26)
 Source Host           : localhost:3306
 Source Schema         : db_campus_system

 Target Server Type    : MySQL
 Target Server Version : 80026 (8.0.26)
 File Encoding         : 65001

 Date: 31/07/2025 14:59:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for apply_info
-- ----------------------------
DROP TABLE IF EXISTS `apply_info`;
CREATE TABLE `apply_info`  (
  `apply_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '申请编号',
  `apply_person_count` int NULL DEFAULT NULL COMMENT '申请人数',
  `apply_purpose` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '申请用途',
  `apply_book_time` datetime NOT NULL COMMENT '用户点击预约的时间',
  `apply_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '审核状态',
  `apply_reject_reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '驳回原因',
  `user_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '预约用户账号',
  `sec_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教秘账号',
  `user_cancel` int NULL DEFAULT 0 COMMENT '用户是否取消',
  PRIMARY KEY (`apply_id`) USING BTREE,
  INDEX `user_account`(`user_account` ASC) USING BTREE,
  INDEX `sec_account`(`sec_account` ASC) USING BTREE,
  CONSTRAINT `apply_info_ibfk_1` FOREIGN KEY (`user_account`) REFERENCES `users` (`user_account`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `apply_info_ibfk_2` FOREIGN KEY (`sec_account`) REFERENCES `teach_secretary` (`sec_account`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `apply_info_chk_1` CHECK (`apply_status` in (_utf8mb4'未审核',_utf8mb4'已批准',_utf8mb4'已拒绝')),
  CONSTRAINT `chk_apply_status` CHECK (`apply_status` in (_utf8mb4'未审核',_utf8mb4'已批准',_utf8mb4'已拒绝'))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of apply_info
-- ----------------------------
INSERT INTO `apply_info` VALUES ('apply001', 50, '课程教学', '2025-07-30 09:15:22', '已批准', NULL, 'user001', 'sec001', 0);
INSERT INTO `apply_info` VALUES ('apply002', 30, '学术讲座', '2025-07-30 10:30:45', '未审核', NULL, 'user002', 'sec002', 0);
INSERT INTO `apply_info` VALUES ('apply003', 45, '社团活动', '2025-07-29 14:20:33', '已拒绝', '时间冲突', 'user003', 'sec003', 0);
INSERT INTO `apply_info` VALUES ('apply004', 25, '小组讨论', '2025-07-31 08:45:11', '未审核', NULL, 'user004', 'sec001', 1);

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building`  (
  `building_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '楼id',
  `building_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '楼名',
  PRIMARY KEY (`building_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of building
-- ----------------------------
INSERT INTO `building` VALUES ('b001', '第一教学楼');
INSERT INTO `building` VALUES ('b002', '第二教学楼');
INSERT INTO `building` VALUES ('b003', '实验楼');

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS `classroom`;
CREATE TABLE `classroom`  (
  `room_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室编号',
  `room_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '教室类型',
  `room_capacity` int NULL DEFAULT NULL COMMENT '容量',
  `building_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '楼id',
  `college_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '所属学院',
  PRIMARY KEY (`room_num`) USING BTREE,
  INDEX `classroom_ibfk_2`(`college_id` ASC) USING BTREE,
  INDEX `classroom_ibfk_1`(`building_id` ASC) USING BTREE,
  CONSTRAINT `classroom_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `classroom_ibfk_2` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classroom
-- ----------------------------
INSERT INTO `classroom` VALUES ('b001-101', '多媒体教室', 120, 'b001', 'col001');
INSERT INTO `classroom` VALUES ('b001-103', '智慧教室', 90, 'b001', NULL);
INSERT INTO `classroom` VALUES ('b001-201', '普通教室', 80, 'b001', 'col001');
INSERT INTO `classroom` VALUES ('b002-301', '实验室', 60, 'b002', 'col002');
INSERT INTO `classroom` VALUES ('b003-102', '阶梯教室', 200, 'b003', 'col003');

-- ----------------------------
-- Table structure for classroom_manager
-- ----------------------------
DROP TABLE IF EXISTS `classroom_manager`;
CREATE TABLE `classroom_manager`  (
  `mgr_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室管理员账号',
  `mgr_password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室管理员密码',
  `mgr_phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室管理员联系电话',
  `building_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '管理楼栋id',
  PRIMARY KEY (`mgr_account`) USING BTREE,
  INDEX `building_id`(`building_id` ASC) USING BTREE,
  CONSTRAINT `classroom_manager_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classroom_manager
-- ----------------------------
INSERT INTO `classroom_manager` VALUES ('mgr001', 'mgrpass1', '13900139001', 'b001');
INSERT INTO `classroom_manager` VALUES ('mgr002', 'mgrpass2', '13900139002', 'b002');
INSERT INTO `classroom_manager` VALUES ('mgr003', 'mgrpass3', '13900139003', 'b003');

-- ----------------------------
-- Table structure for classroom_resource
-- ----------------------------
DROP TABLE IF EXISTS `classroom_resource`;
CREATE TABLE `classroom_resource`  (
  `res_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室资源编号',
  `res_date` date NOT NULL COMMENT '日期',
  `res_week` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '周次',
  `res_day_of_week` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '星期',
  `res_period` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '节次',
  `res_room_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室状态',
  `room_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室编号',
  `apply_info_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '申请信息编号',
  PRIMARY KEY (`res_id`) USING BTREE,
  INDEX `room_num`(`room_num` ASC) USING BTREE,
  INDEX `apply_info_id`(`apply_info_id` ASC) USING BTREE,
  CONSTRAINT `classroom_resource_ibfk_1` FOREIGN KEY (`room_num`) REFERENCES `classroom` (`room_num`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `classroom_resource_ibfk_2` FOREIGN KEY (`apply_info_id`) REFERENCES `apply_info` (`apply_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `chk_room_status` CHECK (`res_room_status` in (_utf8mb4'空闲',_utf8mb4'已预订'))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classroom_resource
-- ----------------------------
INSERT INTO `classroom_resource` VALUES ('res001', '2025-08-01', '第1周', '星期一', '1节', '已预订', 'b001-101', 'apply001');
INSERT INTO `classroom_resource` VALUES ('res002', '2025-08-01', '第1周', '星期一', '2节', '已预订', 'b001-101', 'apply001');
INSERT INTO `classroom_resource` VALUES ('res003', '2025-08-01', '第1周', '星期一', '3节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('res004', '2025-08-01', '第1周', '星期一', '4节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('res005', '2025-08-02', '第1周', '星期二', '5节', '已预订', 'b002-301', 'apply002');
INSERT INTO `classroom_resource` VALUES ('res006', '2025-08-02', '第1周', '星期二', '6节', '已预订', 'b002-301', 'apply002');
INSERT INTO `classroom_resource` VALUES ('res007', '2025-08-02', '第1周', '星期二', '7节', '空闲', 'b002-301', NULL);
INSERT INTO `classroom_resource` VALUES ('res008', '2025-08-03', '第1周', '星期三', '1节', '空闲', 'b003-102', NULL);
INSERT INTO `classroom_resource` VALUES ('res009', '2025-08-03', '第1周', '星期三', '2节', '空闲', 'b003-102', NULL);
INSERT INTO `classroom_resource` VALUES ('res010', '2025-08-03', '第1周', '星期三', '3节', '空闲', 'b003-102', NULL);
INSERT INTO `classroom_resource` VALUES ('res011', '2025-08-04', '第1周', '星期四', '8节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('res012', '2025-08-04', '第1周', '星期四', '9节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('res013', '2025-08-04', '第1周', '星期四', '10节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('res014', '2025-08-05', '第1周', '星期五', '1节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('res015', '2025-08-05', '第1周', '星期五', '2节', '空闲', 'b001-103', NULL);

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college`  (
  `college_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '学院编号',
  `college_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '学院名称',
  PRIMARY KEY (`college_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES ('col001', '计算机科学与技术学院');
INSERT INTO `college` VALUES ('col002', '电子信息工程学院');
INSERT INTO `college` VALUES ('col003', '机械工程学院');

-- ----------------------------
-- Table structure for login
-- ----------------------------
DROP TABLE IF EXISTS `login`;
CREATE TABLE `login`  (
  `user_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户的账号',
  `login_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '登录日志编号',
  `login_time` datetime NULL DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`login_id` DESC) USING BTREE,
  INDEX `user_id_1`(`user_account` ASC) USING BTREE,
  CONSTRAINT `user_id_1` FOREIGN KEY (`user_account`) REFERENCES `users` (`user_account`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login
-- ----------------------------
INSERT INTO `login` VALUES ('user004', 'log005', '2025-07-31 11:05:44');
INSERT INTO `login` VALUES ('user003', 'log004', '2025-07-31 10:15:33');
INSERT INTO `login` VALUES ('user001', 'log003', '2025-07-31 13:20:18');
INSERT INTO `login` VALUES ('user002', 'log002', '2025-07-31 09:45:22');
INSERT INTO `login` VALUES ('user001', 'log001', '2025-07-31 08:30:15');

-- ----------------------------
-- Table structure for super_admin
-- ----------------------------
DROP TABLE IF EXISTS `super_admin`;
CREATE TABLE `super_admin`  (
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '超级管理员账号',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '超级管理员密码',
  PRIMARY KEY (`account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of super_admin
-- ----------------------------
INSERT INTO `super_admin` VALUES ('admin', 'admin123');
INSERT INTO `super_admin` VALUES ('sysadmin', 'super@pass');

-- ----------------------------
-- Table structure for teach_secretary
-- ----------------------------
DROP TABLE IF EXISTS `teach_secretary`;
CREATE TABLE `teach_secretary`  (
  `sec_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教秘账号',
  `sec_password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教秘密码',
  `sec_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教秘姓名',
  `office_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '办公室电话',
  `college_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '学院编号',
  PRIMARY KEY (`sec_account`) USING BTREE,
  INDEX `college_id`(`college_id` ASC) USING BTREE,
  CONSTRAINT `teach_secretary_ibfk_1` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teach_secretary
-- ----------------------------
INSERT INTO `teach_secretary` VALUES ('sec001', 'pass123', '张教秘', '0510-12345678', 'col001');
INSERT INTO `teach_secretary` VALUES ('sec002', 'pass456', '李教秘', '0510-87654321', 'col002');
INSERT INTO `teach_secretary` VALUES ('sec003', 'pass789', '王教秘', '0510-11223344', 'col003');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户账号',
  `user_password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户密码',
  `user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户姓名',
  `user_phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户联系电话',
  `college_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户所在学院',
  PRIMARY KEY (`user_account`) USING BTREE,
  INDEX `college_id`(`college_id` ASC) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('user001', 'userpass1', '王老师', '13800138001', 'col001');
INSERT INTO `users` VALUES ('user002', 'userpass2', '刘老师', '13800138002', 'col002');
INSERT INTO `users` VALUES ('user003', 'userpass3', '陈老师', '13800138003', 'col003');
INSERT INTO `users` VALUES ('user004', 'userpass4', '赵老师', '13800138004', 'col001');

-- ----------------------------
-- View structure for unapply_applications
-- ----------------------------
DROP VIEW IF EXISTS `unapply_applications`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `unapply_applications` AS select `apply_info`.`apply_id` AS `apply_id`,`apply_info`.`apply_purpose` AS `apply_purpose`,`apply_info`.`apply_book_time` AS `apply_book_time`,`users`.`user_name` AS `user_name` from (`apply_info` join `users`) where ((`apply_info`.`user_account` = `users`.`user_account`) and (`apply_info`.`apply_status` = '未审核'));

SET FOREIGN_KEY_CHECKS = 1;
