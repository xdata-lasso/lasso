-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: station --
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 557.512061, -1980249628, 'sta_518e72', 'gu7v');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483647, 'e4', 779.409124, 640.719621, 1160656988, 'sta_518e72', 'ia2yp');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483646, 'uzhsrwbbp6lu', 737.440743, 334.878198, -1910425938, 'sta_518e72', 'tilbn');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483645, 'rmdp', 227.766936, 971.82669, -1576219117, 'sta_518e72', '5u');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483644, 'w6kl', 83.204633, 5.585347, 1620389964, 'sta_518e72', '00t5c4ecigc');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483643, 'e376nium52', 816.814398, 396.776796, 757448742, 'sta_518e72', '4nrq');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483642, 'rofqyp5s5b', 22.720462, 990.777211, 882961052, 'sta_518e72', '2eutliqa11r');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483641, 'ytoo3o9', 111.926013, 731.301441, 1178636309, 'sta_518e72', 'ex1');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483640, 'ji7zwau2', 920.013763, 689.091906, 364869063, 'sta_518e72', 'q13py');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483639, '78d99r', 182.777264, 943.791649, -904834265, 'sta_518e72', 'b4yp5qi');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483638, 'rkf9vqx5', 541.393553, 235.518744, 1836127587, 'sta_518e72', 'f8jegd2');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483637, 'vy9uxj4', 124.573829, 22.63964, -736979194, 'sta_518e72', 'h2gn');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483636, 'q', 345.35543, 250.856497, 555413010, 'sta_518e72', '5hncprjtu0d');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483635, '79fjgq8', 915.268032, 207.767266, -1762857309, 'sta_518e72', 'dqv0gcb98ozk');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483634, 'zbilyrkn', 692.775559, 339.789525, 1784916884, 'sta_518e72', 'ah0f8jsww');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (2, 'q7x', 21.129657, 525.144763, -541746689, 'sta_518e72', '7ryfdrz16n');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (3, 'jja', 128.858335, 498.231061, -1625552518, 'sta_518e72', 'grgj');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483633, '8', 740.059813, 388.212083, -458359144, 'sta_518e72', '1afgogritsj');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483630, 'ayxp1q43', 787.642728, 947.945777, 518609210, 'sta_518e72', '3d');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483629, 'n8', 596.764785, 46.611179, 195720193, 'sta_518e72', 'vacx7afu5');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483628, '1of77p', 398.637058, 689.065203, 1992637800, 'sta_518e72', 'dctmf');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483627, '62', 93.813527, 935.463334, 820970595, 'sta_518e72', 'qdjpe1io2');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483626, '78507cvt', 145.3181, 789.724834, 1582582341, 'sta_518e72', 'tg6bnou5zi');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483625, '6c4bfkfo', 12.330671, 774.96573, -1950324754, 'sta_518e72', '7z2zezj');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483624, '7wgx', 50.798088, 486.564401, -915385605, 'sta_518e72', 'm');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483623, '0oztd', 104.37745, 703.796681, -1609653472, 'sta_518e72', 'q5l');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483622, 'pim5', 167.377262, 492.8451, -1125548818, 'sta_518e72', '94gth');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483621, '2mnajjla3o', 904.028668, 167.474325, -761353513, 'sta_518e72', 'tmu2ne578l');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483620, 'vy', 392.947196, 527.633597, -451030047, 'sta_518e72', 'be8yvkv42q7');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483619, 'x58b4', 710.005534, 238.668607, 1849819405, 'sta_518e72', 'us3auvmkrpdj');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483618, 'wzw5chn9mo70', 486.420817, 646.236852, -1245584612, 'sta_518e72', 'xfo');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483617, 'ws', 900.422166, 55.294573, -210159774, 'sta_518e72', 'obb0q0k32o');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483616, 'w', 38.169466, 179.038075, 440115543, 'sta_518e72', 'msorlwyngc');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483615, 'dj9erhi', 746.006477, 106.602942, -499913447, 'sta_518e72', 'yo');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483614, 'l0hdt6fuq', 801.297876, 361.042997, 778835680, 'sta_518e72', 'kb521gw');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483613, 'las6', 907.723998, 65.338043, -2076274980, 'sta_518e72', 'ow');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483612, 'i1z', 493.031806, 207.080257, -564679000, 'sta_518e72', '66');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483611, 'q2xlyoto', 913.199755, 547.887692, -2094843966, 'sta_518e72', '96');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483610, 'aqb0tbindz39', 985.521662, 974.58376, 1376887048, 'sta_518e72', 'td8n5wcgu');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483609, 'bc3t', 821.043976, 824.293148, 1964331395, 'sta_518e72', 'bd0w9603v');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483608, 'xw1rxe9', 382.416063, 958.39315, 125495479, 'sta_518e72', '162');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483607, 'h55y', 467.033126, 602.631056, -732999244, 'sta_518e72', '6dza35r');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483606, 'mkio18ri2hy', 745.189516, 852.871276, -1853955201, 'sta_518e72', 'qxxnj');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483605, 'b', 376.823393, 194.517325, 687330820, 'sta_518e72', 'mfx7h33p');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483604, '6sto1cj8sh5k', 207.572242, 757.679309, 1966809332, 'sta_518e72', '7dyyd');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483603, 'jmgjach', 533.662615, 254.04555, 1122899168, 'sta_518e72', 'a17v4ygm');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483602, 'y', 262.000738, 465.762986, -1941472821, 'sta_518e72', 'uap96rntdqr');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483601, 'm5', 968.21585, 583.44162, -648564084, 'sta_518e72', 'c7d');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483600, 'n2np490xdms', 260.74675, 107.568093, -1391541536, NULL, 'qb9i9f');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483599, 'ccukjq1q', 763.851917, 314.524853, -1459013972, NULL, 'yhb08hlst1pq');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483598, 'mizt', 636.138886, 917.521539, -1304516770, NULL, 'z78');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483597, 'q', 857.91055, 257.074492, -753065777, NULL, 'ftb8r9114');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483596, 'bre6b', 760.996078, 141.988494, 364280973, NULL, 'wsj8kj');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483595, '85', 358.01048, 368.667363, 486475144, NULL, 'vrisurz0ka');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483594, 'qtncgc8s3b7', 602.197113, 736.771635, 180947503, NULL, 'dmdbdh');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483593, '6j47n', 370.459832, 766.476432, -343920305, NULL, 'sjhanzxdpu');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483592, 'mwfw', 373.299809, 276.873433, 2015039199, NULL, 'k014r5');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483591, 'dqtsmg97aqz2', 232.665028, 414.584569, 944310519, NULL, '6dd');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483590, 'ysu', 513.39609, 777.919912, 434520825, NULL, 'dk');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483589, 'u2gir31vwq5', 981.395878, 430.247286, -2014514218, NULL, 'oi1pav');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483588, 'v', 722.756601, 344.123393, 2095277250, NULL, 'qrouirl');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483587, 'rpouit63xyf', 824.672918, 189.105795, -614741184, NULL, '26mb');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483586, 'aj0ju0h3', 753.62991, 907.509317, -167036460, NULL, 'r1a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city, n AS count___ FROM (SELECT city, COUNT(*) AS n FROM station GROUP BY city) WHERE (n > 15) ORDER BY city, count___ NULLS LAST;

/*
Gold Result:
('sta_518e72', 48)
*/

-- Prediction Query
SELECT city, COUNT(*) FROM station GROUP BY city HAVING COUNT(*) >= 15;

/*
Prediction Result:
(None, 15)
('sta_518e72', 48)
*/