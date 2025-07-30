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

 Date: 28/07/2025 15:56:21
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
  `user_cancel` smallint DEFAULT 0 COMMENT '用户是否取消，0为否，1为是',
  `user_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '预约用户账号',
  `sec_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教秘账号',
  PRIMARY KEY (`apply_id`) USING BTREE,
  INDEX `user_account`(`user_account` ASC) USING BTREE,
  INDEX `sec_account`(`sec_account` ASC) USING BTREE,
  CONSTRAINT `apply_info_ibfk_1` FOREIGN KEY (`user_account`) REFERENCES `users` (`user_account`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `apply_info_ibfk_2` FOREIGN KEY (`sec_account`) REFERENCES `teach_secretary` (`sec_account`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `apply_info_chk_1` CHECK (`apply_status` in (_utf8mb4'未审核',_utf8mb4'已批准',_utf8mb4'已拒绝')),
  CONSTRAINT `chk_apply_status` CHECK (`apply_status` in (_utf8mb4'未审核',_utf8mb4'已批准',_utf8mb4'已拒绝'))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of apply_info
-- ----------------------------
INSERT INTO `apply_info` VALUES ('AP001', 30, '课程研讨', '2024-09-01 09:30:00', '未审核', NULL,0, '2023001', 'sec_jsj');
INSERT INTO `apply_info` VALUES ('AP002', 20, '社团活动', '2024-09-01 10:15:00', '已批准', NULL,0, '2023002', 'sec_wx');
INSERT INTO `apply_info` VALUES ('AP003', 15, '讲座', '2024-09-01 14:00:00', '已拒绝', '场地冲突',0, '2023003', 'sec_sx');
INSERT INTO `apply_info` VALUES ('AP004', 25, '考试', '2024-09-02 08:45:00', '未审核', NULL,0,'2023004', 'sec_jsj');

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building`  (
  `building_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '楼id',
  `building_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '楼名',
  PRIMARY KEY (`building_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building
-- ----------------------------
INSERT INTO `building` VALUES ('B1', '第一教学楼');
INSERT INTO `building` VALUES ('B2', '第二教学楼');
INSERT INTO `building` VALUES ('B3', '第三实验楼');

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS `classroom`;
CREATE TABLE `classroom`  (
  `room_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '教室编号',
  `room_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '教室类型',
  `room_capacity` int NULL DEFAULT NULL COMMENT '容量',
  `building_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '楼id',
  PRIMARY KEY (`room_num`) USING BTREE,
  INDEX `building_id`(`building_id` ASC) USING BTREE,
  CONSTRAINT `classroom_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classroom
-- ----------------------------
INSERT INTO `classroom` VALUES ('B1-101', '普通教室', 60, 'B1');
INSERT INTO `classroom` VALUES ('B1-202', '多媒体教室', 40, 'B1');
INSERT INTO `classroom` VALUES ('B2-301', '阶梯教室', 120, 'B2');
INSERT INTO `classroom` VALUES ('B3-105', '实验室', 30, 'B3');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classroom_manager
-- ----------------------------
INSERT INTO `classroom_manager` VALUES ('mgr_b1', 'mgr123', '13800138001', 'B1');
INSERT INTO `classroom_manager` VALUES ('mgr_b2', 'mgr456', '13900139001', 'B2');
INSERT INTO `classroom_manager` VALUES ('mgr_b3', 'mgr789', '13700137001', 'B3');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classroom_resource
-- ----------------------------
INSERT INTO `classroom_resource` VALUES ('RES601', '2024-09-02', '第3周', '星期一', '第一节', '已预订', 'B1-101', 'AP001');
INSERT INTO `classroom_resource` VALUES ('RES602', '2024-09-02', '第3周', '星期一', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES603', '2024-09-02', '第3周', '星期一', '第三节', '已预订', 'B1-202', 'AP002');
INSERT INTO `classroom_resource` VALUES ('RES604', '2024-09-02', '第3周', '星期一', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES605', '2024-09-02', '第3周', '星期一', '第五节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES606', '2024-09-02', '第3周', '星期一', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES607', '2024-09-02', '第3周', '星期一', '第七节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES608', '2024-09-02', '第3周', '星期一', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES609', '2024-09-03', '第3周', '星期二', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES610', '2024-09-03', '第3周', '星期二', '第二节', '已预订', 'B1-101', 'AP001');
INSERT INTO `classroom_resource` VALUES ('RES611', '2024-09-03', '第3周', '星期二', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES612', '2024-09-03', '第3周', '星期二', '第四节', '已预订', 'B1-202', 'AP002');
INSERT INTO `classroom_resource` VALUES ('RES613', '2024-09-03', '第3周', '星期二', '第五节', '已预订', 'B2-301', 'AP003');
INSERT INTO `classroom_resource` VALUES ('RES614', '2024-09-03', '第3周', '星期二', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES615', '2024-09-03', '第3周', '星期二', '第七节', '已预订', 'B3-105', 'AP004');
INSERT INTO `classroom_resource` VALUES ('RES616', '2024-09-03', '第3周', '星期二', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES617', '2024-09-04', '第3周', '星期三', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES618', '2024-09-04', '第3周', '星期三', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES619', '2024-09-04', '第3周', '星期三', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES620', '2024-09-04', '第3周', '星期三', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES621', '2024-09-04', '第3周', '星期三', '第五节', '已预订', 'B2-301', 'AP003');
INSERT INTO `classroom_resource` VALUES ('RES622', '2024-09-04', '第3周', '星期三', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES623', '2024-09-04', '第3周', '星期三', '第七节', '已预订', 'B3-105', 'AP004');
INSERT INTO `classroom_resource` VALUES ('RES624', '2024-09-04', '第3周', '星期三', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES625', '2024-09-05', '第3周', '星期四', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES626', '2024-09-05', '第3周', '星期四', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES627', '2024-09-05', '第3周', '星期四', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES628', '2024-09-05', '第3周', '星期四', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES629', '2024-09-05', '第3周', '星期四', '第五节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES630', '2024-09-05', '第3周', '星期四', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES631', '2024-09-05', '第3周', '星期四', '第七节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES632', '2024-09-05', '第3周', '星期四', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES633', '2024-09-06', '第3周', '星期五', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES634', '2024-09-06', '第3周', '星期五', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES635', '2024-09-06', '第3周', '星期五', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES636', '2024-09-06', '第3周', '星期五', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES637', '2024-09-06', '第3周', '星期五', '第五节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES638', '2024-09-06', '第3周', '星期五', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES639', '2024-09-06', '第3周', '星期五', '第七节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES640', '2024-09-06', '第3周', '星期五', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES641', '2024-09-09', '第4周', '星期一', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES642', '2024-09-09', '第4周', '星期一', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES643', '2024-09-09', '第4周', '星期一', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES644', '2024-09-09', '第4周', '星期一', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES645', '2024-09-09', '第4周', '星期一', '第五节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES646', '2024-09-09', '第4周', '星期一', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES647', '2024-09-09', '第4周', '星期一', '第七节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES648', '2024-09-09', '第4周', '星期一', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES649', '2024-09-10', '第4周', '星期二', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES650', '2024-09-10', '第4周', '星期二', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES651', '2024-09-10', '第4周', '星期二', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES652', '2024-09-10', '第4周', '星期二', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES653', '2024-09-10', '第4周', '星期二', '第五节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES654', '2024-09-10', '第4周', '星期二', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES655', '2024-09-10', '第4周', '星期二', '第七节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES656', '2024-09-10', '第4周', '星期二', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES657', '2024-09-11', '第4周', '星期三', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES658', '2024-09-11', '第4周', '星期三', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES659', '2024-09-11', '第4周', '星期三', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES660', '2024-09-11', '第4周', '星期三', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES661', '2024-09-11', '第4周', '星期三', '第五节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES662', '2024-09-11', '第4周', '星期三', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES663', '2024-09-11', '第4周', '星期三', '第七节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES664', '2024-09-11', '第4周', '星期三', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES665', '2024-09-12', '第4周', '星期四', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES666', '2024-09-12', '第4周', '星期四', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES667', '2024-09-12', '第4周', '星期四', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES668', '2024-09-12', '第4周', '星期四', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES669', '2024-09-12', '第4周', '星期四', '第五节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES670', '2024-09-12', '第4周', '星期四', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES671', '2024-09-12', '第4周', '星期四', '第七节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES672', '2024-09-12', '第4周', '星期四', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES673', '2024-09-13', '第4周', '星期五', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES674', '2024-09-13', '第4周', '星期五', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES675', '2024-09-13', '第4周', '星期五', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES676', '2024-09-13', '第4周', '星期五', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES677', '2024-09-13', '第4周', '星期五', '第五节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES678', '2024-09-13', '第4周', '星期五', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES679', '2024-09-13', '第4周', '星期五', '第七节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES680', '2024-09-13', '第4周', '星期五', '第八节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES681', '2024-09-16', '第5周', '星期一', '第一节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES682', '2024-09-16', '第5周', '星期一', '第二节', '空闲', 'B1-101', NULL);
INSERT INTO `classroom_resource` VALUES ('RES683', '2024-09-16', '第5周', '星期一', '第三节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES684', '2024-09-16', '第5周', '星期一', '第四节', '空闲', 'B1-202', NULL);
INSERT INTO `classroom_resource` VALUES ('RES685', '2024-09-16', '第5周', '星期一', '第五节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES686', '2024-09-16', '第5周', '星期一', '第六节', '空闲', 'B2-301', NULL);
INSERT INTO `classroom_resource` VALUES ('RES687', '2024-09-16', '第5周', '星期一', '第七节', '空闲', 'B3-105', NULL);
INSERT INTO `classroom_resource` VALUES ('RES688', '2024-09-16', '第5周', '星期一', '第八节', '空闲', 'B3-105', NULL);

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college`  (
  `college_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '学院编号',
  `college_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '学院名称',
  PRIMARY KEY (`college_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES ('JSJ', '计算机学院');
INSERT INTO `college` VALUES ('SX', '数学学院');
INSERT INTO `college` VALUES ('WX', '文学院');
INSERT INTO `college` VALUES ('YY', '外国语学院');

-- ----------------------------
-- Table structure for super_admin
-- ----------------------------
DROP TABLE IF EXISTS `super_admin`;
CREATE TABLE `super_admin`  (
  `account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '超级管理员账号',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '超级管理员密码',
  PRIMARY KEY (`account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of super_admin
-- ----------------------------
INSERT INTO `super_admin` VALUES ('root', 'root456');
INSERT INTO `super_admin` VALUES ('superadmin', 'admin123');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teach_secretary
-- ----------------------------
INSERT INTO `teach_secretary` VALUES ('sec_jsj', 'sec123', '张三', '020-88881111', 'JSJ');
INSERT INTO `teach_secretary` VALUES ('sec_sx', 'sec789', '王五', '020-88883333', 'SX');
INSERT INTO `teach_secretary` VALUES ('sec_wx', 'sec456', '李四', '020-88882222', 'WX');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('2023001', 'user123', '赵六', '13500135001', 'JSJ');
INSERT INTO `users` VALUES ('2023002', 'user456', '孙七', '13600136002', 'WX');
INSERT INTO `users` VALUES ('2023003', 'user789', '周八', '13400134003', 'SX');
INSERT INTO `users` VALUES ('2023004', 'user012', '吴九', '13300133004', 'JSJ');

-- ----------------------------
-- View structure for unapply_applications
-- ----------------------------
DROP VIEW IF EXISTS `unapply_applications`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `unapply_applications` AS select `apply_info`.`apply_id` AS `apply_id`,`apply_info`.`apply_purpose` AS `apply_purpose`,`apply_info`.`apply_book_time` AS `apply_book_time`,`users`.`user_name` AS `user_name` from (`apply_info` join `users`) where ((`apply_info`.`user_account` = `users`.`user_account`) and (`apply_info`.`apply_status` = '未审核'));

SET FOREIGN_KEY_CHECKS = 1;
