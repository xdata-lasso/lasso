-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests composite GROUP BY (start_station_id, start_station_name) vs single column GROUP BY.
-- Station ID 10 has 100 trips as 'Name1' and 100 trips as 'Name2' (Total ID=10 is 200, but each pair is 100).
-- Station Name 'SharedName' has 100 trips with ID=20 and 100 trips with ID=30 (Total Name='SharedName' is 200, but each pair is 100).
-- Reference query returns 0 rows.
INSERT INTO trip (id, start_station_id, start_station_name) VALUES
(1, 10, 'Name1'), (2, 10, 'Name1'), (3, 10, 'Name1'), (4, 10, 'Name1'), (5, 10, 'Name1'), (6, 10, 'Name1'), (7, 10, 'Name1'), (8, 10, 'Name1'), (9, 10, 'Name1'), (10, 10, 'Name1'),
(11, 10, 'Name1'), (12, 10, 'Name1'), (13, 10, 'Name1'), (14, 10, 'Name1'), (15, 10, 'Name1'), (16, 10, 'Name1'), (17, 10, 'Name1'), (18, 10, 'Name1'), (19, 10, 'Name1'), (20, 10, 'Name1'),
(21, 10, 'Name1'), (22, 10, 'Name1'), (23, 10, 'Name1'), (24, 10, 'Name1'), (25, 10, 'Name1'), (26, 10, 'Name1'), (27, 10, 'Name1'), (28, 10, 'Name1'), (29, 10, 'Name1'), (30, 10, 'Name1'),
(31, 10, 'Name1'), (32, 10, 'Name1'), (33, 10, 'Name1'), (34, 10, 'Name1'), (35, 10, 'Name1'), (36, 10, 'Name1'), (37, 10, 'Name1'), (38, 10, 'Name1'), (39, 10, 'Name1'), (40, 10, 'Name1'),
(41, 10, 'Name1'), (42, 10, 'Name1'), (43, 10, 'Name1'), (44, 10, 'Name1'), (45, 10, 'Name1'), (46, 10, 'Name1'), (47, 10, 'Name1'), (48, 10, 'Name1'), (49, 10, 'Name1'), (50, 10, 'Name1'),
(51, 10, 'Name1'), (52, 10, 'Name1'), (53, 10, 'Name1'), (54, 10, 'Name1'), (55, 10, 'Name1'), (56, 10, 'Name1'), (57, 10, 'Name1'), (58, 10, 'Name1'), (59, 10, 'Name1'), (60, 10, 'Name1'),
(61, 10, 'Name1'), (62, 10, 'Name1'), (63, 10, 'Name1'), (64, 10, 'Name1'), (65, 10, 'Name1'), (66, 10, 'Name1'), (67, 10, 'Name1'), (68, 10, 'Name1'), (69, 10, 'Name1'), (70, 10, 'Name1'),
(71, 10, 'Name1'), (72, 10, 'Name1'), (73, 10, 'Name1'), (74, 10, 'Name1'), (75, 10, 'Name1'), (76, 10, 'Name1'), (77, 10, 'Name1'), (78, 10, 'Name1'), (79, 10, 'Name1'), (80, 10, 'Name1'),
(81, 10, 'Name1'), (82, 10, 'Name1'), (83, 10, 'Name1'), (84, 10, 'Name1'), (85, 10, 'Name1'), (86, 10, 'Name1'), (87, 10, 'Name1'), (88, 10, 'Name1'), (89, 10, 'Name1'), (90, 10, 'Name1'),
(91, 10, 'Name1'), (92, 10, 'Name1'), (93, 10, 'Name1'), (94, 10, 'Name1'), (95, 10, 'Name1'), (96, 10, 'Name1'), (97, 10, 'Name1'), (98, 10, 'Name1'), (99, 10, 'Name1'), (100, 10, 'Name1'),
(101, 10, 'Name2'), (102, 10, 'Name2'), (103, 10, 'Name2'), (104, 10, 'Name2'), (105, 10, 'Name2'), (106, 10, 'Name2'), (107, 10, 'Name2'), (108, 10, 'Name2'), (109, 10, 'Name2'), (110, 10, 'Name2'),
(111, 10, 'Name2'), (112, 10, 'Name2'), (113, 10, 'Name2'), (114, 10, 'Name2'), (115, 10, 'Name2'), (116, 10, 'Name2'), (117, 10, 'Name2'), (118, 10, 'Name2'), (119, 10, 'Name2'), (120, 10, 'Name2'),
(121, 10, 'Name2'), (122, 10, 'Name2'), (123, 10, 'Name2'), (124, 10, 'Name2'), (125, 10, 'Name2'), (126, 10, 'Name2'), (127, 10, 'Name2'), (128, 10, 'Name2'), (129, 10, 'Name2'), (130, 10, 'Name2'),
(131, 10, 'Name2'), (132, 10, 'Name2'), (133, 10, 'Name2'), (134, 10, 'Name2'), (135, 10, 'Name2'), (136, 10, 'Name2'), (137, 10, 'Name2'), (138, 10, 'Name2'), (139, 10, 'Name2'), (140, 10, 'Name2'),
(141, 10, 'Name2'), (142, 10, 'Name2'), (143, 10, 'Name2'), (144, 10, 'Name2'), (145, 10, 'Name2'), (146, 10, 'Name2'), (147, 10, 'Name2'), (148, 10, 'Name2'), (149, 10, 'Name2'), (150, 10, 'Name2'),
(151, 10, 'Name2'), (152, 10, 'Name2'), (153, 10, 'Name2'), (154, 10, 'Name2'), (155, 10, 'Name2'), (156, 10, 'Name2'), (157, 10, 'Name2'), (158, 10, 'Name2'), (159, 10, 'Name2'), (160, 10, 'Name2'),
(161, 10, 'Name2'), (162, 10, 'Name2'), (163, 10, 'Name2'), (164, 10, 'Name2'), (165, 10, 'Name2'), (166, 10, 'Name2'), (167, 10, 'Name2'), (168, 10, 'Name2'), (169, 10, 'Name2'), (170, 10, 'Name2'),
(171, 10, 'Name2'), (172, 10, 'Name2'), (173, 10, 'Name2'), (174, 10, 'Name2'), (175, 10, 'Name2'), (176, 10, 'Name2'), (177, 10, 'Name2'), (178, 10, 'Name2'), (179, 10, 'Name2'), (180, 10, 'Name2'),
(181, 10, 'Name2'), (182, 10, 'Name2'), (183, 10, 'Name2'), (184, 10, 'Name2'), (185, 10, 'Name2'), (186, 10, 'Name2'), (187, 10, 'Name2'), (188, 10, 'Name2'), (189, 10, 'Name2'), (190, 10, 'Name2'),
(191, 10, 'Name2'), (192, 10, 'Name2'), (193, 10, 'Name2'), (194, 10, 'Name2'), (195, 10, 'Name2'), (196, 10, 'Name2'), (197, 10, 'Name2'), (198, 10, 'Name2'), (199, 10, 'Name2'), (200, 10, 'Name2'),
(201, 20, 'SharedName'), (202, 20, 'SharedName'), (203, 20, 'SharedName'), (204, 20, 'SharedName'), (205, 20, 'SharedName'), (206, 20, 'SharedName'), (207, 20, 'SharedName'), (208, 20, 'SharedName'), (209, 20, 'SharedName'), (210, 20, 'SharedName'),
(211, 20, 'SharedName'), (212, 20, 'SharedName'), (213, 20, 'SharedName'), (214, 20, 'SharedName'), (215, 20, 'SharedName'), (216, 20, 'SharedName'), (217, 20, 'SharedName'), (218, 20, 'SharedName'), (219, 20, 'SharedName'), (220, 20, 'SharedName'),
(221, 20, 'SharedName'), (222, 20, 'SharedName'), (223, 20, 'SharedName'), (224, 20, 'SharedName'), (225, 20, 'SharedName'), (226, 20, 'SharedName'), (227, 20, 'SharedName'), (228, 20, 'SharedName'), (229, 20, 'SharedName'), (230, 20, 'SharedName'),
(231, 20, 'SharedName'), (232, 20, 'SharedName'), (233, 20, 'SharedName'), (234, 20, 'SharedName'), (235, 20, 'SharedName'), (236, 20, 'SharedName'), (237, 20, 'SharedName'), (238, 20, 'SharedName'), (239, 20, 'SharedName'), (240, 20, 'SharedName'),
(241, 20, 'SharedName'), (242, 20, 'SharedName'), (243, 20, 'SharedName'), (244, 20, 'SharedName'), (245, 20, 'SharedName'), (246, 20, 'SharedName'), (247, 20, 'SharedName'), (248, 20, 'SharedName'), (249, 20, 'SharedName'), (250, 20, 'SharedName'),
(251, 20, 'SharedName'), (252, 20, 'SharedName'), (253, 20, 'SharedName'), (254, 20, 'SharedName'), (255, 20, 'SharedName'), (256, 20, 'SharedName'), (257, 20, 'SharedName'), (258, 20, 'SharedName'), (259, 20, 'SharedName'), (260, 20, 'SharedName'),
(261, 20, 'SharedName'), (262, 20, 'SharedName'), (263, 20, 'SharedName'), (264, 20, 'SharedName'), (265, 20, 'SharedName'), (266, 20, 'SharedName'), (267, 20, 'SharedName'), (268, 20, 'SharedName'), (269, 20, 'SharedName'), (270, 20, 'SharedName'),
(271, 20, 'SharedName'), (272, 20, 'SharedName'), (273, 20, 'SharedName'), (274, 20, 'SharedName'), (275, 20, 'SharedName'), (276, 20, 'SharedName'), (277, 20, 'SharedName'), (278, 20, 'SharedName'), (279, 20, 'SharedName'), (280, 20, 'SharedName'),
(281, 20, 'SharedName'), (282, 20, 'SharedName'), (283, 20, 'SharedName'), (284, 20, 'SharedName'), (285, 20, 'SharedName'), (286, 20, 'SharedName'), (287, 20, 'SharedName'), (288, 20, 'SharedName'), (289, 20, 'SharedName'), (290, 20, 'SharedName'),
(291, 20, 'SharedName'), (292, 20, 'SharedName'), (293, 20, 'SharedName'), (294, 20, 'SharedName'), (295, 20, 'SharedName'), (296, 20, 'SharedName'), (297, 20, 'SharedName'), (298, 20, 'SharedName'), (299, 20, 'SharedName'), (300, 20, 'SharedName'),
(301, 30, 'SharedName'), (302, 30, 'SharedName'), (303, 30, 'SharedName'), (304, 30, 'SharedName'), (305, 30, 'SharedName'), (306, 30, 'SharedName'), (307, 30, 'SharedName'), (308, 30, 'SharedName'), (309, 30, 'SharedName'), (310, 30, 'SharedName'),
(311, 30, 'SharedName'), (312, 30, 'SharedName'), (313, 30, 'SharedName'), (314, 30, 'SharedName'), (315, 30, 'SharedName'), (316, 30, 'SharedName'), (317, 30, 'SharedName'), (318, 30, 'SharedName'), (319, 30, 'SharedName'), (320, 30, 'SharedName'),
(321, 30, 'SharedName'), (322, 30, 'SharedName'), (323, 30, 'SharedName'), (324, 30, 'SharedName'), (325, 30, 'SharedName'), (326, 30, 'SharedName'), (327, 30, 'SharedName'), (328, 30, 'SharedName'), (329, 30, 'SharedName'), (330, 30, 'SharedName'),
(331, 30, 'SharedName'), (332, 30, 'SharedName'), (333, 30, 'SharedName'), (334, 30, 'SharedName'), (335, 30, 'SharedName'), (336, 30, 'SharedName'), (337, 30, 'SharedName'), (338, 30, 'SharedName'), (339, 30, 'SharedName'), (340, 30, 'SharedName'),
(341, 30, 'SharedName'), (342, 30, 'SharedName'), (343, 30, 'SharedName'), (344, 30, 'SharedName'), (345, 30, 'SharedName'), (346, 30, 'SharedName'), (347, 30, 'SharedName'), (348, 30, 'SharedName'), (349, 30, 'SharedName'), (350, 30, 'SharedName'),
(351, 30, 'SharedName'), (352, 30, 'SharedName'), (353, 30, 'SharedName'), (354, 30, 'SharedName'), (355, 30, 'SharedName'), (356, 30, 'SharedName'), (357, 30, 'SharedName'), (358, 30, 'SharedName'), (359, 30, 'SharedName'), (360, 30, 'SharedName'),
(361, 30, 'SharedName'), (362, 30, 'SharedName'), (363, 30, 'SharedName'), (364, 30, 'SharedName'), (365, 30, 'SharedName'), (366, 30, 'SharedName'), (367, 30, 'SharedName'), (368, 30, 'SharedName'), (369, 30, 'SharedName'), (370, 30, 'SharedName'),
(371, 30, 'SharedName'), (372, 30, 'SharedName'), (373, 30, 'SharedName'), (374, 30, 'SharedName'), (375, 30, 'SharedName'), (376, 30, 'SharedName'), (377, 30, 'SharedName'), (378, 30, 'SharedName'), (379, 30, 'SharedName'), (380, 30, 'SharedName'),
(381, 30, 'SharedName'), (382, 30, 'SharedName'), (383, 30, 'SharedName'), (384, 30, 'SharedName'), (385, 30, 'SharedName'), (386, 30, 'SharedName'), (387, 30, 'SharedName'), (388, 30, 'SharedName'), (389, 30, 'SharedName'), (390, 30, 'SharedName'),
(391, 30, 'SharedName'), (392, 30, 'SharedName'), (393, 30, 'SharedName'), (394, 30, 'SharedName'), (395, 30, 'SharedName'), (396, 30, 'SharedName'), (397, 30, 'SharedName'), (398, 30, 'SharedName'), (399, 30, 'SharedName'), (400, 30, 'SharedName');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT start_station_id, start_station_name FROM (SELECT start_station_id, start_station_name, COUNT(*) AS n FROM trip GROUP BY start_station_id, start_station_name) WHERE (n >= 200) ORDER BY start_station_id, start_station_name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT start_station_id, start_station_name FROM trip GROUP BY start_station_name HAVING COUNT(*) >= 200;

/*
Prediction Result:
(20, 'SharedName')
*/