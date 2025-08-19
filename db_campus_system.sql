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

 Date: 19/08/2025 13:57:06
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
  CONSTRAINT `chk_apply_status` CHECK (`apply_status` in (_utf8mb4'待审核',_utf8mb4'已批准',_utf8mb4'已拒绝'))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of apply_info
-- ----------------------------
INSERT INTO `apply_info` VALUES ('1957664107012427776', 50, '举办班会', '2025-08-19 12:41:09', '待审核', '', 'user001', 'sec000', 0);

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
INSERT INTO `building` VALUES ('b001', '学友楼');
INSERT INTO `building` VALUES ('b002', '校友楼');
INSERT INTO `building` VALUES ('b003', '国教楼');
INSERT INTO `building` VALUES ('b004', '文综楼');
INSERT INTO `building` VALUES ('b005', '逸夫楼');
INSERT INTO `building` VALUES ('b006', '创新楼');
INSERT INTO `building` VALUES ('b007', '科技楼');

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
INSERT INTO `classroom` VALUES ('b001-101', '多媒体教室', 120, 'b001', NULL);
INSERT INTO `classroom` VALUES ('b001-102', '智慧教室', 90, 'b001', NULL);
INSERT INTO `classroom` VALUES ('b001-103', '普通教室', 75, 'b001', NULL);
INSERT INTO `classroom` VALUES ('b001-104', '普通教室', 70, 'b001', NULL);
INSERT INTO `classroom` VALUES ('b001-201', '多媒体教室', 130, 'b001', NULL);
INSERT INTO `classroom` VALUES ('b001-202', '普通教室', 65, 'b001', NULL);
INSERT INTO `classroom` VALUES ('b001-203', '普通教室', 80, 'b001', NULL);
INSERT INTO `classroom` VALUES ('b001-204', '阶梯教室', 200, 'b001', NULL);
INSERT INTO `classroom` VALUES ('b002-301', '实验室', 50, 'b002', NULL);
INSERT INTO `classroom` VALUES ('b002-302', '实验室', 55, 'b002', NULL);
INSERT INTO `classroom` VALUES ('b002-303', '计算机房', 70, 'b002', NULL);
INSERT INTO `classroom` VALUES ('b002-304', '语音室', 45, 'b002', NULL);
INSERT INTO `classroom` VALUES ('b002-401', '普通教室', 60, 'b002', NULL);
INSERT INTO `classroom` VALUES ('b002-402', '普通教室', 65, 'b002', NULL);
INSERT INTO `classroom` VALUES ('b002-403', '多媒体教室', 110, 'b002', NULL);
INSERT INTO `classroom` VALUES ('b002-404', '普通教室', 70, 'b002', NULL);
INSERT INTO `classroom` VALUES ('b003-101', '阶梯教室', 180, 'b003', NULL);
INSERT INTO `classroom` VALUES ('b003-102', '阶梯教室', 200, 'b003', NULL);
INSERT INTO `classroom` VALUES ('b003-103', '多媒体教室', 120, 'b003', NULL);
INSERT INTO `classroom` VALUES ('b003-104', '智慧教室', 95, 'b003', NULL);
INSERT INTO `classroom` VALUES ('b003-201', '普通教室', 75, 'b003', NULL);
INSERT INTO `classroom` VALUES ('b003-202', '普通教室', 80, 'b003', NULL);
INSERT INTO `classroom` VALUES ('b003-203', '语音室', 50, 'b003', NULL);
INSERT INTO `classroom` VALUES ('b003-204', '普通教室', 70, 'b003', NULL);
INSERT INTO `classroom` VALUES ('b004-101', '普通教室', 60, 'b004', NULL);
INSERT INTO `classroom` VALUES ('b004-102', '普通教室', 65, 'b004', NULL);
INSERT INTO `classroom` VALUES ('b004-103', '多媒体教室', 120, 'b004', NULL);
INSERT INTO `classroom` VALUES ('b004-104', '普通教室', 70, 'b004', NULL);
INSERT INTO `classroom` VALUES ('b004-201', '智慧教室', 90, 'b004', NULL);
INSERT INTO `classroom` VALUES ('b004-202', '智慧教室', 85, 'b004', NULL);
INSERT INTO `classroom` VALUES ('b004-203', '普通教室', 75, 'b004', NULL);
INSERT INTO `classroom` VALUES ('b004-204', '阶梯教室', 150, 'b004', NULL);
INSERT INTO `classroom` VALUES ('b005-101', '多媒体教室', 110, 'b005', NULL);
INSERT INTO `classroom` VALUES ('b005-102', '普通教室', 70, 'b005', NULL);
INSERT INTO `classroom` VALUES ('b005-103', '普通教室', 65, 'b005', NULL);
INSERT INTO `classroom` VALUES ('b005-104', '实验室', 55, 'b005', NULL);
INSERT INTO `classroom` VALUES ('b005-201', '实验室', 60, 'b005', NULL);
INSERT INTO `classroom` VALUES ('b005-202', '计算机房', 65, 'b005', NULL);
INSERT INTO `classroom` VALUES ('b005-203', '计算机房', 70, 'b005', NULL);
INSERT INTO `classroom` VALUES ('b005-204', '语音室', 50, 'b005', NULL);
INSERT INTO `classroom` VALUES ('b006-101', '智慧教室', 100, 'b006', NULL);
INSERT INTO `classroom` VALUES ('b006-102', '智慧教室', 95, 'b006', NULL);
INSERT INTO `classroom` VALUES ('b006-103', '多媒体教室', 120, 'b006', NULL);
INSERT INTO `classroom` VALUES ('b006-104', '普通教室', 75, 'b006', NULL);
INSERT INTO `classroom` VALUES ('b006-201', '普通教室', 80, 'b006', NULL);
INSERT INTO `classroom` VALUES ('b006-202', '阶梯教室', 160, 'b006', NULL);
INSERT INTO `classroom` VALUES ('b006-203', '实验室', 60, 'b006', NULL);
INSERT INTO `classroom` VALUES ('b006-204', '实验室', 55, 'b006', NULL);
INSERT INTO `classroom` VALUES ('b007-101', '实验室', 55, 'b007', NULL);
INSERT INTO `classroom` VALUES ('b007-102', '实验室', 60, 'b007', NULL);
INSERT INTO `classroom` VALUES ('b007-103', '计算机房', 70, 'b007', NULL);
INSERT INTO `classroom` VALUES ('b007-104', '计算机房', 75, 'b007', NULL);
INSERT INTO `classroom` VALUES ('b007-201', '多媒体教室', 130, 'b007', NULL);
INSERT INTO `classroom` VALUES ('b007-202', '智慧教室', 90, 'b007', NULL);
INSERT INTO `classroom` VALUES ('b007-203', '普通教室', 70, 'b007', NULL);
INSERT INTO `classroom` VALUES ('b007-204', '普通教室', 65, 'b007', NULL);

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
INSERT INTO `classroom_manager` VALUES ('mgr004', 'mgrpass4', '13900139004', 'b004');
INSERT INTO `classroom_manager` VALUES ('mgr005', 'mgrpass5', '13900139005', 'b005');
INSERT INTO `classroom_manager` VALUES ('mgr006', 'mgrpass6', '13900139006', 'b006');
INSERT INTO `classroom_manager` VALUES ('mgr007', 'mgrpass7', '13900139007', 'b007');

