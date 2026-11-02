-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: trip --
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483648, 1, '5k5swwqcgs', '9n8', 1610062532, 'pgu7vfe4', 'hria2ypuzhs', 700293388, 906324270, 'b', 1072996612);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (1, 1, 'lhs_76b15d', 'lhs_3cc910', 1, 'lhs_7253f6', 'lhs_86db08', 1, 1, 'lhs_3bba66', 1);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483646, 1, 'luhvdltti', 'bnp', 1236688122, 'dpos', 'ie5', -1209887326, -1399556171, 'a9000t5c4eci', 1149850321);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483645, 1, 'e', '76nium52', -443340271, 'uo4nrqrofqy', '5s5b', 2107872094, 882961052, '2eutliqa11r', 2137741668);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483644, -525979501, NULL, 'oo3o9hl72kl', -305670381, 'i7z', 'au2dwy', -953437896, -1097120355, '78d99r', -1362461264);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483643, 1, NULL, 'l0b4y', -1116181514, 'i2rkf', 'vqx58pz0f', 176555546, -1937207087, 'vy9uxj4', -1612443122);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483642, 1, NULL, 'd', -736979194, 'h2gn', 'q', -664193365, -1070063173, 'x5hncprjtu0', -1898531797);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483641, -1748371085, 'q8', 'n2f3dqv0gcb9', 172461907, 'k3zbily', 'kn6vc', 1784916884, 37673509, 'h0f8jswwlq', NULL);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483640, 1, 'xb72fxa7r', 'fdrz16n', -1496556994, 'i', 'dh5ogrgj', -458359144, 600440952, 'f', NULL);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483639, 1, 'og', 'itsj3', -491938169, '1q43', '1jh3den', 357330522, -683007527, 'x', NULL);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483638, -1762140823, 'w1of77pz', NULL, 87529806, 'ctdctmfg62g0', '5q8qdj', -1139855872, -288338724, '2278', 2004147439);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483637, 1, 'tjpttg', NULL, -2033879835, 'u5zi', '6c4bfkfo', -1950324754, 2115816682, '7z2zezjo7wg', 1248858185);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483636, 1, '5', NULL, -526612570, 'cmr0oz', 'dgj5i', -176606723, -15162884, 'pim5', -1125548818);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483635, 1497321728, '4gth2mnaj', 'la3', NULL, 'okv8uttmu2', 'e578', 1908593332, 697257217, '7zzbe8y', -705922211);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483634, 1, 'v42q7sx58b4p', 'aus3', NULL, 'u', 'mkrpdj', 1105964624, -663234145, 'h', 101754718);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483633, 1, 'a9n0jxfo', 'ws', NULL, 'do2zobb', 'q0k32od', -613916489, 2061558815, '5amsorlwyngc', -323362455);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483632, 453340472, '9erhizgk1yoe', 'o6l0hdt', -795975227, 'xuzkb52', 'gwnlas6', NULL, -2076274980, 'ow', -1589605308);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483631, 1, 'z5nxih6', '2q2xlyoto', 1774679448, 'oaawg96aq', '0', NULL, -850941333, 'indz39tajz', 261633665);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483630, 1, '8', '5wcg', -794767771, 'c', '3tdu6bd0w960', NULL, 740386991, 'xw1rxe9', -505019168);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483629, NULL, '7qk', '162nh55y3d', 440797047, 'vu', '6dza35r', 2072023304, 789756515, '18ri', 1510892261);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483628, 1, 'y0', '8ftp6ewtqx', 2013745856, 'b', 'mzn2mfx', 1243701948, -156175571, '6sto', -285085577);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483627, 1, '8sh', 'knzys7dy', -531932574, 'jmgjach', 'qta8y3a17', -735270562, 614314115, 'ma', -499203870);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483626, 1509621238, 'dpuap', '6rntdqrhm', 555368535, NULL, 'ic7', 899787662, 594760660, 'np490xdm', 1996699977);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483625, 1, 'tgelc', 'qb9i9f', -788896327, NULL, 'q1q', -796609690, -1459013972, 'yhb08hlst1pq', 1980131681);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483624, 1, 'iztv', '6', -1304516770, NULL, 'z78', -2128972904, -1043357093, 'd8ftb8', 1183069552);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483623, -1057355067, 'e6bje', 'uuwsj8kjh8', -55270062, 'xlvr', NULL, 1205111943, -459075802, 'aqt', -1218774640);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483622, 1, 'gc8s3b7v88k', 'dmdbdh', 313797011, '7nxar50h', NULL, 460471995, -1515201134, 'n', 1195320303);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483621, 1, 'dpunmw', 'wx', -1040088060, 'awk', NULL, 558684943, -120625031, 'dqtsmg97', -2098439423);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483620, -459764012, '20pj', 'ddlysu6ip', -1664440372, 'u2g', 'r31', -717865822, NULL, 'q51oa2sb3u', 1388661799);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483619, 1, '1pa', 'cvwnyq', -1005394301, 'uirlrpouit', '63xyfvmjwpp', 1913338832, NULL, '3', 1893953818);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483618, 1, '0ju', '0h3r133ir1ax', -485095266, 'hpl2i9esap', 'pgckqwtsr', 987928936, NULL, '6qje', 889799750);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483617, -860028884, '1d2nzg3rjk', 'ns47j2', -1517668312, '8dccy3vjwq49', 'yrnxs6dvdx', -1900450199, -232312083, NULL, 1805923837);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483616, 1, 'plj9fj', 'uun7k1', -251621840, 'y1ogyv1rgeza', 'xc1clupgly', 139907579, 914471233, NULL, -1813651479);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483615, 1, 'pe0', '19cy7od033d', -1665891229, 'vnhed', '9lqv26u3', -169055351, -894726713, NULL, -1089715864);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM (SELECT LHS.id AS id, LHS.duration AS duration, LHS.start_date AS start_date, LHS.start_station_name AS start_station_name, LHS.start_station_id AS start_station_id, LHS.end_date AS end_date, LHS.end_station_name AS end_station_name, LHS.end_station_id AS end_station_id, LHS.bike_id AS bike_id, LHS.subscription_type AS subscription_type, LHS.zip_code AS zip_code FROM trip AS LHS INNER JOIN (SELECT MIN(duration) AS duration FROM trip) AS RHS ON (LHS.duration = RHS.duration)) ORDER BY id;

/*
Gold Result:
(-2147483638,)
*/

-- Prediction Query
SELECT id FROM trip ORDER BY duration, trip.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-2147483629,)
*/