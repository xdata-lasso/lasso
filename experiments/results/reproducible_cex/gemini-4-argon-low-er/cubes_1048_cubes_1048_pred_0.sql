-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO trip (id, start_station_id, start_station_name) VALUES
(1, 1, 'A'), (2, 1, 'A'), (3, 1, 'A'), (4, 1, 'A'), (5, 1, 'A'), (6, 1, 'A'), (7, 1, 'A'), (8, 1, 'A'), (9, 1, 'A'), (10, 1, 'A'),
(11, 1, 'A'), (12, 1, 'A'), (13, 1, 'A'), (14, 1, 'A'), (15, 1, 'A'), (16, 1, 'A'), (17, 1, 'A'), (18, 1, 'A'), (19, 1, 'A'), (20, 1, 'A'),
(21, 1, 'A'), (22, 1, 'A'), (23, 1, 'A'), (24, 1, 'A'), (25, 1, 'A'), (26, 1, 'A'), (27, 1, 'A'), (28, 1, 'A'), (29, 1, 'A'), (30, 1, 'A'),
(31, 1, 'A'), (32, 1, 'A'), (33, 1, 'A'), (34, 1, 'A'), (35, 1, 'A'), (36, 1, 'A'), (37, 1, 'A'), (38, 1, 'A'), (39, 1, 'A'), (40, 1, 'A'),
(41, 1, 'A'), (42, 1, 'A'), (43, 1, 'A'), (44, 1, 'A'), (45, 1, 'A'), (46, 1, 'A'), (47, 1, 'A'), (48, 1, 'A'), (49, 1, 'A'), (50, 1, 'A'),
(51, 1, 'A'), (52, 1, 'A'), (53, 1, 'A'), (54, 1, 'A'), (55, 1, 'A'), (56, 1, 'A'), (57, 1, 'A'), (58, 1, 'A'), (59, 1, 'A'), (60, 1, 'A'),
(61, 1, 'A'), (62, 1, 'A'), (63, 1, 'A'), (64, 1, 'A'), (65, 1, 'A'), (66, 1, 'A'), (67, 1, 'A'), (68, 1, 'A'), (69, 1, 'A'), (70, 1, 'A'),
(71, 1, 'A'), (72, 1, 'A'), (73, 1, 'A'), (74, 1, 'A'), (75, 1, 'A'), (76, 1, 'A'), (77, 1, 'A'), (78, 1, 'A'), (79, 1, 'A'), (80, 1, 'A'),
(81, 1, 'A'), (82, 1, 'A'), (83, 1, 'A'), (84, 1, 'A'), (85, 1, 'A'), (86, 1, 'A'), (87, 1, 'A'), (88, 1, 'A'), (89, 1, 'A'), (90, 1, 'A'),
(91, 1, 'A'), (92, 1, 'A'), (93, 1, 'A'), (94, 1, 'A'), (95, 1, 'A'), (96, 1, 'A'), (97, 1, 'A'), (98, 1, 'A'), (99, 1, 'A'), (100, 1, 'A'),
(101, 2, 'A'), (102, 2, 'A'), (103, 2, 'A'), (104, 2, 'A'), (105, 2, 'A'), (106, 2, 'A'), (107, 2, 'A'), (108, 2, 'A'), (109, 2, 'A'), (110, 2, 'A'),
(111, 2, 'A'), (112, 2, 'A'), (113, 2, 'A'), (114, 2, 'A'), (115, 2, 'A'), (116, 2, 'A'), (117, 2, 'A'), (118, 2, 'A'), (119, 2, 'A'), (120, 2, 'A'),
(121, 2, 'A'), (122, 2, 'A'), (123, 2, 'A'), (124, 2, 'A'), (125, 2, 'A'), (126, 2, 'A'), (127, 2, 'A'), (128, 2, 'A'), (129, 2, 'A'), (130, 2, 'A'),
(131, 2, 'A'), (132, 2, 'A'), (133, 2, 'A'), (134, 2, 'A'), (135, 2, 'A'), (136, 2, 'A'), (137, 2, 'A'), (138, 2, 'A'), (139, 2, 'A'), (140, 2, 'A'),
(141, 2, 'A'), (142, 2, 'A'), (143, 2, 'A'), (144, 2, 'A'), (145, 2, 'A'), (146, 2, 'A'), (147, 2, 'A'), (148, 2, 'A'), (149, 2, 'A'), (150, 2, 'A'),
(151, 2, 'A'), (152, 2, 'A'), (153, 2, 'A'), (154, 2, 'A'), (155, 2, 'A'), (156, 2, 'A'), (157, 2, 'A'), (158, 2, 'A'), (159, 2, 'A'), (160, 2, 'A'),
(161, 2, 'A'), (162, 2, 'A'), (163, 2, 'A'), (164, 2, 'A'), (165, 2, 'A'), (166, 2, 'A'), (167, 2, 'A'), (168, 2, 'A'), (169, 2, 'A'), (170, 2, 'A'),
(171, 2, 'A'), (172, 2, 'A'), (173, 2, 'A'), (174, 2, 'A'), (175, 2, 'A'), (176, 2, 'A'), (177, 2, 'A'), (178, 2, 'A'), (179, 2, 'A'), (180, 2, 'A'),
(181, 2, 'A'), (182, 2, 'A'), (183, 2, 'A'), (184, 2, 'A'), (185, 2, 'A'), (186, 2, 'A'), (187, 2, 'A'), (188, 2, 'A'), (189, 2, 'A'), (190, 2, 'A'),
(191, 2, 'A'), (192, 2, 'A'), (193, 2, 'A'), (194, 2, 'A'), (195, 2, 'A'), (196, 2, 'A'), (197, 2, 'A'), (198, 2, 'A'), (199, 2, 'A'), (200, 2, 'A');
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
(1, 'A')
*/