-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: dorm --
INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (1, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (2, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (3, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (4, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (5, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (6, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (7, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (8, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (9, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (10, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (11, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (12, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (13, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (14, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (15, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (16, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (17, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (18, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (19, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (20, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (21, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (22, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (23, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (24, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (25, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (26, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (27, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (28, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (29, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (30, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (31, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (32, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (33, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (34, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (35, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (36, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (37, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (38, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (39, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (40, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (41, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (42, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (43, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (44, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (45, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (46, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (47, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (48, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (49, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (50, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (51, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (52, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (53, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (54, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483594, 'dor_6d3505', -1022641847, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483593, 'dor_6d3505', -1726781632, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483592, 'dor_6d3505', 1, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483591, 'dor_6d3505', 1, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483590, 'dor_6d3505', 1, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483589, 'dor_6d3505', 1, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483588, 'dor_6d3505', 1, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483587, 'dor_6d3505', 1, NULL);

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483586, 'dor_6d3505', NULL, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (-2147483585, 'dor_6d3505', NULL, '7');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (55, 'value', NULL, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (56, 'value', NULL, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (57, 'value', NULL, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (58, 'value', NULL, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (59, 'value', NULL, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (60, 'value', NULL, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (61, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (62, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (63, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (64, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (65, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (66, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (67, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (68, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (69, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (70, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (71, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (72, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (73, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (74, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (75, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (76, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (77, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (78, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (79, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (80, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (81, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (82, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (83, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (84, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (85, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (86, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (87, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (88, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (89, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (90, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (91, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (92, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (93, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (94, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (95, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (96, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (97, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (98, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (99, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (100, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (101, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (102, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (103, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (104, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (105, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (106, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (107, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (108, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (109, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (110, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (111, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (112, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (113, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (114, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (115, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (116, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (117, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (118, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (119, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (120, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (121, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (122, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (123, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (124, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (125, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (126, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (127, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (128, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (129, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (130, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (131, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (132, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (133, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (134, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (135, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (136, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (137, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (138, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (139, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (140, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (141, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (142, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (143, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (144, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (145, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (146, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (147, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (148, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (149, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (150, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (151, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (152, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (153, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (154, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (155, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (156, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (157, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (158, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (159, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (160, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (161, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (162, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (163, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (164, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (165, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (166, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (167, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (168, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (169, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (170, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (171, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (172, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (173, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (174, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (175, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (176, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (177, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (178, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (179, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (180, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (181, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (182, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (183, 'value', 1, 'dor_d4a3d3');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (184, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (185, 'value', 1, 'dor_477e03');

INSERT INTO "dorm" ("dormid", "dorm_name", "student_capacity", "gender") VALUES (186, 'value', 1, 'dor_477e03');

-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'lhs_c592fc', 'lhs_78aef9', 1, 'lhs_73ce08', 1, 1, 'lhs_050bb8');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (3, 'lhs_c592fc', 'lhs_78aef9', 1, 'lhs_73ce08', 1, 1, 'lhs_050bb8');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (2, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

-- Inserting into table: lives_in --
INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 2, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 2, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 2, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 2, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, NULL);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);

INSERT INTO "lives_in" ("dormid", "stuid", "room_number") VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n_distinct" AS "count___" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."room_number" AS "room_number", "LHS"."gender" AS "gender", "LHS"."student_capacity" AS "student_capacity", "LHS"."n_distinct" AS "n_distinct" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."dormid" AS "dormid", "LHS"."room_number" AS "room_number", "RHS"."gender" AS "gender", "RHS"."student_capacity" AS "student_capacity", "RHS"."n_distinct" AS "n_distinct" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."dormid" AS "dormid", "RHS"."room_number" AS "room_number" FROM "student" AS "LHS" INNER JOIN "lives_in" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) AS "LHS" CROSS JOIN (SELECT "gender", "student_capacity", COUNT(DISTINCT "gender") AS "n_distinct" FROM "dorm" GROUP BY "gender", "student_capacity") AS "RHS") AS "LHS" INNER JOIN (SELECT * FROM (SELECT "gender", "student_capacity", COUNT(DISTINCT "gender") AS "n_distinct" FROM "dorm" GROUP BY "gender", "student_capacity") WHERE ("gender" <> 'M')) AS RHS ON (LHS.gender = RHS.gender AND LHS.student_capacity = RHS.student_capacity AND LHS.n_distinct = RHS.n_distinct)) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM student AS T1 JOIN lives_in AS T2 ON T1.stuid = T2.stuid JOIN dorm AS T3 ON T3.dormid = T2.dormid WHERE T3.gender = 'M';

/*
Prediction Result:
(0,)
*/