-- ----------------------------
-- Table structure for classroom_resource
-- ----------------------------
DROP TABLE IF EXISTS `classroom_resource`;
CREATE TABLE `classroom_resource`  (
  `res_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室资源编号',
  `res_date` datetime NOT NULL COMMENT '日期',
  `res_week` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '周次',
  `res_day_of_week` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '星期',
  `res_period` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '节次',
  `res_room_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室状态',
  `room_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室编号',
  `apply_info_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '申请信息编号',
  PRIMARY KEY (`res_id`) USING BTREE,
  INDEX `room_num`(`room_num` ASC) USING BTREE,
  INDEX `apply_info_id`(`apply_info_id` ASC) USING BTREE,
  CONSTRAINT `apply_info_id` FOREIGN KEY (`apply_info_id`) REFERENCES `apply_info` (`apply_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `room_num` FOREIGN KEY (`room_num`) REFERENCES `classroom` (`room_num`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_room_status` CHECK (`res_room_status` in (_utf8mb4'空闲',_utf8mb4'已预约',_utf8mb4'不可用'))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classroom_resource
-- ----------------------------
INSERT INTO `classroom_resource` VALUES ('1', '2025-09-09 08:00:00', '第一周', '星期二', '第一节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('10', '2025-09-10 08:00:00', '第一周', '星期三', '第一节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('100', '2025-09-26 08:00:00', '第三周', '星期四', '第一节', '空闲', 'b006-102', NULL);
INSERT INTO `classroom_resource` VALUES ('101', '2025-09-26 09:00:00', '第三周', '星期四', '第二节', '空闲', 'b006-103', NULL);
INSERT INTO `classroom_resource` VALUES ('102', '2025-09-26 10:10:00', '第三周', '星期四', '第三节', '空闲', 'b006-104', NULL);
INSERT INTO `classroom_resource` VALUES ('103', '2025-09-26 11:10:00', '第三周', '星期四', '第四节', '空闲', 'b006-201', NULL);
INSERT INTO `classroom_resource` VALUES ('104', '2025-09-26 14:00:00', '第三周', '星期四', '第五节', '空闲', 'b006-202', NULL);
INSERT INTO `classroom_resource` VALUES ('105', '2025-09-26 15:00:00', '第三周', '星期四', '第六节', '空闲', 'b006-203', NULL);
INSERT INTO `classroom_resource` VALUES ('106', '2025-09-26 16:10:00', '第三周', '星期四', '第七节', '空闲', 'b006-204', NULL);
INSERT INTO `classroom_resource` VALUES ('107', '2025-09-26 19:00:00', '第三周', '星期四', '第八节', '空闲', 'b006-101', NULL);
INSERT INTO `classroom_resource` VALUES ('108', '2025-09-26 20:00:00', '第三周', '星期四', '第九节', '空闲', 'b006-102', NULL);
INSERT INTO `classroom_resource` VALUES ('109', '2025-09-30 08:00:00', '第四周', '星期一', '第一节', '空闲', 'b007-101', NULL);
INSERT INTO `classroom_resource` VALUES ('11', '2025-09-10 09:00:00', '第一周', '星期三', '第二节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('110', '2025-09-30 09:00:00', '第四周', '星期一', '第二节', '空闲', 'b007-102', NULL);
INSERT INTO `classroom_resource` VALUES ('111', '2025-09-30 10:10:00', '第四周', '星期一', '第三节', '空闲', 'b007-103', NULL);
INSERT INTO `classroom_resource` VALUES ('112', '2025-09-30 11:10:00', '第四周', '星期一', '第四节', '空闲', 'b007-104', NULL);
INSERT INTO `classroom_resource` VALUES ('113', '2025-09-30 14:00:00', '第四周', '星期一', '第五节', '空闲', 'b007-201', NULL);
INSERT INTO `classroom_resource` VALUES ('114', '2025-09-30 15:00:00', '第四周', '星期一', '第六节', '空闲', 'b007-202', NULL);
INSERT INTO `classroom_resource` VALUES ('115', '2025-09-30 16:10:00', '第四周', '星期一', '第七节', '空闲', 'b007-203', NULL);
INSERT INTO `classroom_resource` VALUES ('116', '2025-09-30 19:00:00', '第四周', '星期一', '第八节', '空闲', 'b007-204', NULL);
INSERT INTO `classroom_resource` VALUES ('117', '2025-09-30 20:00:00', '第四周', '星期一', '第九节', '空闲', 'b007-101', NULL);
INSERT INTO `classroom_resource` VALUES ('118', '2025-10-01 08:00:00', '第四周', '星期二', '第一节', '空闲', 'b007-102', NULL);
INSERT INTO `classroom_resource` VALUES ('119', '2025-10-01 09:00:00', '第四周', '星期二', '第二节', '空闲', 'b007-103', NULL);
INSERT INTO `classroom_resource` VALUES ('12', '2025-09-10 10:10:00', '第一周', '星期三', '第三节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('120', '2025-10-01 10:10:00', '第四周', '星期二', '第三节', '空闲', 'b007-104', NULL);
INSERT INTO `classroom_resource` VALUES ('121', '2025-10-01 11:10:00', '第四周', '星期二', '第四节', '空闲', 'b007-201', NULL);
INSERT INTO `classroom_resource` VALUES ('122', '2025-10-01 14:00:00', '第四周', '星期二', '第五节', '空闲', 'b007-202', NULL);
INSERT INTO `classroom_resource` VALUES ('123', '2025-10-01 15:00:00', '第四周', '星期二', '第六节', '空闲', 'b007-203', NULL);
INSERT INTO `classroom_resource` VALUES ('124', '2025-10-01 16:10:00', '第四周', '星期二', '第七节', '空闲', 'b007-204', NULL);
INSERT INTO `classroom_resource` VALUES ('125', '2025-10-01 19:00:00', '第四周', '星期二', '第八节', '空闲', 'b007-101', NULL);
INSERT INTO `classroom_resource` VALUES ('126', '2025-10-01 20:00:00', '第四周', '星期二', '第九节', '空闲', 'b007-102', NULL);
INSERT INTO `classroom_resource` VALUES ('127', '2025-10-02 08:00:00', '第四周', '星期三', '第一节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('128', '2025-10-02 09:00:00', '第四周', '星期三', '第二节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('129', '2025-10-02 10:10:00', '第四周', '星期三', '第三节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('13', '2025-09-10 11:10:00', '第一周', '星期三', '第四节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('130', '2025-10-02 11:10:00', '第四周', '星期三', '第四节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('131', '2025-10-02 14:00:00', '第四周', '星期三', '第五节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('132', '2025-10-02 15:00:00', '第四周', '星期三', '第六节', '空闲', 'b001-202', NULL);
INSERT INTO `classroom_resource` VALUES ('133', '2025-10-02 16:10:00', '第四周', '星期三', '第七节', '空闲', 'b001-203', NULL);
INSERT INTO `classroom_resource` VALUES ('134', '2025-10-02 19:00:00', '第四周', '星期三', '第八节', '空闲', 'b001-204', NULL);
INSERT INTO `classroom_resource` VALUES ('135', '2025-10-02 20:00:00', '第四周', '星期三', '第九节', '空闲', 'b002-301', NULL);
INSERT INTO `classroom_resource` VALUES ('136', '2025-10-03 08:00:00', '第四周', '星期四', '第一节', '空闲', 'b002-302', NULL);
INSERT INTO `classroom_resource` VALUES ('137', '2025-10-03 09:00:00', '第四周', '星期四', '第二节', '空闲', 'b002-303', NULL);
INSERT INTO `classroom_resource` VALUES ('138', '2025-10-03 10:10:00', '第四周', '星期四', '第三节', '空闲', 'b002-304', NULL);
INSERT INTO `classroom_resource` VALUES ('139', '2025-10-03 11:10:00', '第四周', '星期四', '第四节', '空闲', 'b002-401', NULL);
INSERT INTO `classroom_resource` VALUES ('14', '2025-09-10 14:00:00', '第一周', '星期三', '第五节', '空闲', 'b001-202', NULL);
INSERT INTO `classroom_resource` VALUES ('140', '2025-10-03 14:00:00', '第四周', '星期四', '第五节', '空闲', 'b002-402', NULL);
INSERT INTO `classroom_resource` VALUES ('141', '2025-10-03 15:00:00', '第四周', '星期四', '第六节', '空闲', 'b002-403', NULL);
INSERT INTO `classroom_resource` VALUES ('142', '2025-10-03 16:10:00', '第四周', '星期四', '第七节', '空闲', 'b002-404', NULL);
INSERT INTO `classroom_resource` VALUES ('143', '2025-10-03 19:00:00', '第四周', '星期四', '第八节', '空闲', 'b003-101', NULL);
INSERT INTO `classroom_resource` VALUES ('144', '2025-10-03 20:00:00', '第四周', '星期四', '第九节', '空闲', 'b003-102', NULL);
INSERT INTO `classroom_resource` VALUES ('145', '2025-10-04 08:00:00', '第四周', '星期五', '第一节', '空闲', 'b003-103', NULL);
INSERT INTO `classroom_resource` VALUES ('146', '2025-10-04 09:00:00', '第四周', '星期五', '第二节', '空闲', 'b003-104', NULL);
INSERT INTO `classroom_resource` VALUES ('147', '2025-10-04 10:10:00', '第四周', '星期五', '第三节', '空闲', 'b003-201', NULL);
INSERT INTO `classroom_resource` VALUES ('148', '2025-10-04 11:10:00', '第四周', '星期五', '第四节', '空闲', 'b003-202', NULL);
INSERT INTO `classroom_resource` VALUES ('149', '2025-10-04 14:00:00', '第四周', '星期五', '第五节', '空闲', 'b003-203', NULL);
INSERT INTO `classroom_resource` VALUES ('15', '2025-09-10 15:00:00', '第一周', '星期三', '第六节', '空闲', 'b001-203', NULL);
INSERT INTO `classroom_resource` VALUES ('150', '2025-10-04 15:00:00', '第四周', '星期五', '第六节', '空闲', 'b003-204', NULL);
INSERT INTO `classroom_resource` VALUES ('151', '2025-10-04 16:10:00', '第四周', '星期五', '第七节', '空闲', 'b004-101', NULL);
INSERT INTO `classroom_resource` VALUES ('152', '2025-10-04 19:00:00', '第四周', '星期五', '第八节', '空闲', 'b004-102', NULL);
INSERT INTO `classroom_resource` VALUES ('153', '2025-10-04 20:00:00', '第四周', '星期五', '第九节', '空闲', 'b004-103', NULL);
INSERT INTO `classroom_resource` VALUES ('154', '2025-10-05 08:00:00', '第四周', '星期六', '第一节', '空闲', 'b004-104', NULL);
INSERT INTO `classroom_resource` VALUES ('155', '2025-10-05 09:00:00', '第四周', '星期六', '第二节', '空闲', 'b004-201', NULL);
INSERT INTO `classroom_resource` VALUES ('156', '2025-10-05 10:10:00', '第四周', '星期六', '第三节', '空闲', 'b004-202', NULL);
INSERT INTO `classroom_resource` VALUES ('157', '2025-10-05 11:10:00', '第四周', '星期六', '第四节', '空闲', 'b004-203', NULL);
INSERT INTO `classroom_resource` VALUES ('158', '2025-10-05 14:00:00', '第四周', '星期六', '第五节', '空闲', 'b004-204', NULL);
INSERT INTO `classroom_resource` VALUES ('159', '2025-10-05 15:00:00', '第四周', '星期六', '第六节', '空闲', 'b005-101', NULL);
INSERT INTO `classroom_resource` VALUES ('16', '2025-09-10 16:10:00', '第一周', '星期三', '第七节', '空闲', 'b001-204', NULL);
INSERT INTO `classroom_resource` VALUES ('160', '2025-10-05 16:10:00', '第四周', '星期六', '第七节', '空闲', 'b005-102', NULL);
INSERT INTO `classroom_resource` VALUES ('161', '2025-10-05 19:00:00', '第四周', '星期六', '第八节', '空闲', 'b005-103', NULL);
INSERT INTO `classroom_resource` VALUES ('162', '2025-10-05 20:00:00', '第四周', '星期六', '第九节', '空闲', 'b005-104', NULL);
INSERT INTO `classroom_resource` VALUES ('163', '2025-10-06 08:00:00', '第四周', '星期日', '第一节', '空闲', 'b005-201', NULL);
INSERT INTO `classroom_resource` VALUES ('164', '2025-10-06 09:00:00', '第四周', '星期日', '第二节', '空闲', 'b005-202', NULL);
INSERT INTO `classroom_resource` VALUES ('165', '2025-10-06 10:10:00', '第四周', '星期日', '第三节', '空闲', 'b005-203', NULL);
INSERT INTO `classroom_resource` VALUES ('166', '2025-10-06 11:10:00', '第四周', '星期日', '第四节', '空闲', 'b005-204', NULL);
INSERT INTO `classroom_resource` VALUES ('167', '2025-10-06 14:00:00', '第四周', '星期日', '第五节', '空闲', 'b006-101', NULL);
INSERT INTO `classroom_resource` VALUES ('168', '2025-10-06 15:00:00', '第四周', '星期日', '第六节', '空闲', 'b006-102', NULL);
INSERT INTO `classroom_resource` VALUES ('169', '2025-10-06 16:10:00', '第四周', '星期日', '第七节', '空闲', 'b006-103', NULL);
INSERT INTO `classroom_resource` VALUES ('17', '2025-09-10 19:00:00', '第一周', '星期三', '第八节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('170', '2025-10-06 19:00:00', '第四周', '星期日', '第八节', '空闲', 'b006-104', NULL);
INSERT INTO `classroom_resource` VALUES ('171', '2025-10-06 20:00:00', '第四周', '星期日', '第九节', '空闲', 'b006-201', NULL);
INSERT INTO `classroom_resource` VALUES ('172', '2025-10-07 08:00:00', '第五周', '星期一', '第一节', '空闲', 'b006-202', NULL);
INSERT INTO `classroom_resource` VALUES ('173', '2025-10-07 09:00:00', '第五周', '星期一', '第二节', '空闲', 'b006-203', NULL);
INSERT INTO `classroom_resource` VALUES ('174', '2025-10-07 10:10:00', '第五周', '星期一', '第三节', '空闲', 'b006-204', NULL);
INSERT INTO `classroom_resource` VALUES ('175', '2025-10-07 11:10:00', '第五周', '星期一', '第四节', '空闲', 'b007-101', NULL);
INSERT INTO `classroom_resource` VALUES ('176', '2025-10-07 14:00:00', '第五周', '星期一', '第五节', '空闲', 'b007-102', NULL);
INSERT INTO `classroom_resource` VALUES ('177', '2025-10-07 15:00:00', '第五周', '星期一', '第六节', '空闲', 'b007-103', NULL);
INSERT INTO `classroom_resource` VALUES ('178', '2025-10-07 16:10:00', '第五周', '星期一', '第七节', '空闲', 'b007-104', NULL);
INSERT INTO `classroom_resource` VALUES ('179', '2025-10-07 19:00:00', '第五周', '星期一', '第八节', '空闲', 'b007-201', NULL);
INSERT INTO `classroom_resource` VALUES ('18', '2025-09-10 20:00:00', '第一周', '星期三', '第九节', '已预约', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('180', '2025-10-07 20:00:00', '第五周', '星期一', '第九节', '空闲', 'b007-202', NULL);
INSERT INTO `classroom_resource` VALUES ('181', '2025-10-08 08:00:00', '第五周', '星期二', '第一节', '空闲', 'b007-203', NULL);
INSERT INTO `classroom_resource` VALUES ('182', '2025-10-08 09:00:00', '第五周', '星期二', '第二节', '空闲', 'b007-204', NULL);
INSERT INTO `classroom_resource` VALUES ('183', '2025-10-08 10:10:00', '第五周', '星期二', '第三节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('184', '2025-10-08 11:10:00', '第五周', '星期二', '第四节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('185', '2025-10-08 14:00:00', '第五周', '星期二', '第五节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('186', '2025-10-08 15:00:00', '第五周', '星期二', '第六节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('187', '2025-10-08 16:10:00', '第五周', '星期二', '第七节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('188', '2025-10-08 19:00:00', '第五周', '星期二', '第八节', '空闲', 'b001-202', NULL);
INSERT INTO `classroom_resource` VALUES ('189', '2025-10-08 20:00:00', '第五周', '星期二', '第九节', '空闲', 'b001-203', NULL);
INSERT INTO `classroom_resource` VALUES ('19', '2025-09-11 08:00:00', '第一周', '星期四', '第一节', '空闲', 'b002-301', NULL);
INSERT INTO `classroom_resource` VALUES ('190', '2025-10-09 08:00:00', '第五周', '星期三', '第一节', '空闲', 'b001-204', NULL);
INSERT INTO `classroom_resource` VALUES ('191', '2025-10-09 09:00:00', '第五周', '星期三', '第二节', '空闲', 'b002-301', NULL);
INSERT INTO `classroom_resource` VALUES ('192', '2025-10-09 10:10:00', '第五周', '星期三', '第三节', '空闲', 'b002-302', NULL);
INSERT INTO `classroom_resource` VALUES ('193', '2025-10-09 11:10:00', '第五周', '星期三', '第四节', '空闲', 'b002-303', NULL);
INSERT INTO `classroom_resource` VALUES ('194', '2025-10-09 14:00:00', '第五周', '星期三', '第五节', '空闲', 'b002-304', NULL);
INSERT INTO `classroom_resource` VALUES ('195', '2025-10-09 15:00:00', '第五周', '星期三', '第六节', '空闲', 'b002-401', NULL);
INSERT INTO `classroom_resource` VALUES ('196', '2025-10-09 16:10:00', '第五周', '星期三', '第七节', '空闲', 'b002-402', NULL);
INSERT INTO `classroom_resource` VALUES ('197', '2025-10-09 19:00:00', '第五周', '星期三', '第八节', '空闲', 'b002-403', NULL);
INSERT INTO `classroom_resource` VALUES ('198', '2025-10-09 20:00:00', '第五周', '星期三', '第九节', '空闲', 'b002-404', NULL);
INSERT INTO `classroom_resource` VALUES ('199', '2025-10-10 08:00:00', '第五周', '星期四', '第一节', '空闲', 'b003-101', NULL);
INSERT INTO `classroom_resource` VALUES ('2', '2025-09-09 09:00:00', '第一周', '星期二', '第二节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20', '2025-09-11 09:00:00', '第一周', '星期四', '第二节', '空闲', 'b002-302', NULL);
INSERT INTO `classroom_resource` VALUES ('200', '2025-10-10 09:00:00', '第五周', '星期四', '第二节', '空闲', 'b003-102', NULL);
INSERT INTO `classroom_resource` VALUES ('201', '2025-10-10 10:10:00', '第五周', '星期四', '第三节', '空闲', 'b003-103', NULL);
INSERT INTO `classroom_resource` VALUES ('202', '2025-10-10 11:10:00', '第五周', '星期四', '第四节', '空闲', 'b003-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011011', '2025-09-09 00:00:00', '第一周', '星期三', '第一节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011012', '2025-09-09 00:00:00', '第一周', '星期三', '第二节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011013', '2025-09-09 00:00:00', '第一周', '星期三', '第三节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011014', '2025-09-09 00:00:00', '第一周', '星期三', '第四节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011015', '2025-09-09 00:00:00', '第一周', '星期三', '第五节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011016', '2025-09-09 00:00:00', '第一周', '星期三', '第六节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011017', '2025-09-09 00:00:00', '第一周', '星期三', '第七节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011018', '2025-09-09 00:00:00', '第一周', '星期三', '第八节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011019', '2025-09-09 00:00:00', '第一周', '星期三', '第九节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011021', '2025-09-09 00:00:00', '第一周', '星期三', '第一节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011022', '2025-09-09 00:00:00', '第一周', '星期三', '第二节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011023', '2025-09-09 00:00:00', '第一周', '星期三', '第三节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011024', '2025-09-09 00:00:00', '第一周', '星期三', '第四节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011025', '2025-09-09 00:00:00', '第一周', '星期三', '第五节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011026', '2025-09-09 00:00:00', '第一周', '星期三', '第六节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011027', '2025-09-09 00:00:00', '第一周', '星期三', '第七节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011028', '2025-09-09 00:00:00', '第一周', '星期三', '第八节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011029', '2025-09-09 00:00:00', '第一周', '星期三', '第九节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011031', '2025-09-09 00:00:00', '第一周', '星期三', '第一节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011032', '2025-09-09 00:00:00', '第一周', '星期三', '第二节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011033', '2025-09-09 00:00:00', '第一周', '星期三', '第三节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011034', '2025-09-09 00:00:00', '第一周', '星期三', '第四节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011035', '2025-09-09 00:00:00', '第一周', '星期三', '第五节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011036', '2025-09-09 00:00:00', '第一周', '星期三', '第六节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011037', '2025-09-09 00:00:00', '第一周', '星期三', '第七节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011038', '2025-09-09 00:00:00', '第一周', '星期三', '第八节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011039', '2025-09-09 00:00:00', '第一周', '星期三', '第九节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011041', '2025-09-09 00:00:00', '第一周', '星期三', '第一节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011042', '2025-09-09 00:00:00', '第一周', '星期三', '第二节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011043', '2025-09-09 00:00:00', '第一周', '星期三', '第三节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011044', '2025-09-09 00:00:00', '第一周', '星期三', '第四节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011045', '2025-09-09 00:00:00', '第一周', '星期三', '第五节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011046', '2025-09-09 00:00:00', '第一周', '星期三', '第六节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011047', '2025-09-09 00:00:00', '第一周', '星期三', '第七节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011048', '2025-09-09 00:00:00', '第一周', '星期三', '第八节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0011049', '2025-09-09 00:00:00', '第一周', '星期三', '第九节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0012011', '2025-09-09 00:00:00', '第一周', '星期三', '第一节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0012012', '2025-09-09 00:00:00', '第一周', '星期三', '第二节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0012013', '2025-09-09 00:00:00', '第一周', '星期三', '第三节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0012014', '2025-09-09 00:00:00', '第一周', '星期三', '第四节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0012015', '2025-09-09 00:00:00', '第一周', '星期三', '第五节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0012016', '2025-09-09 00:00:00', '第一周', '星期三', '第六节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('20250909b0012017', '2025-09-09 00:00:00', '第一周', '星期三', '第七节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('203', '2025-10-10 14:00:00', '第五周', '星期四', '第五节', '空闲', 'b003-201', NULL);
INSERT INTO `classroom_resource` VALUES ('204', '2025-10-10 15:00:00', '第五周', '星期四', '第六节', '空闲', 'b003-202', NULL);
INSERT INTO `classroom_resource` VALUES ('205', '2025-10-10 16:10:00', '第五周', '星期四', '第七节', '空闲', 'b003-203', NULL);
INSERT INTO `classroom_resource` VALUES ('206', '2025-10-10 19:00:00', '第五周', '星期四', '第八节', '空闲', 'b003-204', NULL);
INSERT INTO `classroom_resource` VALUES ('207', '2025-10-10 20:00:00', '第五周', '星期四', '第九节', '空闲', 'b004-101', NULL);
INSERT INTO `classroom_resource` VALUES ('208', '2025-10-11 08:00:00', '第五周', '星期五', '第一节', '空闲', 'b004-102', NULL);
INSERT INTO `classroom_resource` VALUES ('209', '2025-10-11 09:00:00', '第五周', '星期五', '第二节', '空闲', 'b004-103', NULL);
INSERT INTO `classroom_resource` VALUES ('21', '2025-09-11 10:10:00', '第一周', '星期四', '第三节', '空闲', 'b002-303', NULL);
INSERT INTO `classroom_resource` VALUES ('210', '2025-10-11 10:10:00', '第五周', '星期五', '第三节', '空闲', 'b004-104', NULL);
INSERT INTO `classroom_resource` VALUES ('211', '2025-10-11 11:10:00', '第五周', '星期五', '第四节', '空闲', 'b004-201', NULL);
INSERT INTO `classroom_resource` VALUES ('212', '2025-10-11 14:00:00', '第五周', '星期五', '第五节', '空闲', 'b004-202', NULL);
INSERT INTO `classroom_resource` VALUES ('213', '2025-10-11 15:00:00', '第五周', '星期五', '第六节', '空闲', 'b004-203', NULL);
INSERT INTO `classroom_resource` VALUES ('214', '2025-10-11 16:10:00', '第五周', '星期五', '第七节', '空闲', 'b004-204', NULL);
INSERT INTO `classroom_resource` VALUES ('215', '2025-10-11 19:00:00', '第五周', '星期五', '第八节', '空闲', 'b005-101', NULL);
INSERT INTO `classroom_resource` VALUES ('216', '2025-10-11 20:00:00', '第五周', '星期五', '第九节', '空闲', 'b005-102', NULL);
INSERT INTO `classroom_resource` VALUES ('217', '2025-10-12 08:00:00', '第五周', '星期六', '第一节', '空闲', 'b005-103', NULL);
INSERT INTO `classroom_resource` VALUES ('218', '2025-10-12 09:00:00', '第五周', '星期六', '第二节', '空闲', 'b005-104', NULL);
INSERT INTO `classroom_resource` VALUES ('219', '2025-10-12 10:10:00', '第五周', '星期六', '第三节', '空闲', 'b005-201', NULL);
INSERT INTO `classroom_resource` VALUES ('22', '2025-09-11 11:10:00', '第一周', '星期四', '第四节', '空闲', 'b002-304', NULL);
INSERT INTO `classroom_resource` VALUES ('220', '2025-10-12 11:10:00', '第五周', '星期六', '第四节', '空闲', 'b005-202', NULL);
INSERT INTO `classroom_resource` VALUES ('221', '2025-10-12 14:00:00', '第五周', '星期六', '第五节', '空闲', 'b005-203', NULL);
INSERT INTO `classroom_resource` VALUES ('222', '2025-10-12 15:00:00', '第五周', '星期六', '第六节', '空闲', 'b005-204', NULL);
INSERT INTO `classroom_resource` VALUES ('223', '2025-10-12 16:10:00', '第五周', '星期六', '第七节', '空闲', 'b006-101', NULL);
INSERT INTO `classroom_resource` VALUES ('224', '2025-10-12 19:00:00', '第五周', '星期六', '第八节', '空闲', 'b006-102', NULL);
INSERT INTO `classroom_resource` VALUES ('225', '2025-10-12 20:00:00', '第五周', '星期六', '第九节', '空闲', 'b006-103', NULL);
INSERT INTO `classroom_resource` VALUES ('226', '2025-10-13 08:00:00', '第五周', '星期日', '第一节', '空闲', 'b006-104', NULL);
INSERT INTO `classroom_resource` VALUES ('227', '2025-10-13 09:00:00', '第五周', '星期日', '第二节', '空闲', 'b006-201', NULL);
INSERT INTO `classroom_resource` VALUES ('228', '2025-10-13 10:10:00', '第五周', '星期日', '第三节', '空闲', 'b006-202', NULL);
INSERT INTO `classroom_resource` VALUES ('229', '2025-10-13 11:10:00', '第五周', '星期日', '第四节', '空闲', 'b006-203', NULL);
INSERT INTO `classroom_resource` VALUES ('23', '2025-09-11 14:00:00', '第一周', '星期四', '第五节', '空闲', 'b002-401', NULL);
INSERT INTO `classroom_resource` VALUES ('230', '2025-10-13 14:00:00', '第五周', '星期日', '第五节', '空闲', 'b006-204', NULL);
INSERT INTO `classroom_resource` VALUES ('231', '2025-10-13 15:00:00', '第五周', '星期日', '第六节', '空闲', 'b007-101', NULL);
INSERT INTO `classroom_resource` VALUES ('232', '2025-10-13 16:10:00', '第五周', '星期日', '第七节', '空闲', 'b007-102', NULL);
INSERT INTO `classroom_resource` VALUES ('233', '2025-10-13 19:00:00', '第五周', '星期日', '第八节', '空闲', 'b007-103', NULL);
INSERT INTO `classroom_resource` VALUES ('234', '2025-10-13 20:00:00', '第五周', '星期日', '第九节', '空闲', 'b007-104', NULL);
INSERT INTO `classroom_resource` VALUES ('235', '2025-10-14 08:00:00', '第六周', '星期一', '第一节', '空闲', 'b007-201', NULL);
INSERT INTO `classroom_resource` VALUES ('236', '2025-10-14 09:00:00', '第六周', '星期一', '第二节', '空闲', 'b007-202', NULL);
INSERT INTO `classroom_resource` VALUES ('237', '2025-10-14 10:10:00', '第六周', '星期一', '第三节', '空闲', 'b007-203', NULL);
INSERT INTO `classroom_resource` VALUES ('238', '2025-10-14 11:10:00', '第六周', '星期一', '第四节', '空闲', 'b007-204', NULL);
INSERT INTO `classroom_resource` VALUES ('239', '2025-10-14 14:00:00', '第六周', '星期一', '第五节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('24', '2025-09-11 15:00:00', '第一周', '星期四', '第六节', '空闲', 'b002-402', NULL);
INSERT INTO `classroom_resource` VALUES ('240', '2025-10-14 15:00:00', '第六周', '星期一', '第六节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('241', '2025-10-14 16:10:00', '第六周', '星期一', '第七节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('242', '2025-10-14 19:00:00', '第六周', '星期一', '第八节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('243', '2025-10-14 20:00:00', '第六周', '星期一', '第九节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('244', '2025-10-15 08:00:00', '第六周', '星期二', '第一节', '空闲', 'b001-202', NULL);
INSERT INTO `classroom_resource` VALUES ('245', '2025-10-15 09:00:00', '第六周', '星期二', '第二节', '空闲', 'b001-203', NULL);
INSERT INTO `classroom_resource` VALUES ('246', '2025-10-15 10:10:00', '第六周', '星期二', '第三节', '空闲', 'b001-204', NULL);
INSERT INTO `classroom_resource` VALUES ('247', '2025-10-15 11:10:00', '第六周', '星期二', '第四节', '空闲', 'b002-301', NULL);
INSERT INTO `classroom_resource` VALUES ('248', '2025-10-15 14:00:00', '第六周', '星期二', '第五节', '空闲', 'b002-302', NULL);
INSERT INTO `classroom_resource` VALUES ('249', '2025-10-15 15:00:00', '第六周', '星期二', '第六节', '空闲', 'b002-303', NULL);
INSERT INTO `classroom_resource` VALUES ('25', '2025-09-11 16:10:00', '第一周', '星期四', '第七节', '空闲', 'b002-403', NULL);
INSERT INTO `classroom_resource` VALUES ('250', '2025-10-15 16:10:00', '第六周', '星期二', '第七节', '空闲', 'b002-304', NULL);
INSERT INTO `classroom_resource` VALUES ('251', '2025-10-15 19:00:00', '第六周', '星期二', '第八节', '空闲', 'b002-401', NULL);
INSERT INTO `classroom_resource` VALUES ('252', '2025-10-15 20:00:00', '第六周', '星期二', '第九节', '空闲', 'b002-402', NULL);
INSERT INTO `classroom_resource` VALUES ('253', '2025-10-16 08:00:00', '第六周', '星期三', '第一节', '空闲', 'b002-403', NULL);
INSERT INTO `classroom_resource` VALUES ('254', '2025-10-16 09:00:00', '第六周', '星期三', '第二节', '空闲', 'b002-404', NULL);
INSERT INTO `classroom_resource` VALUES ('255', '2025-10-16 10:10:00', '第六周', '星期三', '第三节', '空闲', 'b003-101', NULL);
INSERT INTO `classroom_resource` VALUES ('256', '2025-10-16 11:10:00', '第六周', '星期三', '第四节', '空闲', 'b003-102', NULL);
INSERT INTO `classroom_resource` VALUES ('257', '2025-10-16 14:00:00', '第六周', '星期三', '第五节', '空闲', 'b003-103', NULL);
INSERT INTO `classroom_resource` VALUES ('258', '2025-10-16 15:00:00', '第六周', '星期三', '第六节', '空闲', 'b003-104', NULL);
INSERT INTO `classroom_resource` VALUES ('259', '2025-10-16 16:10:00', '第六周', '星期三', '第七节', '空闲', 'b003-201', NULL);
INSERT INTO `classroom_resource` VALUES ('26', '2025-09-11 19:00:00', '第一周', '星期四', '第八节', '空闲', 'b002-404', NULL);
INSERT INTO `classroom_resource` VALUES ('260', '2025-10-16 19:00:00', '第六周', '星期三', '第八节', '空闲', 'b003-202', NULL);
INSERT INTO `classroom_resource` VALUES ('261', '2025-10-16 20:00:00', '第六周', '星期三', '第九节', '空闲', 'b003-203', NULL);
INSERT INTO `classroom_resource` VALUES ('262', '2025-10-17 08:00:00', '第六周', '星期四', '第一节', '空闲', 'b003-204', NULL);
INSERT INTO `classroom_resource` VALUES ('263', '2025-10-17 09:00:00', '第六周', '星期四', '第二节', '空闲', 'b004-101', NULL);
INSERT INTO `classroom_resource` VALUES ('264', '2025-10-17 10:10:00', '第六周', '星期四', '第三节', '空闲', 'b004-102', NULL);
INSERT INTO `classroom_resource` VALUES ('265', '2025-10-17 11:10:00', '第六周', '星期四', '第四节', '空闲', 'b004-103', NULL);
INSERT INTO `classroom_resource` VALUES ('266', '2025-10-17 14:00:00', '第六周', '星期四', '第五节', '空闲', 'b004-104', NULL);
INSERT INTO `classroom_resource` VALUES ('267', '2025-10-17 15:00:00', '第六周', '星期四', '第六节', '空闲', 'b004-201', NULL);
INSERT INTO `classroom_resource` VALUES ('268', '2025-10-17 16:10:00', '第六周', '星期四', '第七节', '空闲', 'b004-202', NULL);
INSERT INTO `classroom_resource` VALUES ('269', '2025-10-17 19:00:00', '第六周', '星期四', '第八节', '空闲', 'b004-203', NULL);
INSERT INTO `classroom_resource` VALUES ('27', '2025-09-11 20:00:00', '第一周', '星期四', '第九节', '空闲', 'b002-301', NULL);
INSERT INTO `classroom_resource` VALUES ('270', '2025-10-17 20:00:00', '第六周', '星期四', '第九节', '空闲', 'b004-204', NULL);
INSERT INTO `classroom_resource` VALUES ('271', '2025-10-18 08:00:00', '第六周', '星期五', '第一节', '空闲', 'b005-101', NULL);
INSERT INTO `classroom_resource` VALUES ('272', '2025-10-18 09:00:00', '第六周', '星期五', '第二节', '空闲', 'b005-102', NULL);
INSERT INTO `classroom_resource` VALUES ('273', '2025-10-18 10:10:00', '第六周', '星期五', '第三节', '空闲', 'b005-103', NULL);
INSERT INTO `classroom_resource` VALUES ('274', '2025-10-18 11:10:00', '第六周', '星期五', '第四节', '空闲', 'b005-104', NULL);
INSERT INTO `classroom_resource` VALUES ('275', '2025-10-18 14:00:00', '第六周', '星期五', '第五节', '空闲', 'b005-201', NULL);
INSERT INTO `classroom_resource` VALUES ('276', '2025-10-18 15:00:00', '第六周', '星期五', '第六节', '空闲', 'b005-202', NULL);
INSERT INTO `classroom_resource` VALUES ('277', '2025-10-18 16:10:00', '第六周', '星期五', '第七节', '空闲', 'b005-203', NULL);
INSERT INTO `classroom_resource` VALUES ('278', '2025-10-18 19:00:00', '第六周', '星期五', '第八节', '空闲', 'b005-204', NULL);
INSERT INTO `classroom_resource` VALUES ('279', '2025-10-18 20:00:00', '第六周', '星期五', '第九节', '空闲', 'b006-101', NULL);
INSERT INTO `classroom_resource` VALUES ('28', '2025-09-12 08:00:00', '第一周', '星期五', '第一节', '空闲', 'b002-302', NULL);
INSERT INTO `classroom_resource` VALUES ('280', '2025-10-19 08:00:00', '第六周', '星期六', '第一节', '空闲', 'b006-102', NULL);
INSERT INTO `classroom_resource` VALUES ('281', '2025-10-19 09:00:00', '第六周', '星期六', '第二节', '空闲', 'b006-103', NULL);
INSERT INTO `classroom_resource` VALUES ('282', '2025-10-19 10:10:00', '第六周', '星期六', '第三节', '空闲', 'b006-104', NULL);
INSERT INTO `classroom_resource` VALUES ('283', '2025-10-19 11:10:00', '第六周', '星期六', '第四节', '空闲', 'b006-201', NULL);
INSERT INTO `classroom_resource` VALUES ('284', '2025-10-19 14:00:00', '第六周', '星期六', '第五节', '空闲', 'b006-202', NULL);
INSERT INTO `classroom_resource` VALUES ('285', '2025-10-19 15:00:00', '第六周', '星期六', '第六节', '空闲', 'b006-203', NULL);
INSERT INTO `classroom_resource` VALUES ('286', '2025-10-19 16:10:00', '第六周', '星期六', '第七节', '空闲', 'b006-204', NULL);
INSERT INTO `classroom_resource` VALUES ('287', '2025-10-19 19:00:00', '第六周', '星期六', '第八节', '空闲', 'b007-101', NULL);
INSERT INTO `classroom_resource` VALUES ('288', '2025-10-19 20:00:00', '第六周', '星期六', '第九节', '空闲', 'b007-102', NULL);
INSERT INTO `classroom_resource` VALUES ('289', '2025-10-20 08:00:00', '第六周', '星期日', '第一节', '空闲', 'b007-103', NULL);
INSERT INTO `classroom_resource` VALUES ('29', '2025-09-12 09:00:00', '第一周', '星期五', '第二节', '空闲', 'b002-303', NULL);
INSERT INTO `classroom_resource` VALUES ('290', '2025-10-20 09:00:00', '第六周', '星期日', '第二节', '空闲', 'b007-104', NULL);
INSERT INTO `classroom_resource` VALUES ('291', '2025-10-20 10:10:00', '第六周', '星期日', '第三节', '空闲', 'b007-201', NULL);
INSERT INTO `classroom_resource` VALUES ('292', '2025-10-20 11:10:00', '第六周', '星期日', '第四节', '空闲', 'b007-202', NULL);
INSERT INTO `classroom_resource` VALUES ('293', '2025-10-20 14:00:00', '第六周', '星期日', '第五节', '空闲', 'b007-203', NULL);
INSERT INTO `classroom_resource` VALUES ('294', '2025-10-20 15:00:00', '第六周', '星期日', '第六节', '空闲', 'b007-204', NULL);
INSERT INTO `classroom_resource` VALUES ('295', '2025-10-20 16:10:00', '第六周', '星期日', '第七节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('296', '2025-10-20 19:00:00', '第六周', '星期日', '第八节', '空闲', 'b001-102', NULL);
INSERT INTO `classroom_resource` VALUES ('297', '2025-10-20 20:00:00', '第六周', '星期日', '第九节', '空闲', 'b001-103', NULL);
INSERT INTO `classroom_resource` VALUES ('298', '2025-10-21 08:00:00', '第七周', '星期一', '第一节', '空闲', 'b001-104', NULL);
INSERT INTO `classroom_resource` VALUES ('299', '2025-10-21 09:00:00', '第七周', '星期一', '第二节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('3', '2025-09-09 10:10:00', '第一周', '星期二', '第三节', '已预约', 'b001-103', '1957664107012427776');
INSERT INTO `classroom_resource` VALUES ('30', '2025-09-12 10:10:00', '第一周', '星期五', '第三节', '空闲', 'b002-304', NULL);
INSERT INTO `classroom_resource` VALUES ('300', '2025-10-21 10:10:00', '第七周', '星期一', '第三节', '空闲', 'b001-202', NULL);
INSERT INTO `classroom_resource` VALUES ('301', '2025-10-21 11:10:00', '第七周', '星期一', '第四节', '空闲', 'b001-203', NULL);
INSERT INTO `classroom_resource` VALUES ('302', '2025-10-21 14:00:00', '第七周', '星期一', '第五节', '空闲', 'b001-204', NULL);
INSERT INTO `classroom_resource` VALUES ('303', '2025-10-21 15:00:00', '第七周', '星期一', '第六节', '空闲', 'b002-301', NULL);
INSERT INTO `classroom_resource` VALUES ('304', '2025-10-21 16:10:00', '第七周', '星期一', '第七节', '空闲', 'b002-302', NULL);
INSERT INTO `classroom_resource` VALUES ('305', '2025-10-21 19:00:00', '第七周', '星期一', '第八节', '空闲', 'b002-303', NULL);
INSERT INTO `classroom_resource` VALUES ('306', '2025-10-21 20:00:00', '第七周', '星期一', '第九节', '空闲', 'b002-304', NULL);
INSERT INTO `classroom_resource` VALUES ('31', '2025-09-12 11:10:00', '第一周', '星期五', '第四节', '空闲', 'b002-401', NULL);
INSERT INTO `classroom_resource` VALUES ('32', '2025-09-12 14:00:00', '第一周', '星期五', '第五节', '空闲', 'b002-402', NULL);
INSERT INTO `classroom_resource` VALUES ('33', '2025-09-12 15:00:00', '第一周', '星期五', '第六节', '空闲', 'b002-403', NULL);
INSERT INTO `classroom_resource` VALUES ('34', '2025-09-12 16:10:00', '第一周', '星期五', '第七节', '空闲', 'b002-404', NULL);
INSERT INTO `classroom_resource` VALUES ('35', '2025-09-12 19:00:00', '第一周', '星期五', '第八节', '空闲', 'b002-301', NULL);
INSERT INTO `classroom_resource` VALUES ('36', '2025-09-12 20:00:00', '第一周', '星期五', '第九节', '空闲', 'b002-302', NULL);
INSERT INTO `classroom_resource` VALUES ('37', '2025-09-16 08:00:00', '第二周', '星期一', '第一节', '空闲', 'b003-101', NULL);
INSERT INTO `classroom_resource` VALUES ('38', '2025-09-16 09:00:00', '第二周', '星期一', '第二节', '空闲', 'b003-102', NULL);
INSERT INTO `classroom_resource` VALUES ('39', '2025-09-16 10:10:00', '第二周', '星期一', '第三节', '空闲', 'b003-103', NULL);
INSERT INTO `classroom_resource` VALUES ('4', '2025-09-09 11:10:00', '第一周', '星期二', '第四节', '已预约', 'b001-104', '1957664107012427776');
INSERT INTO `classroom_resource` VALUES ('40', '2025-09-16 11:10:00', '第二周', '星期一', '第四节', '空闲', 'b003-104', NULL);
INSERT INTO `classroom_resource` VALUES ('41', '2025-09-16 14:00:00', '第二周', '星期一', '第五节', '空闲', 'b003-201', NULL);
INSERT INTO `classroom_resource` VALUES ('42', '2025-09-16 15:00:00', '第二周', '星期一', '第六节', '空闲', 'b003-202', NULL);
INSERT INTO `classroom_resource` VALUES ('43', '2025-09-16 16:10:00', '第二周', '星期一', '第七节', '空闲', 'b003-203', NULL);
INSERT INTO `classroom_resource` VALUES ('44', '2025-09-16 19:00:00', '第二周', '星期一', '第八节', '空闲', 'b003-204', NULL);
INSERT INTO `classroom_resource` VALUES ('45', '2025-09-16 20:00:00', '第二周', '星期一', '第九节', '空闲', 'b003-101', NULL);
INSERT INTO `classroom_resource` VALUES ('46', '2025-09-17 08:00:00', '第二周', '星期二', '第一节', '空闲', 'b003-102', NULL);
INSERT INTO `classroom_resource` VALUES ('47', '2025-09-17 09:00:00', '第二周', '星期二', '第二节', '空闲', 'b003-103', NULL);
INSERT INTO `classroom_resource` VALUES ('48', '2025-09-17 10:10:00', '第二周', '星期二', '第三节', '空闲', 'b003-104', NULL);
INSERT INTO `classroom_resource` VALUES ('49', '2025-09-17 11:10:00', '第二周', '星期二', '第四节', '空闲', 'b003-201', NULL);
INSERT INTO `classroom_resource` VALUES ('5', '2025-09-09 14:00:00', '第一周', '星期二', '第五节', '空闲', 'b001-201', NULL);
INSERT INTO `classroom_resource` VALUES ('50', '2025-09-17 14:00:00', '第二周', '星期二', '第五节', '空闲', 'b003-202', NULL);
INSERT INTO `classroom_resource` VALUES ('51', '2025-09-17 15:00:00', '第二周', '星期二', '第六节', '空闲', 'b003-203', NULL);
INSERT INTO `classroom_resource` VALUES ('52', '2025-09-17 16:10:00', '第二周', '星期二', '第七节', '空闲', 'b003-204', NULL);
INSERT INTO `classroom_resource` VALUES ('53', '2025-09-17 19:00:00', '第二周', '星期二', '第八节', '空闲', 'b003-101', NULL);
INSERT INTO `classroom_resource` VALUES ('54', '2025-09-17 20:00:00', '第二周', '星期二', '第九节', '空闲', 'b003-102', NULL);
INSERT INTO `classroom_resource` VALUES ('55', '2025-09-18 08:00:00', '第二周', '星期三', '第一节', '空闲', 'b004-101', NULL);
INSERT INTO `classroom_resource` VALUES ('56', '2025-09-18 09:00:00', '第二周', '星期三', '第二节', '空闲', 'b004-102', NULL);
INSERT INTO `classroom_resource` VALUES ('57', '2025-09-18 10:10:00', '第二周', '星期三', '第三节', '空闲', 'b004-103', NULL);
INSERT INTO `classroom_resource` VALUES ('58', '2025-09-18 11:10:00', '第二周', '星期三', '第四节', '空闲', 'b004-104', NULL);
INSERT INTO `classroom_resource` VALUES ('59', '2025-09-18 14:00:00', '第二周', '星期三', '第五节', '空闲', 'b004-201', NULL);
INSERT INTO `classroom_resource` VALUES ('6', '2025-09-09 15:00:00', '第一周', '星期二', '第六节', '空闲', 'b001-202', NULL);
INSERT INTO `classroom_resource` VALUES ('60', '2025-09-18 15:00:00', '第二周', '星期三', '第六节', '空闲', 'b004-202', NULL);
INSERT INTO `classroom_resource` VALUES ('61', '2025-09-18 16:10:00', '第二周', '星期三', '第七节', '空闲', 'b004-203', NULL);
INSERT INTO `classroom_resource` VALUES ('62', '2025-09-18 19:00:00', '第二周', '星期三', '第八节', '空闲', 'b004-204', NULL);
INSERT INTO `classroom_resource` VALUES ('63', '2025-09-18 20:00:00', '第二周', '星期三', '第九节', '空闲', 'b004-101', NULL);
INSERT INTO `classroom_resource` VALUES ('64', '2025-09-19 08:00:00', '第二周', '星期四', '第一节', '空闲', 'b004-102', NULL);
INSERT INTO `classroom_resource` VALUES ('65', '2025-09-19 09:00:00', '第二周', '星期四', '第二节', '空闲', 'b004-103', NULL);
INSERT INTO `classroom_resource` VALUES ('66', '2025-09-19 10:10:00', '第二周', '星期四', '第三节', '空闲', 'b004-104', NULL);
INSERT INTO `classroom_resource` VALUES ('67', '2025-09-19 11:10:00', '第二周', '星期四', '第四节', '空闲', 'b004-201', NULL);
INSERT INTO `classroom_resource` VALUES ('68', '2025-09-19 14:00:00', '第二周', '星期四', '第五节', '空闲', 'b004-202', NULL);
INSERT INTO `classroom_resource` VALUES ('69', '2025-09-19 15:00:00', '第二周', '星期四', '第六节', '空闲', 'b004-203', NULL);
INSERT INTO `classroom_resource` VALUES ('7', '2025-09-09 16:10:00', '第一周', '星期二', '第七节', '空闲', 'b001-203', NULL);
INSERT INTO `classroom_resource` VALUES ('70', '2025-09-19 16:10:00', '第二周', '星期四', '第七节', '空闲', 'b004-204', NULL);
INSERT INTO `classroom_resource` VALUES ('71', '2025-09-19 19:00:00', '第二周', '星期四', '第八节', '空闲', 'b004-101', NULL);
INSERT INTO `classroom_resource` VALUES ('72', '2025-09-19 20:00:00', '第二周', '星期四', '第九节', '空闲', 'b004-102', NULL);
INSERT INTO `classroom_resource` VALUES ('73', '2025-09-23 08:00:00', '第三周', '星期一', '第一节', '空闲', 'b005-101', NULL);
INSERT INTO `classroom_resource` VALUES ('74', '2025-09-23 09:00:00', '第三周', '星期一', '第二节', '空闲', 'b005-102', NULL);
INSERT INTO `classroom_resource` VALUES ('75', '2025-09-23 10:10:00', '第三周', '星期一', '第三节', '空闲', 'b005-103', NULL);
INSERT INTO `classroom_resource` VALUES ('76', '2025-09-23 11:10:00', '第三周', '星期一', '第四节', '空闲', 'b005-104', NULL);
INSERT INTO `classroom_resource` VALUES ('77', '2025-09-23 14:00:00', '第三周', '星期一', '第五节', '空闲', 'b005-201', NULL);
INSERT INTO `classroom_resource` VALUES ('78', '2025-09-23 15:00:00', '第三周', '星期一', '第六节', '空闲', 'b005-202', NULL);
INSERT INTO `classroom_resource` VALUES ('79', '2025-09-23 16:10:00', '第三周', '星期一', '第七节', '空闲', 'b005-203', NULL);
INSERT INTO `classroom_resource` VALUES ('8', '2025-09-09 19:00:00', '第一周', '星期二', '第八节', '空闲', 'b001-204', NULL);
INSERT INTO `classroom_resource` VALUES ('80', '2025-09-23 19:00:00', '第三周', '星期一', '第八节', '空闲', 'b005-204', NULL);
INSERT INTO `classroom_resource` VALUES ('81', '2025-09-23 20:00:00', '第三周', '星期一', '第九节', '空闲', 'b005-101', NULL);
INSERT INTO `classroom_resource` VALUES ('82', '2025-09-24 08:00:00', '第三周', '星期二', '第一节', '空闲', 'b005-102', NULL);
INSERT INTO `classroom_resource` VALUES ('83', '2025-09-24 09:00:00', '第三周', '星期二', '第二节', '空闲', 'b005-103', NULL);
INSERT INTO `classroom_resource` VALUES ('84', '2025-09-24 10:10:00', '第三周', '星期二', '第三节', '空闲', 'b005-104', NULL);
INSERT INTO `classroom_resource` VALUES ('85', '2025-09-24 11:10:00', '第三周', '星期二', '第四节', '空闲', 'b005-201', NULL);
INSERT INTO `classroom_resource` VALUES ('86', '2025-09-24 14:00:00', '第三周', '星期二', '第五节', '空闲', 'b005-202', NULL);
INSERT INTO `classroom_resource` VALUES ('87', '2025-09-24 15:00:00', '第三周', '星期二', '第六节', '空闲', 'b005-203', NULL);
INSERT INTO `classroom_resource` VALUES ('88', '2025-09-24 16:10:00', '第三周', '星期二', '第七节', '空闲', 'b005-204', NULL);
INSERT INTO `classroom_resource` VALUES ('89', '2025-09-24 19:00:00', '第三周', '星期二', '第八节', '空闲', 'b005-101', NULL);
INSERT INTO `classroom_resource` VALUES ('9', '2025-09-09 20:00:00', '第一周', '星期二', '第九节', '空闲', 'b001-101', NULL);
INSERT INTO `classroom_resource` VALUES ('90', '2025-09-24 20:00:00', '第三周', '星期二', '第九节', '空闲', 'b005-102', NULL);
INSERT INTO `classroom_resource` VALUES ('91', '2025-09-25 08:00:00', '第三周', '星期三', '第一节', '空闲', 'b006-101', NULL);
INSERT INTO `classroom_resource` VALUES ('92', '2025-09-25 09:00:00', '第三周', '星期三', '第二节', '空闲', 'b006-102', NULL);
INSERT INTO `classroom_resource` VALUES ('93', '2025-09-25 10:10:00', '第三周', '星期三', '第三节', '空闲', 'b006-103', NULL);
INSERT INTO `classroom_resource` VALUES ('94', '2025-09-25 11:10:00', '第三周', '星期三', '第四节', '空闲', 'b006-104', NULL);
INSERT INTO `classroom_resource` VALUES ('95', '2025-09-25 14:00:00', '第三周', '星期三', '第五节', '空闲', 'b006-201', NULL);
INSERT INTO `classroom_resource` VALUES ('96', '2025-09-25 15:00:00', '第三周', '星期三', '第六节', '空闲', 'b006-202', NULL);
INSERT INTO `classroom_resource` VALUES ('97', '2025-09-25 16:10:00', '第三周', '星期三', '第七节', '空闲', 'b006-203', NULL);
INSERT INTO `classroom_resource` VALUES ('98', '2025-09-25 19:00:00', '第三周', '星期三', '第八节', '空闲', 'b006-204', NULL);
INSERT INTO `classroom_resource` VALUES ('99', '2025-09-25 20:00:00', '第三周', '星期三', '第九节', '空闲', 'b006-101', NULL);

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
INSERT INTO `college` VALUES ('col001', '人工智能学院');
INSERT INTO `college` VALUES ('col002', '电子与物理学院');
INSERT INTO `college` VALUES ('col003', '外国语学院');
INSERT INTO `college` VALUES ('col004', '国际教育学院');
INSERT INTO `college` VALUES ('col005', '文学院');
INSERT INTO `college` VALUES ('col006', '政治与管理学院');
INSERT INTO `college` VALUES ('col007', '民族与社会学学院');

-- ----------------------------
-- Table structure for login
-- ----------------------------
DROP TABLE IF EXISTS `login`;
CREATE TABLE `login`  (
  `login_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '登录日志编号',
  `user_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户的账号',
  `login_time` datetime NULL DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`login_id` DESC) USING BTREE,
  INDEX `user_id_1`(`user_account` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of login
-- ----------------------------
INSERT INTO `login` VALUES ('logf9bbd766da', 'user001', '2025-08-12 14:38:31');
INSERT INTO `login` VALUES ('logf63d30a963', 'user001', '2025-08-12 13:23:56');
INSERT INTO `login` VALUES ('logf36b7e8286', 'user001', '2025-08-12 13:19:48');
INSERT INTO `login` VALUES ('logf28cd6628b', 'user001', '2025-08-12 13:01:49');
INSERT INTO `login` VALUES ('loge692dc55b1', 'user001', '2025-08-12 13:20:33');
INSERT INTO `login` VALUES ('loge49c1beb54', 'user001', '2025-08-09 23:48:46');
INSERT INTO `login` VALUES ('logd575bdaf1f', 'user001', '2025-08-12 13:22:39');
INSERT INTO `login` VALUES ('logd3042a11c2', 'user001', '2025-08-12 13:37:32');
INSERT INTO `login` VALUES ('logca10cd2af9', 'user001', '2025-08-09 23:48:10');
INSERT INTO `login` VALUES ('logc7c75c2099', 'user001', '2025-08-12 13:02:10');
INSERT INTO `login` VALUES ('logc1c811cee2', 'user001', '2025-08-12 14:15:19');
INSERT INTO `login` VALUES ('logc0d0346a02', 'user001', '2025-08-12 13:20:06');
INSERT INTO `login` VALUES ('logbd91697696', 'user001', '2025-08-12 13:18:01');
INSERT INTO `login` VALUES ('logbb2f59af3c', 'user001', '2025-08-12 14:05:40');
INSERT INTO `login` VALUES ('logbafbe38351', 'user001', '2025-08-14 20:37:13');
INSERT INTO `login` VALUES ('logb9f34de658', 'user001', '2025-08-12 12:56:24');
INSERT INTO `login` VALUES ('logae0b6418b0', 'user001', '2025-08-12 13:27:05');
INSERT INTO `login` VALUES ('loga8fb29bd8b', 'user001', '2025-08-12 13:26:39');
INSERT INTO `login` VALUES ('log8fd515fa05', 'user001', '2025-08-09 23:21:59');
INSERT INTO `login` VALUES ('log7e75af067d', 'user001', '2025-08-09 23:20:42');
INSERT INTO `login` VALUES ('log73788c9b35', 'user001', '2025-08-12 14:26:34');
INSERT INTO `login` VALUES ('log7349efcb8a', 'user001', '2025-08-12 13:41:43');
INSERT INTO `login` VALUES ('log725f506a43', 'user001', '2025-08-09 23:40:33');
INSERT INTO `login` VALUES ('log6a0df6442c', 'user001', '2025-08-12 12:56:37');
INSERT INTO `login` VALUES ('log62187b1612', 'admin', '2025-08-19 12:33:37');
INSERT INTO `login` VALUES ('log5fb0f56a54', 'user001', '2025-08-12 13:52:03');
INSERT INTO `login` VALUES ('log5d3dcaf799', 'user001', '2025-08-12 13:55:50');
INSERT INTO `login` VALUES ('log5b9029203b', 'user001', '2025-08-09 23:37:36');
INSERT INTO `login` VALUES ('log4f876e5f13', 'user001', '2025-08-12 12:58:08');
INSERT INTO `login` VALUES ('log4e5701ff53', 'user001', '2025-08-09 23:48:53');
INSERT INTO `login` VALUES ('log2a0d914025', 'user001', '2025-08-12 14:43:23');
INSERT INTO `login` VALUES ('log22dbfeaa2b', 'user001', '2025-08-09 23:34:10');
INSERT INTO `login` VALUES ('log1c6ffaf1b9', 'user001', '2025-08-12 13:07:53');
INSERT INTO `login` VALUES ('log140f9f735b', 'user001', '2025-08-12 14:25:51');
INSERT INTO `login` VALUES ('log13c4ee6299', 'user001', '2025-08-09 20:25:32');
INSERT INTO `login` VALUES ('log0ed15fb5b0', 'user001', '2025-08-09 23:22:41');
INSERT INTO `login` VALUES ('log0db785b535', 'user001', '2025-08-12 12:53:54');
INSERT INTO `login` VALUES ('log0d45e62dbf', 'user001', '2025-08-09 23:29:55');
INSERT INTO `login` VALUES ('log005', 'user004', '2025-07-31 11:05:44');
INSERT INTO `login` VALUES ('log004', 'user003', '2025-07-31 10:15:33');
INSERT INTO `login` VALUES ('log003', 'user001', '2025-07-31 13:20:18');
INSERT INTO `login` VALUES ('log002', 'user002', '2025-07-31 09:45:22');
INSERT INTO `login` VALUES ('log001', 'user001', '2025-07-31 08:30:15');

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
INSERT INTO `teach_secretary` VALUES ('sec000', '666666', '默认教秘', '1257859636', 'col001');
INSERT INTO `teach_secretary` VALUES ('sec001', '888888', '何老师', '88888', 'col001');
INSERT INTO `teach_secretary` VALUES ('sec002', 'pass456', '李教秘', '0510-87654321', 'col002');
INSERT INTO `teach_secretary` VALUES ('sec003', 'pass789', '王教秘', '0510-11223344', 'col003');
INSERT INTO `teach_secretary` VALUES ('sec004', '555', '冯老师', '912390', 'col004');
INSERT INTO `teach_secretary` VALUES ('sec005', '666', '邓老师', '1293281', 'col005');
INSERT INTO `teach_secretary` VALUES ('sec006', '777', '韦老师', '1238123', 'col006');
INSERT INTO `teach_secretary` VALUES ('sec007', '888', '陈老师', '12312412', 'col007');

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
INSERT INTO `users` VALUES ('user001', '666', '邓发成', '666', 'col001');
INSERT INTO `users` VALUES ('user002', 'userpass2', '王美淇', '13800138002', 'col002');
INSERT INTO `users` VALUES ('user003', 'userpass3', '冯诺诗', '13800138003', 'col003');
INSERT INTO `users` VALUES ('user004', 'userpass4', '李佳玲', '13800138004', 'col001');
INSERT INTO `users` VALUES ('user005', 'userpass5', '陈家怡', '88888888', 'col006');
INSERT INTO `users` VALUES ('user006', 'userpass6', '韦嘉慧', '6666666', 'col007');

-- ----------------------------
-- View structure for unapply_applications
-- ----------------------------
DROP VIEW IF EXISTS `unapply_applications`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `unapply_applications` AS select `apply_info`.`apply_id` AS `apply_id`,`apply_info`.`apply_purpose` AS `apply_purpose`,`apply_info`.`apply_book_time` AS `apply_book_time`,`users`.`user_name` AS `user_name` from (`apply_info` join `users`) where ((`apply_info`.`user_account` = `users`.`user_account`) and (`apply_info`.`apply_status` = '未审核'));

-- ----------------------------
-- Procedure structure for GenerateClassroomData
-- ----------------------------
DROP PROCEDURE IF EXISTS `GenerateClassroomData`;
delimiter ;;
CREATE PROCEDURE `GenerateClassroomData`()
BEGIN
  DECLARE day INT DEFAULT 0;
  DECLARE room_idx INT;
  DECLARE period INT;
  -- 循环7天
  WHILE day < 7 DO
    SET room_idx = 0;
    -- 循环5个教室
    WHILE room_idx < 5 DO
      SET period = 1;
      -- 循环9节课
      WHILE period <= 9 DO
        INSERT INTO classroom_resource VALUES(
          CONCAT(DATE_FORMAT(DATE_ADD('2025-09-09', INTERVAL day DAY), '%Y%m%d'),
                 REPLACE(ELT(room_idx+1, 'b001-101','b001-102','b001-103','b001-104','b001-201'), '-', ''),
                 period),
          CONCAT(DATE_ADD('2025-09-09', INTERVAL day DAY), ' 00:00:00'),
          IF(day<6, '第一周', '第二周'),
          ELT(WEEKDAY(DATE_ADD('2025-09-09', INTERVAL day DAY))+2,
              '星期一','星期二','星期三','星期四','星期五','星期六','星期日'),
          CONCAT('第', ELT(period, '一','二','三','四','五','六','七','八','九'), '节'),
          ELT(CEIL(RAND()*10), '空闲','空闲','空闲','空闲','空闲','空闲','空闲','空闲','空闲','已预约','不可用'),
          ELT(room_idx+1, 'b001-101','b001-102','b001-103','b001-104','b001-201'),
          NULL
        );
        SET period = period + 1;
      END WHILE;
      SET room_idx = room_idx + 1;
    END WHILE;
    SET day = day + 1;
  END WHILE;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
