-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (1, 'SJ Station 1', 37.3297, -121.9017, 0, 'San Jose', '2013-08-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (2, 'SJ Station 1', 37.3306, -121.8889, 0, 'San Jose', '2013-08-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (3, NULL, 37.3339, -121.8949, NULL, 'San Jose', NULL);
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (4, NULL, 37.3314, -121.8932, NULL, 'San Jose', NULL);
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (5, 'SJ Station 5', 37.3367, -121.8940, 0, 'San Jose', '2013-08-05');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (6, 'SJ Station 6', 37.3328, -121.8838, 0, 'San Jose', '2013-08-06');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (7, 'SJ Station 7', 37.3301, -121.8858, 0, 'San Jose', '2013-08-07');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (8, 'SJ Station 8', 37.3487, -121.8947, 0, 'San Jose', '2013-08-08');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (9, 'SJ Station 9', 37.3373, -121.8869, 0, 'San Jose', '2013-08-09');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (10, 'SJ Station 10', 37.3358, -121.8856, 0, 'San Jose', '2013-08-10');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (11, 'SJ Station 11', 37.3322, -121.8901, 0, 'San Jose', '2013-08-11');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (12, 'SJ Station 12', 37.3341, -121.8912, 0, 'San Jose', '2013-08-12');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (13, 'SJ Station 13', 37.3351, -121.8923, 0, 'San Jose', '2013-08-13');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (14, 'SJ Station 14', 37.3361, -121.8934, 0, 'San Jose', '2013-08-14');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (15, 'SJ Station 15', 37.3371, -121.8945, 0, 'San Jose', '2013-08-15');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (16, 'SJ Station 16', 37.3381, -121.8956, 1, 'San Jose', '2013-08-16');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (17, 'SJ Station 17', 37.3391, -121.8967, 1, 'San Jose', '2013-08-17');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (18, 'MV Station 1', 37.3892, -122.0839, 0, 'Mountain View', '2013-08-18');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (19, 'MV Station 2', 37.3943, -122.0767, 0, 'Mountain View', '2013-08-19');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (20, 'MV Station 3', 37.4069, -122.1067, 0, 'Mountain View', '2013-08-20');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (21, 'MV Station 4', 37.3902, -122.0665, 0, 'Mountain View', '2013-08-21');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (22, 'MV Station 5', 37.3859, -122.0836, 0, 'Mountain View', '2013-08-22');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (23, 'MV Station 6', 37.3953, -122.0524, 0, 'Mountain View', '2013-08-23');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (24, 'MV Station 7', 37.4002, -122.0990, 0, 'Mountain View', '2013-08-24');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (25, 'MV Station 8', 37.3911, -122.0811, 0, 'Mountain View', '2013-08-25');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (26, 'MV Station 9', 37.3922, -122.0822, 0, 'Mountain View', '2013-08-26');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (27, 'MV Station 10', 37.3933, -122.0833, 0, 'Mountain View', '2013-08-27');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (28, 'MV Station 11', 37.3944, -122.0844, 0, 'Mountain View', '2013-08-28');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (29, 'MV Station 12', 37.3955, -122.0855, 0, 'Mountain View', '2013-08-29');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (30, 'MV Station 13', 37.3966, -122.0866, 0, 'Mountain View', '2013-08-30');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (31, 'MV Station 14', 37.3977, -122.0877, 0, 'Mountain View', '2013-08-31');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (32, 'MV Station 15', 37.3988, -122.0888, 0, 'Mountain View', '2013-09-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (33, 'MV Station 16', 37.3999, -122.0899, 0, 'Mountain View', '2013-09-02');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (34, 'SF Station 1', 37.7897, -122.4014, 15, 'San Francisco', '2013-09-03');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (35, 'SF Station 2', 37.7950, -122.3999, 15, 'San Francisco', '2013-09-04');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (36, 'SF Station 3', 37.7914, -122.3910, 15, 'San Francisco', '2013-09-05');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (37, 'SF Station 4', 37.7985, -122.4072, 15, 'San Francisco', '2013-09-06');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (38, 'SF Station 5', 37.7941, -122.3944, 15, 'San Francisco', '2013-09-07');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (39, 'SF Station 6', 37.7869, -122.4050, 15, 'San Francisco', '2013-09-08');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (40, 'SF Station 7', 37.7817, -122.4119, 15, 'San Francisco', '2013-09-09');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (41, 'SF Station 8', 37.7766, -122.4173, 15, 'San Francisco', '2013-09-10');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (42, 'SF Station 9', 37.7889, -122.4034, 15, 'San Francisco', '2013-09-11');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (43, 'SF Station 10', 37.7999, -122.3985, 15, 'San Francisco', '2013-09-12');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (44, 'SF Station 11', 37.7953, -122.4047, 15, 'San Francisco', '2013-09-13');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (45, 'SF Station 12', 37.7838, -122.4084, 15, 'San Francisco', '2013-09-14');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (46, 'SF Station 13', 37.7805, -122.3902, 15, 'San Francisco', '2013-09-15');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (47, 'SF Station 14', 37.7748, -122.4189, 15, 'San Francisco', '2013-09-16');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (48, 'SF Station 15', 37.7710, -122.4027, 15, 'San Francisco', '2013-09-17');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (49, 'SF Station 16', 37.7852, -122.3962, 15, 'San Francisco', '2013-09-18');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (50, 'SF Station 17', 37.7871, -122.3988, 15, 'San Francisco', '2013-09-19');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (51, 'SF Station 18', 37.7922, -122.3970, 15, 'San Francisco', '2013-09-20');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (52, 'PA Station 1', 37.4439, -122.1647, 25, 'Palo Alto', '2013-09-21');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (53, 'PA Station 2', 37.4445, -122.1630, 25, 'Palo Alto', '2013-09-22');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (54, 'PA Station 3', 37.4290, -122.1428, 25, 'Palo Alto', '2013-09-23');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (55, 'PA Station 4', 37.4256, -122.1454, 25, 'Palo Alto', '2013-09-24');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (56, 'PA Station 5', 37.4485, -122.1595, 25, 'Palo Alto', '2013-09-25');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (57, 'PA Station 6', 37.4411, -122.1611, 25, 'Palo Alto', '2013-09-26');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (58, 'PA Station 7', 37.4422, -122.1622, 25, 'Palo Alto', '2013-09-27');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (59, 'PA Station 8', 37.4433, -122.1633, 25, 'Palo Alto', '2013-09-28');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (60, 'PA Station 9', 37.4444, -122.1644, 25, 'Palo Alto', '2013-09-29');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (61, 'PA Station 10', 37.4455, -122.1655, 25, 'Palo Alto', '2013-09-30');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (62, 'PA Station 11', 37.4466, -122.1666, 25, 'Palo Alto', '2013-10-01');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (63, 'PA Station 12', 37.4477, -122.1677, 25, 'Palo Alto', '2013-10-02');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (64, 'PA Station 13', 37.4488, -122.1688, 25, 'Palo Alto', '2013-10-03');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (65, 'PA Station 14', 37.4499, -122.1699, 25, 'Palo Alto', '2013-10-04');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (66, 'PA Station 15', 37.4500, -122.1700, 25, 'Palo Alto', '2013-10-05');
INSERT INTO station (id, name, lat, long, dock_count, city, installation_date) VALUES (67, 'RC Station 1', 37.4860, -122.2320, 100, 'Redwood City', '2013-10-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city, n AS count___ FROM (SELECT city, COUNT(*) AS n FROM station GROUP BY city) WHERE (n > 15) ORDER BY city, count___ NULLS LAST;

/*
Gold Result:
('Mountain View', 16)
('San Francisco', 18)
('San Jose', 17)
*/

-- Prediction Query
SELECT city, COUNT(*) FROM station GROUP BY city HAVING COUNT(*) >= 15;

/*
Prediction Result:
('Mountain View', 16)
('Palo Alto', 15)
('San Francisco', 18)
('San Jose', 17)
*/