-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: trip --
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483648, -55602865, 'swwqcgsk', 'tri_12b437', 1, '9n8c4pgu7v', 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 1072996612);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483647, 13244799, 'hvdltt', 'tri_12b437', 1, 'lbn', 'rmdp', 2026480202, -1576219117, '5u', 1861536320);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483646, 44952191, 'fa9', 'tri_12b437', 1, '00t5c4e', 'cigce376nium', 283598170, 742285925, 'u', -1179823637);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483645, 1119186446, 'rqrofqyp5s', 'tri_12b437', 1, 'bbp02eut', 'iqa', -314162272, 2137741668, 'ytoo3o9hl7', 1178636309);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483644, -1390245819, 'x14ji7zwau2d', 'tri_12b437', 1, 'yrq13p', 'u78d99r', -1362461264, -904834265, 'b4yp5qi', -227162283);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483643, 2056419640, 'vqx58pz0f', 'tri_12b437', 1, '8jegd21vy9ux', 'j4hwbdvlph', -261132974, -1264842910, 'wnqcx', 722884590);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483642, 580968159, 'cprj', 'tri_12b437', 1, 'u0dz7', 'fjgq8n2f3', 806170397, 513454646, '0gcb98', -1454058168);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483641, -2078052421, 'yrk', 'tri_12b437', 1, 'n6vck6ah0f', 'jswwlq7xb', 602161869, 1350414441, 'a7ryfd', 564390026);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483640, -1259474148, 'jai', 'tri_12b437', 1, 'dh5ogrgj', '8', -458359144, 600440952, 'f', -1717646459);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483639, -1696173285, 'tsj', 'tri_12b437', 1, 'ayxp1q43', '1jh3den', 357330522, -683007527, 'x', -1762140823);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483638, 1371234901, '1of77p', 'tri_12b437', 1, 'o72ctdc', 'mfg62', -1744557630, 1870300798, 'q8qdjpe1', -1180042408);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483637, 199672698, '7cvtjpt', 'tri_12b437', 1, 'tg6bnou5zi', '6c4bfkfo', -1950324754, 2115816682, '7z2zezjo7wg', 1248858185);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483636, -57705450, 'xcmr0', 'tri_12b437', 1, 'ztdg', '5i3', -1405314653, 1816660482, 'npi', -1300180872);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483635, -1125548818, '94gth', 'tri_12b437', 1, '2mnajjla3o', 'v8u', 618058035, 1553368934, 'e578', 1908593332);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483634, 697257217, '7zzbe8y', 'tri_12b437', 1, 'kv42q7', 'x58b4', -1122409769, 1849819405, 'us3auvmkrpdj', 1105964624);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483633, -663234145, 'h', 'tri_12b437', 1, '9mo7', '5a9n0jx', -1796351243, -1793230843, 'zdo2z', 270415200);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483632, -2071531094, 'q0k32od', 'tri_12b437', 1, 'cl5ams', 'orlwyngc1dj', 211603887, -413043724, 'k1yoeyo6l0h', -1942581013);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483631, -795975227, 'xuzkb52', 'tri_12b437', 1, 'gwnlas6', 'elboeowii1', -457369423, 1557188093, 'xih662q2xly', 412199481);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483630, 727608179, 'awg96aqb0tbi', 'tri_12b437', 1, 'ndz39tajz9', 'd8n5w', -1988582944, -794767771, 'c', 1295379066);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483629, 1071401016, 'w9603vz', 'tri_12b437', 1, 'xw1rxe9yfk7', 'k162n', -516345261, -1191116453, 'u06dza', -154207334);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483628, 729449685, 'io1', 'tri_12b437', 1, 'ri2hy08ft', '6ewt', -1051623642, 2013745856, 'b', -1312038093);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483627, 687330820, 'mfx7h33p', 'tri_12b437', 1, '6sto1cj8sh5k', 'zys7', 1487347213, 1328948152, '1', -1520090613);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483626, 591870819, 'jach8qta8y3', 'tri_12b437', 1, '1', 'v4ygmayq3', 1432875972, 1032339628, 'uap9', 1291298007);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483625, 1982265552, 'dqrhm', 'tri_12b437', 1, 'wlic7dn2', 'p490', -592014051, 1744849810, 'sqtgelcuqb', 1374676344);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483624, 238243966, 'ccukjq1q', 'tri_12b437', 1, 'ik1yhb', '8hlst1p', -1333785554, 1784997708, 'tvb6m4iz78', -2128972904);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483623, -1043357093, 'd8ftb8', 'tri_12b437', 1, '9114q', 'r', 36589303, -1537647691, 'uuwsj8kjh8', -55270062);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483622, -1101814296, 'lvrisurz0k', 'tri_12b437', 1, 'q', 'ncgc8', 1446366856, 438933248, '88kwdmdbdht6', 313797011);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483621, 1946419004, 'nxar50hsj', 'tri_12b437', 1, 'an', 'xdpunmw', -1782325492, -544173163, 'lawk0', -300547632);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483620, -967107842, 'dqtsmg97aqz2', 'tri_12b437', 1, '20pj', 'ddlysu6ip', -1664440372, 1849928338, '31vwq', 1188674483);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483619, -299585625, '2', 'tri_12b437', 1, 'sb3uoi1pavcv', 'wnyqrouirlrp', 1026055008, -1599077491, '63xyfvmjwpp', 1913338832);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483618, -2061050846, 'j', 'tri_12b437', 1, '0ju0h3r133ir', 'axyyhpl', -1837449583, 1299933788, 'gckqwtsr54', -1042838119);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483617, 1763821445, 'ktb1d2nzg3rj', 'tri_12b437', 1, 'wns', '47j2ja8dccy3', 1560573473, 472597763, 'wq49yrnxs6d', -1910754958);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483616, -1900450199, 'v7t3gvpl', 'tri_12b437', 1, '9fj', 'uun7k1', -251621840, -1720233199, '1rgeza', 423028705);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483615, -316078323, 'upg', 'tri_12b437', 1, 'ly78oitxeilp', 'e019cy7od0', -1882121644, 935816178, 's', -690382359);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483614, -1640621748, '2', 'tri_12b437', 1, '9lqv26u331s', 'xpw3', -349181074, -1725714389, 'xgi', 404445908);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483613, -1919229426, '61l2', 'tri_12b437', 1, 'o3ak162ocagj', 'ev', -582813835, -572986964, '49kubo', 833662145);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483612, -1943810603, 'uekhllbw', 'tri_12b437', 1, 'dpu5v0', 'du', -699425950, -432771718, '29835xoepa', -563021857);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483611, -2062902911, '0c', 'tri_12b437', 1, '96xiyet8', 'jhcf46', -2003500453, 1280646590, 'a61sjv', -1265768652);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483610, 2081562124, 'd', 'tri_12b437', 1, 'okuez', 'ctehia3cmvb', -1077762203, -1798310553, 'or1esk', 1749319777);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483609, -213453775, '01', 'tri_12b437', 1, 'ui', '7f8', -1663813652, 1094664154, '8gxb', 854201197);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483608, -1497515537, 'awsp4', 'tri_12b437', 1, 'wi3', 'l7', -1480511510, -189319798, '795ybv83kr3', 722968762);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483607, 1347243533, 'n2z', 'tri_12b437', 1, '9xgjjac', 'gmukfb5if4', 143843552, 1085074663, 'rb', -1147551293);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483606, -716185359, '6s', 'tri_12b437', 1, 'tut', '6lu2cel8mh', -1957884289, -1266238892, 'ni', -1800278299);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483605, 325130763, 'z5', 'tri_12b437', 1, 'qxs2', 'xh888y1k2', 309851181, -156220540, '5', 1772219707);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483604, -1642107656, 'mdaqqhy', 'tri_12b437', 1, 'zsnp64h', 'nnw4', 355299538, -343271949, 'wbjk0', -2076821826);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483603, 1851648795, 'w', 'tri_12b437', 1, '7', 'jjplwtlzh42n', -479465694, 1149956627, 'rji5mqkna3', 172299659);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483602, 1705419178, 'wb2d0', 'tri_12b437', 1, 'mxwdb7o', 'p5qo1', 749598659, 902707245, 'kd4k', 825979697);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483601, -1565247126, 'axz', 'tri_12b437', 1, '90nhs', '9gob', -976193147, -15423424, 'phy', -2074051940);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483600, 1487440939, 'y', 'tri_12b437', 1, 'hvyx8s', 'r', -366834342, -912658170, 'qn0b5m2rlxcr', -1756413046);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483599, 1142505194, 'gz84lqm', 'tri_12b437', 1, '2w', 'b1b3vun66e0i', 499998313, 1915216858, '070zi', 207340898);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483598, -1205465222, 'q833g86', 'tri_12b437', 1, '5zm6dpewew0', '2p40u2vil', -261109897, -555808510, 'd', 1367239582);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483597, 579664554, 'iqoauy0', 'tri_12b437', 1, '3lwh994f', 'qc1m9gr8xj', 1072042049, 1690134584, 'd4sj5i', 343349384);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483596, 1293700593, 'gwakmwg', 'tri_12b437', 1, '73fy3d', 'dip', 1484560348, 373735911, 'qx6j6d4', 1950702818);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483595, 877176214, '5m4s2ajdu', 'tri_12b437', 1, '6xuj90te', 'x3', -768531730, 99716186, 'qf9lx8qza', -1552763743);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483594, -802272948, 'wu7a', 'tri_12b437', 1, 'j0j', 'k6hh2o', 1342717090, 1100953564, 'zrv1ll930xvk', 2045017461);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483593, 513178845, '6n0', 'tri_12b437', 1, 'rlpsaxeein', 'bciv', -46379547, -890072422, 'eqv3r3uxdox', 1264155936);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483592, -390950704, 'l1zmjrssbh', 'tri_12b437', 1, '2404qpp33', '3a1ngqu', 359389091, -1879482337, 'jdlh', -1408342453);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483591, 1689665778, 'yxk0a0cql1c8', 'tri_12b437', 1, 'w', 'adbp07', 1386881333, -1474004959, 'jz', -564818339);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483590, -1698199106, 'cg9', 'tri_12b437', 1, '4', 'kj', 935509881, 371075029, 'dw16f5tqh', -1920701595);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483589, 1845526962, 'b', 'tri_12b437', 1, 'kr2t', 'dlb6i42', -221912911, -641282671, '2', -1934015200);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483588, -826285299, 'havc2c4zpw', 'tri_12b437', 1, '672fve0jf', 'i5t99kvn', 1211169035, -681931530, 'tp3tfndtw', 232457376);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483587, 782631880, '4eufiof8of6', 'tri_12b437', 1, 'bp9qgjradf', 'j8', 765163181, 24627578, '53p8e5olf0y', -327742602);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483586, -1457401052, '0g5', 'tri_12b437', 1, '0j597fznqc', 'ex41fa', 1358642481, -273635449, 'e448u5lvdbp', 709713623);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483585, -1664812348, '3o', 'tri_12b437', 1, 'lciif0l', '46upleo', 788036815, 2055250957, 'm3q0pq97j53', -70372742);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483584, -56541423, 'k', 'tri_12b437', 1, '1yspzc7', 'rv4pmp', -1502776895, -2011163283, 'rn6j7', -656237101);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483583, -1721897132, '6s', 'tri_12b437', 1, 'l45j', '5pbgwo', -1611243101, 16782608, '3', -1936734976);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483582, -47165816, '75b7', 'tri_12b437', 1, '3o58zbgy', 'xt0twoua4yi4', -1623767807, -1999209177, '1q', -663558450);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483581, -168704210, 'l', 'tri_12b437', 1, '8s82sp4j9fo', 't', 266841961, 1728774879, 'ae6', -2093375165);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483580, 1733360461, '676lk8q', 'tri_12b437', 1, 'azkjyfxsov', '98', 1450500765, 946867225, '235v8ikp3qu7', -1947520594);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483579, 970728092, 'wgr124vu6v8', 'tri_12b437', 1, 'kl', 'y93zu8y', 1694002877, 956649820, 'qpog5smdhc', 581574032);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483578, 931265534, 'y6whwhlh5', 'tri_12b437', 1, 'i1dtdjm8ry9l', 'hw6lv7j452', -1421113645, -1016601672, 'qt5uw42p20', -1740675234);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483577, -856771235, 'k1', 'tri_12b437', 1, '3bj', 'suy', 1564603333, 536967336, 'zboodl', 822981708);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483576, 798014875, 'ufc', 'tri_12b437', 1, 'vfghixbu', 'xi', -872444108, 1358631228, 'isdq44u2', -1775767623);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483575, 1809278717, 'w', 'tri_12b437', 1, '3q5br3', 'qobvbj26k', -580079713, -693134353, 'h2flntl', 1547717459);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483574, 909468880, 'qtl1u', 'tri_12b437', 1, 'dbvf', 'ya6l431g', 322498251, -1841006453, 'q6gifjtvx', -837398940);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483573, -293052318, 'jf1qj3se4d', 'tri_12b437', 1, 'pb4l6rurl72q', 'ippxb659q', -1434769338, -15764418, 'ce2y485y', 1450323131);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483572, 934708702, '7p3hvg0', 'tri_12b437', 1, 'ytzip2', 'a6d2hqs4zc1', -254442524, 145803049, 'rnfvkrmfoqpz', 1821943546);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483571, -2004793572, 'n53i98owqwx0', 'tri_12b437', 1, 'hvv0oh59iv', 'ipn6', 1562452925, 410637411, '16hqb', 1491779551);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483570, 1295864154, '4done', 'tri_12b437', 1, 'b6piqku', 'izi62308npqd', -1836655128, -127748294, 'l4ptf8u', 278497828);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483569, -393305044, '90t2kl', 'tri_12b437', 1, 'apcw1gn', 'o6r9d3zdayv5', 1854082190, -1673257263, 'vccwr', -582426548);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483568, -1919439586, 'ko47', 'tri_12b437', 1, 'q', '0691b7s1i', 2115162734, 179445490, 'hqz3rs94x3yy', -567248843);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483567, 533073608, 'ge', 'tri_12b437', 1, 'rz', 'w0qgiqh4ao3k', 250255154, 1169111674, '7swb334', 255947809);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483566, 587390904, '5l6rnd3rhb', 'tri_12b437', 1, 'nmbp96v512', 'bvxjnuw8', -84497692, 1992855386, '1nfs4nio', -1312747890);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483565, 158580721, 'r', 'tri_12b437', 1, '971kpjnn', 's', -40599967, 1040296707, 'rj', 27734824);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483564, -193070748, 'kajtw7sqi', 'tri_12b437', 1, 'j9f945', 'cwnr8dq', 755310829, -2038978824, 'jmeuvjvcr9', -392675823);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483563, 421059825, '15y8am0q', 'tri_12b437', 1, 'ut2', '31', -317767232, -742079274, '4s7', -612603238);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483562, -1705389050, '0zchdq8o', 'tri_12b437', 1, 'xze42', 'wen', -1233317434, -1395464118, 'kspw6gvo', 538410706);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483561, -1406204087, 'mrsv641', 'tri_12b437', 1, '6b', 'ugt8ygq', 852372792, -410627909, 'qv7z6ik', -605442308);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483560, -596283718, 'l', 'tri_12b437', 1, 'bbk27zz', 'uuwyewbihg8', 2028167237, 1313061607, 'v3', -1068238654);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483559, -237981586, 'hc', 'tri_12b437', 1, 't2v4', 'lraxg0gtxot6', 1106541902, 494307015, 'qs', 1706126398);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483558, 430478888, 'beyhml', 'tri_12b437', 1, 'rnycz8d5yka', 'btcpo1ke8euy', 629009789, 773955054, 'cxl8e4bkfp', 684639412);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483557, -518242106, 'nm0cmn', 'tri_12b437', 1, 'usy4c1vk2', 'ki4uvof5n', -1945911187, 625106229, 'qe9rs1z', -205525091);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483556, 1705616658, '4o1sqir', 'tri_12b437', 1, 'hj1', 'xi', 338431515, 1672949483, 'm29vphx5vl', -1520839536);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483555, 1440780484, '1skvh4q', 'tri_12b437', 1, 'y4gp', '0kr5bk0d0gkg', 586154782, -772738375, 'e', 809990944);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483554, 1893000285, 'dvf', 'tri_12b437', 1, '2j4ljlh', 'dpnheb', -1221167808, 2141308608, '2zt2ugy7qn', 685140638);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483553, 917021023, 's', 'tri_12b437', 1, 'la9', '1nq7dxug9rta', -615675122, -1252742289, '7az', 13363947);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483552, -2141689162, 'cu8', 'tri_12b437', 1, 'vxo5sddf', 'a2n0l', -642971630, -1035489492, 'ig197ge', 887947195);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483551, -1350605914, 'l', 'tri_12b437', 1, 'tk', 't', 633090631, 499326529, '79c', 527668055);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483550, -1393460091, 'nzpkcp', 'tri_12b437', 1, '0q9z43', 'ul6g25j', -1385817383, -1440619854, 'qx', 646367725);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483549, -312001161, 'nb', 'tri_12b437', 1, 'p186', 'a9g9nw16', 501307804, -852945467, 'ckaioh8mpzf5', -837033115);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483548, 1952215203, 'ok6vh', 'tri_12b437', 1, 'c3', 'b0v293muo9o5', 592134998, 1161208830, 'nc56gwfuy2', 731441951);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483547, -848636172, 'r95sn', 'tri_12b437', 1, 'qc', '1jc1j3dmll8k', -1034567822, -1615622566, '5iptxmlh', -717155857);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483546, -575776570, 'i78hfcwwwk', 'tri_12b437', 1, 'xvvf', 'aq65q', 1332149925, 987389130, 'ro7mfr86mok', 131124756);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483545, -818906275, 'qbwhbis', 'tri_12b437', 1, 'zzg8eizd0cun', 'g8', -1739525341, -1301745780, 'wbd', -1194088179);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483544, -379077665, 'nxzfoas9', 'tri_12b437', 1, 'zd', 'e0', 457373592, 427986638, 'i6vn9a6', -1621905952);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483543, -1027174199, 'y7etff9znz5', 'tri_12b437', 1, 'a', 'yzmae7whkuxo', 1416910304, -1417340320, 'xpevos', -2015196480);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483542, 877331425, 'qbvoyhadym3', 'tri_12b437', 1, 'api', 'pzjd2zxpmasp', -395249870, 943383942, 'jufkhq6sd', -291432497);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483541, -1738595278, 'jcakwtumv', 'tri_12b437', 1, 'p19dvetwec1z', '80x72p', -2045718619, 1055301009, 'fp2srds4', 602569741);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483540, 810930278, 'oymk', 'tri_12b437', 1, 'yzveffs4', 'e2yc4ssva83', -1595729346, 1886602907, 'zc5', 694956975);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483539, -1366856113, 'l71l0q4n', 'tri_12b437', 1, 'sw3', '506p67904l', 281225853, -1944407529, 'fs830rj63fqs', -431856069);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483538, 657273326, 'w', 'tri_12b437', 1, 'k5paop6', '3z5p37ek', -606548084, -1750219232, '1p091mps3', 939604589);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483537, -1831762623, '5utc4wz1h52', 'tri_12b437', 1, '5f', '05rr8l', 1598783914, -1032481986, 'r2exf0wr', -2136286026);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483536, 1941642896, '2k', 'tri_12b437', 1, 'n0', 'o22', 1821567030, -779371584, '5ig2eidvgb', -1628684009);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483535, 1549697092, '1fs7hycn', 'tri_12b437', 1, 'b5afv61keoy', 'aj0p', 1997390066, -1435857579, 'r1gn', -595202332);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483534, -1569360533, '6asmj572d4', 'tri_12b437', 1, 't9h4gwpvhdb', 'n16i83ytqv3', -280033891, -361302233, 'x29', 1151086276);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483533, -581322130, 'iacsh', 'tri_12b437', 1, 'uvyn3ea', '7', -1879635632, -1419971990, '5vws', 408038605);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483532, -1459535534, 'ry62kek7h', 'tri_12b437', 1, 'bs5', 'fh8imiukqf', 214802939, 1593511775, '0f3gcwa8dx', 818961597);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483531, 682357819, '9', 'tri_12b437', 1, '8g', 'zmc05e27hv', -338725310, 504418104, '1', 1878098257);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483530, 623688321, 'reyykrfk', 'tri_12b437', 1, '2upbwnk4fgnm', '2sp7', 630966101, -781440835, 'jur734thb', 1714952850);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483529, -45772902, 'p8sxfswd', 'tri_12b437', 1, 'wyo5krex79', 'kiyf8voo', 310606071, -517667594, 'mc1ovv1mq0f', -1624902253);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483528, 1044256264, '0hzmg80', 'tri_12b437', 1, '4o5adjd1cnct', 'mrf34rnm3o89', 2023569113, 1616298234, '7bfhyh50z3', 1890283060);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483527, 535938990, '7rl1wba9', 'tri_12b437', 1, 'rwyz', 'o', 2073964177, -1728917984, 'jit2fgscgm', 1800393019);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483526, 1221387074, 'buot7nieb', 'tri_12b437', 1, 'mq5mmu4', 'r', -805728311, -157512566, 'l89', 717146737);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483525, 815820870, 'b', 'tri_12b437', 1, '1ve2s5u', 'zn', 745363203, -119946228, 'z6ck6b9', -527594854);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483524, -796487316, 'esd5q1wmig', 'tri_12b437', 1, 'g', 'h9o', 1964129645, 219188164, 'k0a5ymsyq', 605799144);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483523, -1261691308, 'spwouuid2gty', 'tri_12b437', 1, '8oy', '7fcj0979', -2014808806, 1979702945, '4ewrogwh', -1628600247);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483522, -2106514489, 'ba4', 'tri_12b437', 1, 's', 'gt1ge577of', 1635811353, 811072118, 'py7d', -586643);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483521, 1339625596, 'o4lx0w2', 'tri_12b437', 1, '0', '75', -1424113909, -143997657, 'weolubkg0s', -279395570);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483520, -895369309, '9pwk', 'tri_12b437', 1, 'ya142jc1bi', 'bpf7inpc', 816416786, 1942715256, 'yf', 294006511);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483519, 1688634821, '754ee3rjtqn', 'tri_12b437', 1, 'qmiagwsy5cd', 'pg7taebbrta', 547143901, -137587576, 'tavns', 1635213592);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483518, 1255898124, 'm75qs3c2cvt', 'tri_12b437', 1, 'mkki0f', 'ht8az', -1353693182, 1234810463, 'b7ke6wmuz', 90479197);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483517, -380865242, 'q5nq', 'tri_12b437', 1, 'jwjqg22', '0epbaljmxzq', 702972227, 1176013630, 'h', 463638251);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483516, -1225360905, 'dbd', 'tri_12b437', 1, 'zpxts', 'nn7', -1216243606, -79734892, 'q5zahkeowm', 991639308);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483515, -746252171, '0zw', 'tri_12b437', 1, 'm', '56llqp', -240771004, 172355920, 'xk6z7s', 1742692703);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483514, -636500692, '8s2va4tntw8', 'tri_12b437', 1, 'h5de', '6psktmhq', -1321268143, -1468427304, 'larfcnl', 615538413);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483513, -2128828645, '9hu', 'tri_12b437', 1, 'nj3sxridwp', 'mv', -1311470678, 1509651474, 'ijz9xfb6', 1730321583);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483512, 662841897, 'j17954wg', 'tri_12b437', 1, 'fr6w64', 'uoryhibfz5', 2081364950, -1128080411, 'mn8qkeopjf', 1387427823);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483511, -962847839, 'o', 'tri_12b437', 1, 't', 'l20nf', 1061197921, 1397134241, '9zgw', -1159855439);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483510, -977679015, 'i32iv', 'tri_12b437', 1, '5yty8elwww', 'al4zvb0w', 1636736172, -794886452, 'udv3ox', -1103943018);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483509, -488705888, 'iyqy68c1', 'tri_12b437', 1, 'ubc08gf1', 'tfq93b67ki', 126611097, 324756096, 'oy4y32x', -1953328275);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483508, 1706325013, 'jmnmpy', 'tri_12b437', 1, 'jg1m', '5lkdpythdtl', -241557273, 2010447953, 'e', 1498163524);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483507, -146712558, 'i', 'tri_12b437', 1, 'ndd3', 'uj2sy8v', -2092488574, 828304730, '970a6m4y0y', -116703289);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483506, -1400640008, 'wxr0fl4s', 'tri_12b437', 1, 'v4os1', 'gifdlkw8n', 1277630579, 746284544, 'nev8r3v7', 938440174);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483505, -95216660, '7if43f', 'tri_12b437', 1, '7tciep9sn5r', 'w', -1461454977, -1290195227, '4unlav0t6g', -1768303432);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483504, 1103651098, 'r3ndj8gka', 'tri_12b437', 1, 'kn', '56s9', 1142843193, 96442048, 'x4idfe4mvf', 2091742246);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483503, -587476470, '6m8o25ezvw', 'tri_12b437', 1, 'mp7huzs', 'zkco3', 1681768107, -768824622, '46il', -1639567362);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483502, 2106975680, 'no1mcyqwm', 'tri_12b437', 1, '2kp54', 'btm4bttk9r', -1111890491, 1571429473, 'hlme', 185999725);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483501, 282794014, 'nq76swul6z4', 'tri_12b437', 1, '2a9b', 'dxssn791', -350886978, 668907906, 'r1w0i', -840310304);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483500, -1827822796, '70v4o5j0foc', 'tri_12b437', 1, 'k0qs', 'f8b', 809899785, 134617238, 'pu', -1669527371);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483499, -273362763, 'a929yb3', 'tri_12b437', 1, 'ftrf7q', '7o4', 587447346, 321903206, 'o9u7', -1591276817);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483498, -232573333, 'u', 'tri_12b437', 1, '4c', 'sd31t', -1757835932, -1656521197, 'h43jizr1fuji', 557333529);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483497, -452510809, 'vgp3u4a46nci', 'tri_12b437', 1, 'mt983k4gv', 'yxsy5lx09m5', -2046634314, 738854115, 'ku07', -1923270302);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483496, -1091277303, 'ioj17pwnu5cc', 'tri_12b437', 1, '7cnltrtr', 'dsehob1au3vv', -1685549964, -1042514421, 'b', 198267933);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483495, 397605152, 'k8548bq', 'tri_12b437', 1, '5', 'fsg3nhy', -1257549895, -252335361, 'j', -1210636064);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483494, -1886162589, 'aqwwb5cbz2il', 'tri_12b437', 1, '2jjm6', 'g9', -1957362772, 1665811611, '4', -665692424);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483493, -1714747479, 'rl5w', 'tri_12b437', 1, 'q4912pss', '04b', 701872695, -418063457, 'y1m0pjnq0qw', -452458098);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483492, 759805167, '9', 'tri_12b437', 1, '114sh53du2tz', 'x', -22869804, 1895492277, '3q7cy', -1420232256);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483491, -758908844, '27', 'tri_12b437', 1, 'nzxmd76s0wr0', '5a7p', 1968720421, -491543572, 'e3mthh1s6', -551232319);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483490, 249321545, 'q6mbo', 'tri_12b437', 1, 'qt4f8b', 'd3pwwpksr', -929417391, -1368949815, 'x51c7l8zy', -902506036);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483489, -570530540, 'mxq', 'tri_12b437', 1, '9jctvc5o43u5', '5y', -2071102120, -504973299, '5hak5', -191003601);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483488, 650434122, '50cxpj9', 'tri_12b437', 1, 'ch8wg', 'sf', 1140558148, 180390342, 's6y1ul1ww', -1886733661);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483487, 1313751401, 'f', 'tri_12b437', 1, 'a1qwqq5', '4qayl6xv57yv', 1353470265, 1226595381, 'nxgyc', 1085588756);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483486, -3608505, '0t7seki', 'tri_12b437', 1, 'm9dyv7l', 'd5jfvkb2z7d', -1987756151, 1186322879, 'umntpv4ejvy', 725617981);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483485, 159240967, '3iyj', 'tri_12b437', 1, 'v0obs95v', 'x', 978182172, -367104606, 'ccwqiem560sw', 700831187);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483484, -371540359, 'tpntwc66t', 'tri_12b437', 1, 'ypqzp3f40', 'wvwvuf4krv', -1284786980, -2015859556, '9nz0tkpp', 1807220603);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483483, -305675789, '9gbdzg3', 'tri_12b437', 1, 'lr', 'he6siwsr5', 1548125625, 1802360768, '9c08lbz', -179943020);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483482, 1744443386, 'z0', 'tri_12b437', 1, 'jmezmqqbk', 'c', 1950943635, 1737240164, 'j3peb4', -1021782135);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483481, -956531702, 'sr09nz2e8db', 'tri_12b437', 1, 'k', '0lyf4p5r52k2', -506478214, -1215484130, 'up2pjjwe9qy', -2055490531);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483480, 1900374462, 'm', 'tri_12b437', 1, 'xn0fy', 'sh9y8v3ce5', -1250151030, 1790941031, 'wcl8hon2v5q', 3473187);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483479, -906139673, 'onoluk7', 'tri_12b437', 1, '2x9e', '3j', 1119445535, 1489651100, 't', 1480662874);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483478, 1571131548, 'a2w2b5', 'tri_12b437', 1, '2o86cch', 'o58adh', 1232645771, -1221260224, 'd289', -2074831735);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483477, 998420056, 'm83k0bxojj', 'tri_12b437', 1, 'm2qo4n8w', 'z2ii', 1400911530, 1999663025, '13615glb8', -728799214);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483476, 559819130, '8fsqlr0k8y', 'tri_12b437', 1, '8vq0h', '81brucy7', 112835265, -2039545669, 'ghrntntdgucf', 1596594694);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483475, -397502411, 'z100c', 'tri_12b437', 1, 'umu7', 'ciqifpmi7pnm', 724054608, 846450689, '2uxljoxim2g', -809924615);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483474, 2099679113, 'ijve', 'tri_12b437', 1, 'pdwcgw4k', 'va5dwp7ak0', 2015996560, 1221539609, 'cy38lhkok5k', -1515479700);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483473, -1717677553, 'r', 'tri_12b437', 1, 'gzxbk7v82', 'zkjx0nuaaz', -1776389860, 517361640, 'r7b0g38mhq', -2103260764);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483472, -854773137, '548dsit3z0', 'tri_12b437', 1, 'eij9ew92w', 'swd', 1515220990, -46060967, 'x7f95k0o06u', -680769346);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483471, -1177213799, 'jsoqct5x4', 'tri_12b437', 1, 'gibx4kcn', '4yf4', -533391333, 1839977005, 'don2eax1918q', 1571746993);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483470, 331396580, 'nvovlwdum', 'tri_12b437', 1, '3kql7kilv3', 'uwoici24ps6p', 1422909347, 1316524309, 'bm23i', -1472012069);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483469, 114688494, 'ey', 'tri_12b437', 1, 'b', 'wsbom', 1560821462, 1058553683, 'mob3dk', 1344388703);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483468, -828683389, 'c', 'tri_12b437', 1, '2782a7bfv', 'hm', 576953320, 1507671192, 'wxa8x5sn11', 1134534157);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483467, 923971237, '2', 'tri_12b437', 1, '6pb', 'begqwo', -686495014, 1716964418, '0n68ldx', -1573471473);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483466, -560063872, 'fj61qwwmoi', 'tri_12b437', 1, 'lwo1o8gw', '6z5o6n8x6dy', -1445173396, -1469345313, 'fmvqn8a1b', -1899749389);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483465, -1204013051, 'atog3ni5b', 'tri_12b437', 1, 'ftst4g3', '48m3c', -1154578792, -69645750, 'ii', -976522364);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483464, -1173213564, 'winbtvakgqw', 'tri_12b437', 1, '85djsqfm', 'usn0w4ezd9', -1866213143, -1570427931, 'byn3', -446221727);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483463, 2061406996, '8n74bt5kf64f', 'tri_12b437', 1, 'r', 'mm9b7jzam0', 925258885, 1905062782, 'm8', -1766428297);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483462, -935727539, 'tbg5q3rm98', 'tri_12b437', 1, '15fbkiayl', '2wqzp39', -1726810313, -2086083338, '5v74hj4h', -2072234925);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483461, 134041175, '4pdyqr', 'tri_12b437', 1, 'vfxsn47b', 'w5pn6tl9s88t', -2115084039, -1692198705, 'hj1lyxv', -351282649);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483460, 1992752878, 'd13w3m524b', 'tri_12b437', 1, 'vp0nwannn', '0yin3cpx', 1763257451, -1408950229, '5xbcv', 1792252694);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483459, 904366963, '4lfa', 'tri_12b437', 1, 'cnjst9z5k4e', 'r81ypshln0', 1570664577, -383910760, 'g5mn', 284528678);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483458, 1977610001, 'tvanivz01', 'tri_12b437', 1, '71i9jbi5jou', 'mrat35in', -1537731400, -638232562, '12', 713986440);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483457, -1460656175, '9', 'tri_12b437', 1, 'tzehja', 'so83jp', -1276022704, 809990787, 'u', -440102675);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483456, 1220822035, '0kyhwzd5549o', 'tri_12b437', 1, 'o6d33l6r', 'uv', -2051497173, -1496540994, 'e74oxrayuc', -532961770);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483455, 1689266364, 'y8kmoxngq', 'tri_12b437', 1, '2fqr7a', 'tvws27pfje', 1770049264, 1333172128, 'u5s68wf35f0i', -637168577);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483454, -1146182883, 'v7x1kg', 'tri_12b437', 1, 'u408n1', '4rhp869zbf', 1063676121, -1431195601, 'tr0i3ycz', -50384896);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483453, -487826578, '4t4qn9vwg', 'tri_12b437', 1, 'x5p4dcve', 's3tyeuvr', 583542201, 1397444594, 'chveuh6zr3', 312641245);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483452, 1121764433, 'zzjxxm', 'tri_12b437', 1, 'mv', 'of', 48418604, 1543248559, 'znfsiu29jm', 147162408);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483451, 434629406, '4rgxxs3', 'tri_12b437', 1, '2', 'czi3bexemer', -318388883, 147720886, 'jtrpf728', 997379223);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483450, 443976082, '80scpwa', 'tri_12b437', 1, '7vsx5r5az3', 'o', 801982204, -814174669, 'ra', 1633185334);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483449, -625028064, 'ikra', 'tri_12b437', 1, 'd1f7desf1ku6', 'ubhlgyhqx', 965060333, -1204559522, 'f7zcjswsij', 137266480);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (2, 993611999, 'm9m7', 'tri_12b437', 1, 'vh35cchobn', '98s66yoj11s', 1997763585, -1780909966, 'e4r', -1613148781);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (3, 1418258972, 'lkris5ijgr', 'tri_12b437', 1, 'ydrloqybj', 'v7', -156163790, -789306102, '5qiagprf', -1024912518);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483448, -715641638, 'us2m7', 'tri_12b437', 1, '7gug0', 'pieabzoddt', -1845710788, 52067155, 'b', -401148679);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483445, -2143386943, 'a1w', 'tri_12b437', 1, 'gmx', 's', 406004889, -579103022, '28itej', -809642591);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483444, -895414376, 'lojt1bfdyssx', 'tri_12b437', 1, '6nu', 'uc7efqtb3z8', 144940580, 1064812194, 'uuqwjue', -1935785779);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483443, 396984964, 'h3ewpx8ft4ou', 'tri_12b437', 1, 'z2ebx0g56kl1', 'u', 2142823071, -1243287691, 'b3vzypis6', 1883388447);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483442, 1143435443, 'b1', 'tri_12b437', 1, '8evrd', 'ug1b7zk', 1105287898, 104049911, 'ylrofzmbd28', -1741989586);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483441, 1757505984, '0r', 'tri_12b437', 1, '4gchyxvgyf', 'av', -1342938039, 1596336884, '7nfue', -803361731);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483440, -640734447, 'wf5w7i9m80c', 'tri_12b437', 1, 'ro6', 'u0ywkkip', -990327208, 338704384, 'w3auk', 734132434);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483439, 400872744, 'pps25aii74um', 'tri_12b437', 1, '3pgpml1rte', 'hdl1uj', 292278697, 446275188, 'd1qx68', -1284906172);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483438, 1494898996, 'q8hkyaudx', 'tri_12b437', 1, 'ibqvlstocb', 'zx57m', 1037151060, -475375921, 'bz7z', 1607675325);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483437, 289012826, 'arcrnnsd7sv', 'tri_12b437', 1, '6d2', 'ca5rzar2', -1513664485, 1121321738, '92yhaj2g', 1253345086);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483436, 883369709, '72rch1', 'tri_12b437', 1, 'bb2t3a', 'emvdgg', -1965534133, 2115475119, '8k2q5iz2b', -457102561);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483435, 1200849171, 'ui4xl7x', 'tri_12b437', 1, 'u8zzy9r12f', 'nb9xo8ll1mtv', -988609942, 919442103, 'f2fy0gd7vrg0', -2134089921);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483434, -2023737872, 'e07tt1s', 'tri_12b437', 1, '78arzv5pbo', 'd9cxrsv3vxy', -671920199, 1926031126, 'qeg8', -1845588664);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483433, -925168677, '6t0ug', 'tri_12b437', 1, 'm', '5m9by', -1853817083, -316254468, 'o6qzou', -721677672);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483432, 1609916629, 'ybmweno7hvii', 'tri_12b437', 1, 'hwq7880r23', '0n', 695950263, -2069606719, '5x5lvu', -1754057225);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483431, -556967569, 'jwr1ll', 'tri_12b437', 1, 'm82x8xhp5ue', 'o1', 683110626, 1460383377, '62', 1982892044);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483430, 1017506161, 'jsdqccnc', 'tri_12b437', 1, 'rjp', 'ahiz30jtr9', -684251921, -1157908976, 'u5ck7f2n7j', -392553275);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483429, 649027384, '8k', 'tri_12b437', 1, '0yuex52fo019', '54p3cf5g47sx', 262537288, 208415010, '8sf518eii', 1947485758);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483428, 1859733039, 'm5e5', 'tri_12b437', 1, '43', 'n', -129743772, 1812695258, 'dmwebkp0iac', -503470527);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483427, 690284384, 'rxln1rou1', 'tri_12b437', 1, 'ycpeuk25c8', '0l9', -340494140, -1259184182, 'hgm524d5c', 175480606);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483426, -304797928, 'bdjego3olg', 'tri_12b437', 1, '14j', '900qzzxabim', 828105606, -1926665157, '4d0z92qkl', 37712871);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483425, 346230208, 'krx56olrjs5', 'tri_12b437', 1, 'aoyvmpf', 'zserr55ga', -1106301087, 1755707174, 'oz', 594146831);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483424, 730629163, 'zynxi47e5mpb', 'tri_12b437', 1, 'kr0vc', 'ajltfujuc2g6', 605740492, -1820211720, 'rpwlu1jlvgs', 38354831);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483423, -1452715231, 'yrd', 'tri_12b437', 1, 'j3whyc', '513qh7', -382009912, -1448058743, 'a0yjlks7', -448839033);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483422, 1852757632, 'r660e6o9', 'tri_12b437', 1, 'djyei80fqbo', 'ivw', -1696223356, 760348381, '4636efcw', 1797240781);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483421, -267159224, 'gyx3n0f', 'tri_12b437', 1, 'eg4pu0dte307', 'r2', -302872543, 1447760955, 't628fd1f', -194684580);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483420, -989603568, '3w21qxjqc9y5', 'tri_12b437', 1, '399jfge', 'srh6e2', 1593998555, -1691766138, '7tyyg0bci', -2049081194);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483419, -1166997908, 'jfg5eayuvg', 'tri_12b437', 1, 'c', 'uubx2vw904r', -1497969661, 1944481634, 'vb', 898867295);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483418, 886337347, 'mm6ek4mcotp', 'tri_12b437', 1, '7rmgcen6', 'jney', -470438381, -2074655730, 'my1tshrmlqw', 1458730796);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483417, -66041755, 'ntc5', 'tri_12b437', 1, '94c', 'ndgz4', 904766768, -2030935650, '618eui7byz', 183252385);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483416, 340346085, 'a0oh', 'tri_12b437', 1, 'd7n', 'eqk7e84', 1696040665, -918331127, '2a97rjxw', -1815557120);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483415, 570731963, 'xt31', 'tri_12b437', 1, 'fa8263fl', '0t45u88qy', -1027619455, -2090219293, 'h', 46903249);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483414, 1408612275, 'bqei', 'tri_12b437', 1, '088khrqgoll9', 'fnf5cvi7gbb', -1540019908, -644572096, 'io', 525716713);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483413, -1041151181, 'xmp8i5vjx', 'tri_12b437', 1, 'uhxluan0uvc', '2b8', 1383214422, 2096882721, 'v3auo', 1915480284);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483412, -336659164, 'ly9gzhscjd', 'tri_12b437', 1, '2ox8zsrsj0b', '6hjs43d', -1456557225, -355401148, 'z2i', 1466665262);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483411, -1152284446, 'uw', 'tri_12b437', 1, 'ahi', 'z6f1', -1997830383, -1371370199, 'sk1nux', 633328793);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483410, 832305042, 'vgu6c7', 'tri_12b437', 1, '3t3', '5', -662635375, -302220701, 'o5z', -41965153);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483409, 192018314, 'th3x', 'tri_12b437', 1, 'g0693dxk58s', 'dldy', -1750947013, 1063944999, '2pg', 834391295);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483408, -594372098, '8cgtz', 'tri_12b437', 1, 'lspop9', 'n1', -1367446108, -833013953, 'bdu8z', 677426617);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483407, 1246248363, 'mravifac', 'tri_12b437', 1, 'hb66wty8', 'gk2sdi8g16', 100007068, 920427266, 'nuvsqmvjj1', 1201698140);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483406, -2137197666, 'dcd031', 'tri_12b437', 1, 'ailh5lxrh6zu', '3', -1630182791, 1993092280, '5bqyvo', 1256356713);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483405, 2009246177, 'ei77', 'tri_12b437', 1, 'giae', 'shu274o', -99231864, -88243376, 'ot4uhmigyct', -873957793);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483404, 51928551, 'hq', 'tri_12b437', 1, '3torx8zl0', 'b2zrgo8', -1762880032, 1933913289, '4e5sxct', 549522059);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483403, -1441746780, '016ljcvy', 'tri_12b437', 1, 'jegc8dmdja51', '0mjt9okhabwi', 410879219, -1071896171, 'yo5s1d', 780908370);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483402, -261621557, 'ppuz', 'tri_12b437', 1, '4rc7wz', 'rw3obhsi9', -1084583380, 671525387, '1cdfdwpm', -2042208196);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483401, -386852259, 'jqlbjkj', 'tri_12b437', 1, 'lbvddjyb7', 'q0c043', 596320950, 362754563, 'alut4tg6gen', -451580049);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483400, -1151101025, 'n', 'tri_12b437', 1, '5wg', 'aw7v0g', -861185151, 975313441, '2kpnu', -657742225);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483399, 1369494745, 'rsr93q', 'tri_12b437', 1, 'k4549i77', '9', -1242034460, 1561331834, 'x2', -1564646234);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483398, 257545383, 'qauv', 'tri_12b437', 1, 'd5nsmyb', 'hu4nm', -1512679483, -974732319, 'y81m59lwa3', 1879715547);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483397, -482006612, 'w', 'tri_12b437', 1, 'yovweso', 'l2f', -572345313, 20459424, 'k', -1627356889);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483396, -2088786220, 'kd3qyrnemc7', 'tri_12b437', 1, '10pj', '9', -1291584147, -2070403816, 'xmvs1ejr', 2002106829);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483395, -1969923734, 'kjw', 'tri_12b437', 1, 'fdjth0', '4y9u9z8e', -948457821, -1319751102, 'm895zhayllg', 191944482);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483394, 1812779422, 'nm1yh42qzz4', 'tri_12b437', 1, 'fenoz', '4hthz71', -1693091413, -626583369, 'ws', -977897298);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483393, 513469201, 'tg36ik42sp', 'tri_12b437', 1, '2', '5le', -614122296, 163272269, 'vvpwfirw', -844000336);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483392, -1963030207, 'ajzm0bq5sga', 'tri_12b437', 1, 'pb33izoxtgd', 'xwgt0', -741721106, 1495515983, 'ri3wwm', -967737939);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483391, 1442605365, '4nbx', 'tri_12b437', 1, '4', 'g', -795900241, 656009524, '3glq80o3', -2127009375);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483390, 1772506638, 's4x1x68oq3n', 'tri_12b437', 1, 'w8phn20pz', '6d', 936907637, -205580361, 'eglm4xlmxang', -1990986041);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483389, -1605637168, 'p93ukz', 'tri_12b437', 1, 'dt11owunen', 'kuq', 695028848, 1643888747, 'c', 1505489420);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483388, -1918873473, '0c3', 'tri_12b437', 1, 'mvhuo7x', '4rtoyhpoa3dv', -759061234, 912783278, 'hq7i', -999768437);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483387, -680600659, 'g0tngj', 'tri_12b437', 1, 'glys', '1jxrd', 2068847196, 965848740, 'wv5', -1709262606);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483386, -2042594690, 'j4z', 'tri_12b437', 1, '83s', 'v4r0dfemfx', 2084270157, 79610008, 'ykkee454w8j4', -1440187923);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483385, -40243302, '4ipghh', 'tri_12b437', 1, 'nutbva', 'ahaennxb', -284958081, -2003019636, '3', -522630408);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483384, -1860046249, 'h', 'tri_12b437', 1, 'q89ye3', '5l05o7x7kuof', -2045963315, -1505041337, 'qyib', 8401784);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483383, 888907552, 'brt0h54u1r', 'tri_12b437', 1, 'fpo', 'f49xmp85', -1967429001, -712447101, '3g', -405527738);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483382, -523766967, 'p', 'tri_12b437', 1, 's529wi8rde3', 'iit5r1svlhl', -564868991, -1466235277, 'udp', -1958034433);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483381, -723075109, 'nbkxn', 'tri_12b437', 1, 'x4z8rm', 'qeh5y', 1834664181, -897218401, 'fba44oi', 802132454);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483380, 1955424165, '0omn2', 'tri_12b437', 1, 'fhia5jkb', 'daop', 1247106238, -259324743, 'qh9ybawpsy', -1703195022);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483379, -457258695, '8enm', 'tri_12b437', 1, 'vo4aqq', '0fn', 191180162, 1205008883, 'v3dkr4e', -1947343845);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483378, 1095134296, 'yhfz2a', 'tri_12b437', 1, 'kgkbw73tbcq', 'bjzl8y', -1536387304, -1126485277, '8486', -273166812);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483377, 1527190499, 'bc0hk8ma0xt', 'tri_12b437', 1, '7ctq4dr6ioda', 'e64abr', -1046652383, -1582228211, 'dw9my79b5fjh', 657017017);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483376, 2005719206, '3jtyjq', 'tri_12b437', 1, '73kcem41o1e', '3zg2qkb2', 122042162, 1764124141, 'sx', -1993402693);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483375, 1191588775, 'pmg786', 'tri_12b437', 1, 'm6n', 'pta', -1822800140, -1035848785, '04ua0cakn', 938577425);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483374, -1527869658, 'up1zrpxes', 'tri_12b437', 1, '1j', '62vptoo6h2', -2104524092, -966148364, 'gs6l9', 876323977);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483373, 205424007, 'l5mg4', 'tri_12b437', 1, 'jacyuwq7xb', 'torb', 1313609104, -1994757202, '7pw1pr', -1789232128);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483372, -838211954, 'vuznkrmn6', 'tri_12b437', 1, 'q', 'e0b22p', -1756664083, -864467297, 'it7uk07k8u1s', -854289298);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483371, 435048161, '3e', 'tri_12b437', 1, '6vvk', 'qudzb8g', -1099748125, 379677470, '2kb1t', 706374510);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483370, 856999970, '4oenm0m6', 'tri_12b437', 1, 'fhp', 'gcmmv', -1689369724, -1142020819, 'r', 442620140);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483369, 1839217729, 'e', 'tri_12b437', 1, 'xt9elresi', 'axj4xv4d', 216904046, 848054614, '6xq0qr1j', 1603717664);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483368, 553176407, 'm', 'tri_12b437', 1, 'uoy5i4', 'idksy9c8', 189406838, -968544381, 'o8vi', -1540277438);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483367, 1474782699, 'jooin', 'tri_12b437', 1, 'acitlrilc', '1ivv2tsh1ssg', -490272719, 20515340, 'mgnkulyz', -915189769);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483366, 117051420, 'tzzg96dm', 'tri_12b437', 1, 'rbn18ptrqi', 'g5', 497183252, 535715591, 'ex6rybzyg7bj', -1945008317);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483365, -1999060793, '9ab5lf', 'tri_12b437', 1, 'ck9l', 'g', 274358254, -1379248188, 'w5x', 610230632);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483364, -1440497642, '5x8kv9nn6i', 'tri_12b437', 1, 'wanwyrkv', '7m', -1532313748, -1875799752, '603mq4h4bqmv', 966798161);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483363, 861491123, 'q5wf8', 'tri_12b437', 1, 'm6hp6g5fs', '1vw45nvt9y6', 1844408588, -1880425614, 'onit', 2041504163);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483362, -561223796, 'qu8h5g53abl3', 'tri_12b437', 1, 'pj8y9zkj', '6cd8ar', -1543141417, 1181424603, 'tt', -896484383);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483361, -2080615472, 'aybfo6rof5th', 'tri_12b437', 1, 'vlqta5h', '9yt58t3stce', -4883102, -1592589675, 'hi1ygb', 741848626);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483360, -24908964, 'pmy', 'tri_12b437', 1, 'hq4ztwx', 'm7ac10lj', -243068364, -1591833119, '8w', 1559285515);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483359, 197201095, '8', 'tri_12b437', 1, 'g85wt8', 'p0vw', -709520998, 890942568, 'jz', -507277594);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483358, 331121075, 'iul1s1lm9o', 'tri_12b437', 1, 'cl', 'vk32', -120223910, -1255521231, 'pq1d4u9jyfj9', -1039737999);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483357, -907266268, 'p', 'tri_12b437', 1, 'q', 'hto', 247241137, 1043245932, 'rgm3', -1596384067);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483356, 698163312, '3', 'tri_12b437', 1, 'po14nim5', '5rh9a13', -737085463, -1069402614, '77', 1528279783);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483355, -1406689341, 'o4bzlvhzy', 'tri_12b437', 1, 'u4cpa99jn', 'jo7kzay89y', -865550674, -1174316772, 'kryl3crkur', -51165510);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483354, -749302735, 'jn', 'tri_12b437', 1, 'a1qsg85c', 'te', 896910021, -2101983323, 'q1jn', -662608679);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483353, 1902311005, 'ba2d164y', 'tri_12b437', 1, '9ew995', '6v3', 685261436, 71999874, 'hcy', -899073097);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483352, -1312339657, 'kw6lah1c05', 'tri_12b437', 1, 'kvw', 'bz', 218555772, 1121450049, '7f', -2018142211);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483351, 1849192482, 'tz7dr8nv', 'tri_12b437', 1, '1q5', 'jfj', 593911233, -477242270, 'u7e7zad', -1084152942);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483350, 1109797514, 'wya29', 'tri_12b437', 1, 'c6m', '0hnns1y0', 963413602, -424393693, '3wqp', -1995113105);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483349, 19213328, 'aqs', 'tri_12b437', 1, '7bp2', 'mcdro0', 1704266860, -1854074429, 'ywwel', -1178774858);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483348, -2050236048, 'vjm6', 'tri_12b437', 1, '35054e7ix6fu', '1v2sl5', 1133660743, 668882564, 'u', -755066786);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483347, -637833886, '66o759bp6rbv', 'tri_12b437', 1, 'uj', '7', -79502516, 1444558858, 'ssg', 1527325195);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483346, 1711049849, 'd8777', 'tri_12b437', 1, '0o5wdn87w5', 'w', 617980965, -840594053, '2zskkld', 162834702);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483345, 255040130, 's', 'tri_12b437', 1, 'wwml', '8', -1783484865, 379788287, 'nrf7hi', 1900442257);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483344, 984718883, '0jbw4micd', 'tri_12b437', 1, '6jvb3x4', 'wnybvcke', -425352668, 982936126, '4az', 2006072444);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483343, 1965600232, 'e7gidxr', 'tri_12b437', 1, 'k2', 'jobw1vy', -1225792476, 494366482, 't0py4bqtjgmu', 535790148);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483342, 2031201498, 'j4wsjy99', 'tri_12b437', 1, 'l5i6fwnue', '2uw8zyedj0rc', -1447705631, 864040266, 'c', -157856652);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483341, -970238121, '6h7tm76', 'tri_12b437', 1, '8y9hfdy', 'wpz1gqqpbl7', -805366872, -2147338694, 'vybc23rsmrdd', 498344754);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483340, 1007099555, 'b', 'tri_12b437', 1, 'v3dqaa91o4', 'z0tv4yxy1ai', -726126966, 481795153, 'lp', 2010995112);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483339, 1515485492, 'vm4', 'tri_12b437', 1, 'g', '2da7blsjr9', -340793527, -1465697055, 'e0e6gpkmjx', 900394131);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483338, 108317644, '53d5xb4n', 'tri_12b437', 1, 'p', '6nekh5qyz', 31563719, -303943698, 'mgegzq', 909797699);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483337, 986684555, 'od', 'tri_12b437', 1, 'qbde5iq20', '2o', 1311580022, -1485363210, '9vk1rn', 217119810);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483336, -905195531, '61b0o3vfvj6', 'tri_12b437', 1, '4hw', '554bih', -902625308, 1268432606, 'vmiysbfdo', -1754830723);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483335, 999686164, '10399', 'tri_12b437', 1, 'lfl69ejl89el', 'ko', 173424761, 1429102634, 'k6m3', 745501295);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483334, -288624170, 'vspfnb7h', 'tri_12b437', 1, 'gkun', '8ls0qp5nnb9', 1275254784, 1692321557, 'zp7es2a2uvk', -1286389573);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483333, -1438245795, 'ohvutdee', 'tri_12b437', 1, '24q3o', 'u5', 2019625190, 1686516751, '72ko0s', 646997759);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483332, 1100713784, '8ms1fvylf2', 'tri_12b437', 1, 'cnd3ubs5wch', 'z9i5u2mefq90', 10453110, 238575440, '8xm3ys8r8', -2114136136);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483331, 1805865934, 'ol8ejww1', 'tri_12b437', 1, 'ihfivs', 'gbff3m', 970444127, -1587042166, '3djbzkwt6ot', 1362773763);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483330, 1077908330, '20', 'tri_12b437', 1, 'r4', '28r', 1205957043, 1381074171, 'hjye6wr3i8', -1655169952);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483329, 1834801564, '1g1nq1lgmhu', 'tri_12b437', 1, '6wbulk', '4ncwiuj6ar7', 1687180109, -1722552996, 'y0fer7jrk4', 1447540100);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483328, 276252954, '703xj86m', 'tri_12b437', 1, 'h3gxygy6h67h', 'f1vk', 1683535654, 1071635897, 'box2you', -1819229849);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483327, -1631163096, 'jg', 'tri_12b437', 1, 'lr', 'f8noy6qgklx', 445011323, -760126643, '6db1yig3c', -712524873);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483326, 1154052371, 'hvnv', 'tri_12b437', 1, 'hm8mlmbf6', 'jkoc7ttk2r', -1309776906, 1604095470, 'h', -537631851);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483325, 1059253306, '1de1f6shhg', 'tri_12b437', 1, '0ac1b', '0mggzg2', -180563023, -433485617, '8ziuv3k6', -1642739212);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483324, -309724744, 'h8dcjjhdxixn', 'tri_12b437', 1, '2m05j6d0', 'wjk6dj1w', 1986948485, 1367640720, '22mrll3mdx', 506516231);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483323, -382396637, '77xporyx', 'tri_12b437', 1, 'f145s', 'cmmn2oxsyoye', -1262551149, -1088681376, 'r', -1891749830);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483322, 1824840048, 'y3wmy8ef1b', 'tri_12b437', 1, 'tcgl4bzgm1', '5cfed', 1788295433, 1137987393, '0rgem6w', -688900015);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483321, 1435579129, 'hhfgxi', 'tri_12b437', 1, '2pnx8y', 'q1ir97b6pr', 5064319, 236308214, 'fdo', -581283516);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483320, 1373886335, 'zx8p2qb', 'tri_12b437', 1, 'y8wntf56l', 'wg6', 2112031593, -1011946523, 'riewk', -680649356);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483319, -1677581686, 'm84o8g9o', 'tri_12b437', 1, 'wo3w27', '8', 1069954409, 1636454013, '0m1', -416708380);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483318, 261215698, 'odut4o7r', 'tri_12b437', 1, 'fs4', 'xn2v33y4x', 1236953672, 1576025191, 'wq', -1784423463);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483317, -500768859, '66819a0m', 'tri_12b437', 1, 'dw', 'vo6q6t0x8', -1822687520, -1330330694, 'fsr0f', -11708153);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483316, 2062358548, 'h1eo8u', 'tri_12b437', 1, 'let9ux', 'eapttmihir8i', 1461758970, 763516354, 'tw1', 572225846);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483315, -447578967, '2mwsag', 'tri_12b437', 1, 'vnbie', '6mi36cx', 213977435, 1484248210, 'c1t', -1490259637);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483314, -69588373, 'v6436zuz', 'tri_12b437', 1, '4lywzgnlisfj', 'lku1va', -229543549, -1589723604, 't03s3gp', 1918146931);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483313, 338979048, 'trxnoe', 'tri_12b437', 1, 'yit6yaa1hk', 'io316whwdb', -1854448212, -1826847025, 'b', 1755611316);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483312, 2133989280, '2v5', 'tri_12b437', 1, 'b', 'h87by', -1864100934, -1016982477, 'l5hy', -2007651179);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483311, 1975949888, 'rkfy0hkg03j', 'tri_12b437', 1, 's8l', 'zydp91a8jk', 1976919616, -265424723, 'kfah', 787915035);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483310, 1368884555, 'xpqr', 'tri_12b437', 1, 'uwn2axp', 'mztetm', -801847470, -947564852, 'phsolxebf5', -1551071653);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483309, -1298685440, 'l', 'tri_12b437', 1, 'p7saxl2a', 'vegu', 850605, 73761210, '2', -919835558);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483308, 870891637, 'gnom', 'tri_12b437', 1, 'k0r', 'uqtprzns3n', 314921925, 1151105270, 'eqww7pxblm', 377856265);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483307, -1518392401, 'umdrp5', 'tri_12b437', 1, '3r', 's0re8ef', -1320181724, 1275552757, 'zt0tu2', -1937956909);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483306, 1562566175, '527siqxo', 'tri_12b437', 1, '4nizw27d0btn', 'a79wy38or', -832453864, -1694931515, 'p5f4ye', 1110166561);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483305, -724175537, '6qu73', 'tri_12b437', 1, 'wybez4wd20', '7j5lpwg', 1602080647, -953973897, 'o5ppm5', 1565764695);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483304, -715543484, '3sw00wytue', 'tri_12b437', 1, 'w7', 'xika', -774404527, -1727692101, '51', 635097784);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483303, -805435576, '17', 'tri_12b437', 1, '87', 'bfycosw', 991494182, -1156265029, 'hc9vn6zso', -1611526583);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483302, -2020862840, 'b1pfz89j1tk', 'tri_12b437', 1, 'dwbhcgin', 'ur84', -759337528, -795240855, 'uh9i', -1943518321);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483301, 1002689175, 'q341', 'tri_12b437', 1, 'pyod72', 'tcahq844s', 1778335039, 1609382296, 'eqd7ya2', -834731253);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483300, -493079795, 'eu55kolswk', 'tri_12b437', 1, 'skyupn', 'j', -1654268453, -1409166812, 'zpn8g', -1210428149);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483299, -1010355048, 'zc2n', 'tri_12b437', 1, '5cpuskip', 'tqz', -17059317, 112812615, 'uhuvt0sriiv', 412942979);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483298, 562149870, 'yy75y7caqidm', 'tri_12b437', 1, 'd0vrjoh', 'swk', 2098465081, 2094297153, 'q5o7hy42695z', 1485533173);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483297, 2056806266, '126nzbmcc', 'tri_12b437', 1, 'ya34w', 'h', 756763739, 779697554, 'dit', 51723575);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483296, -550329680, 'an24pqor4k8', 'tri_12b437', 1, '2fwu', 'kqixpiifc1', -1028507378, 1041055488, 'e3lh4qey4nq', -1575885024);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483295, -453595149, 'znoygw', 'tri_12b437', 1, '9l3n5mqvv8z', '6igs', 1268601041, 1151814837, 'm5mrh3t', -978938239);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483294, 1982078418, '88cjl', 'tri_12b437', 1, '3ofmf1eerkk', '6', -2113383001, -1260095829, 'zp7nz2', 1330093254);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483293, 1601045860, 'cwiy8q55f', 'tri_12b437', 1, 't', 'cz34f', -1956626215, -229850687, 'n0z', 1087477036);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483292, -14104207, 'f7w5w', 'tri_12b437', 1, 'htftahgvc', '00db2l', -32340836, 1453376502, 'ppyn6', -2047781785);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483291, 1374228625, '1mvol5hbr5', 'tri_12b437', 1, 'zn', 'u48jesh1ts7', -787852563, -762475677, 'kfpt', 430746342);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483290, 1910400178, 'cz0t81bo', 'tri_12b437', 1, 'cwbxki8ejo', 'a', -1407347764, -55817194, 'esy', 891172824);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483289, 838196284, 'lxdjdb', 'tri_12b437', 1, 'kwn', 'cnn6p', -970611568, 1818325597, '6', 5155986);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483288, 484224748, '28dguot', 'tri_12b437', 1, '7', '2llci3yqlxqa', -252519286, 535426848, '3zfstt', -1759146091);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483287, 935409151, 'mp1bijg6hmdm', 'tri_12b437', 1, 'bdkpk', 'qt', -2083255326, 1272522674, 'cp244k', -447133796);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483286, -807437295, '23r', 'tri_12b437', 1, '5xmrc0la', 'bk5yuo4c', 1923271127, -1996353677, 'co6', 310938316);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483285, 697204478, 'ryw', 'tri_12b437', 1, 'jslc6ce', 'rtvbih', 1267323339, 1161937190, 'k7m1a7dc9eq', -1193336303);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483284, -1295297724, 'x22z1', 'tri_12b437', 1, 'hcbf', '4g4ocptix', -1722078563, 755824640, 'x6eb551c', -574108956);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483283, 1506966957, 'duedx4', 'tri_12b437', 1, 'b2', '2s5ay', 697597771, 783551781, 'ovpy0wmgpf26', 426460393);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483282, 1612099199, 'a950i1lvdwg', 'tri_12b437', 1, '26nnsig', 'nm', 1069968656, 227223706, 'g2a4jjnxx', -1354211189);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483281, 2060353650, 'xeq4vnarx', 'tri_12b437', 1, 'eagcovn', '42', -1295217, -2008296949, '4cl8c', -1781489856);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483280, -316816738, 'gh', 'tri_12b437', 1, 'sm8006qd', 'g4x2pf', 634405922, -1023016938, '1prx', 821211211);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483279, -56312079, 'df1fx42f', 'tri_12b437', 1, '2hh', 'r', -2130237587, 1764574260, 'op0nfcg', -623343583);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483278, -653950610, 'eplqhbkat9', 'tri_12b437', 1, 'trus5yhp2', 'jm67vfjo1u', 1429939258, -465172356, 'yxp3hd9c2rh5', -1850673497);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483277, -1724456709, 't6w54', 'tri_12b437', 1, 'e9qyu', 'vgs', 2098641679, 1454993900, 'fgrf', 1824989957);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483276, -1362876736, '8l2lz5shjy', 'tri_12b437', 1, 'l2ja64t834', 'q30', -1162447557, -39445824, 'iyopkuienoeb', -125731633);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483275, -323543163, 'a490yz', 'tri_12b437', 1, '4rupd9fzr5', '7p', 107090809, 458997690, 'np11t8v58mj', 1873748354);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483274, -1779378262, 'rp24u', 'tri_12b437', 1, '587m5d126qc', '1', 1248923115, -896868807, 'zb2', 2083610682);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483273, -1032675561, '3oly2', 'tri_12b437', 1, '2', 'q6mji', -1382170728, 1168200657, 'kdw', -1921109403);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483272, 1196899871, 'md72do', 'tri_12b437', 1, 'wp', '94pm', -296020658, -1297644490, 'yx', 84034005);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483271, -2131260911, '0s8942lw43', 'tri_12b437', 1, 'ctlhh', '4a5v05', -1625790521, 225087593, 'gl', 1600220494);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483270, -907606535, '61ty8o', 'tri_12b437', 1, '97u', '8i5zpvgid9', -522443123, -1600525032, '6h7orfrc', -1478676009);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483269, 1660644656, '804gwqw4', 'tri_12b437', 1, 'zo1b6', 'eb', -908225665, 687335715, 'c01', -386821220);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483268, 12346400, 'zy', 'tri_12b437', 1, 'ny', '7slmw81o2b2', -1060240984, -1142491769, 'rv', -1266739039);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483267, -885571364, 't1m9mq', 'tri_12b437', 1, 'n5hhvm27s', '3b7mat1t', 1982414010, -795920972, 'wiy1nn0g76ug', 1063803);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483266, -206873092, 'ss0', 'tri_12b437', 1, '6p', 'p47npe', -248925756, -936783573, 'l8', -174972883);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483265, -1195204245, 'fdh47lr', 'tri_12b437', 1, 'az7e6s88', '1', -1827844505, -1444296441, '39kgvo', -2043929466);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483264, 1751298245, '76os945s', 'tri_12b437', 1, '9y7jnsdo6', 'qc003t9yb42', 963170654, -1797760914, 'addq35zk9bxg', -1996160054);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483263, 839967171, 'ohc3cpczihri', 'tri_12b437', 1, 'mg', 'uwb5i2wm0fz3', 1162846313, -1989357824, 'gp8qgbwm', 820741900);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483262, 88011866, '10c66cme', 'tri_12b437', 1, 'lw0s', 'e27f53wo6', -882222474, 550752627, 'rlhh', 804455269);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483261, 1822476636, '7pez', 'tri_12b437', 1, 'jthtmy', '92uue7', -1057489990, 926091597, 'lh3pow', 582559183);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483260, -467745219, 'i', 'tri_12b437', 1, 'fesnmuep2wti', 'o6k989cm8', 363764869, 819573616, '1kyfq3jdq0', 1378812550);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483259, 861253940, '8', 'tri_12b437', 1, '9llpglowgl', 'vdhbl', 953940983, 1783833388, 'g8zfdmy62', -5143941);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483258, -884040380, 'ritekz8hymkw', 'tri_12b437', 1, 'vw', 'lpuqi', -1170716149, -1122241678, '5w8', 881479258);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483257, -715347208, 'vt6u81hu8', 'tri_12b437', 1, '6yafgv', 'bm6', -932604798, 1589067104, '2xt0mw', -190002322);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483256, 1787517671, 'rq79093ab', 'tri_12b437', 1, 'ls', 'lmm19', -13831786, -32274361, 'otntuaj5', -1134828281);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483255, -1338846679, 'bohdjuck7c2', 'tri_12b437', 1, 'jk', 'x3r1qprr', 682902243, 1005847075, '140gkq34', -1329222456);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483254, -1489593846, '4y8pgto9', 'tri_12b437', 1, '81p', '3odz6', 632756391, -881344901, 'hllkkxrf', -1066832888);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483253, -450519098, '2b5cwe16z', 'tri_12b437', 1, '7htlehty', 'h5boujahdx', 1570630923, 659318101, '3chn', -472088340);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483252, -1690183533, 'aaz', 'tri_12b437', 1, 'pc8eqeqsf24', 'bl61m', 884928726, 1842659551, 'z0m', 672477728);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483251, -33155746, 'enqf', 'tri_12b437', 1, 'aqqdyv', '2', -1722879908, 1165189921, 'g', -659677392);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483250, -1225677839, 'hwbtes1xf', 'tri_12b437', 1, 'r3', '1xa37', 52680605, -2103779676, 'wz86ltjdtj', 1792218152);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483249, -2008361061, 'jj34z4v5xy', 'tri_12b437', 1, 'kjb3tw', 'sm', 1062741878, -1638451733, 'r1k', -2074716691);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483248, 94103867, 'qp', 'tri_12b437', 1, 'mqic', '05', -876344849, 1261652027, 'gca103jhsuu', 303505673);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483247, -880991319, '27', 'tri_12b437', 1, 'r76r8iscn', 'n7x5r5', 1492978048, 65377819, '79bqio59', -13758928);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483246, 1541696686, 'c', 'tri_12b437', 1, '1rur', 'ib3hv08ltb9l', -389639005, 1776784660, 'fcip7geck7', 1831483821);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483245, -346826734, 'rc5fecw6n5s', 'tri_12b437', NULL, 'wq', '8sf', -1633622147, -323697017, 'dma562twe8ob', 942932761);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483244, -1296417394, 'ni8w', 'tri_12b437', NULL, 'm53', 'n7mpy9dmm', -1601089346, -455784271, '0oytsbppj7', -1097207121);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483243, 2020775283, 'sgkz', 'tri_12b437', NULL, 'ip235fsta8', 'w1hob', -1659230946, 1962966909, '8l9d6', 546266675);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483242, 452602850, 'nxu', 'tri_12b437', NULL, '5', 'i6vzwip0m', -50835551, 1869054128, 'rsjtcv4qdq2', 38771107);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483241, 687248878, 'z', 'tri_12b437', NULL, '519', 'k6i0', 223627143, 555827074, 'kcymozk9h', 954690168);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483240, 1583168814, 'r8', 'tri_12b437', NULL, '9163a4dz7eyo', 'qo8kmsw', -320883618, 1761505938, 'gq2w5p', -304080868);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483239, -303976209, 'acn5gbu4pc', 'tri_12b437', NULL, 'iuiv', '6d062th', 2063257969, -454190622, 'kz6vs67k459', 736580148);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483238, -605013388, 'mkv', 'tri_12b437', NULL, 'zgb8fiyx', 'o40ggil46', 522002198, 443287106, 'xr39a5j7', 458431481);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483237, -1939087535, 'dwkyw6e5p8u', 'tri_12b437', NULL, '4roq', 'kx9e2blrs', -1781294542, 1611372152, 'mjtr5q7i0y', 1386559203);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483236, -1370196605, '3ifpba9fcvm', 'tri_12b437', NULL, 'ussioj', 'f87tzjq', -1939191796, -1418387121, 'mn7suu3eznq', -1480201065);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483235, 1913505339, '1aknqs3hytu', 'tri_12b437', NULL, 'ti', 't918no6td', 798567448, -276207432, '57aw6orkqonj', 974096862);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483234, -835463987, '3oe1jw6jfd78', 'tri_12b437', NULL, 'vnrochrkut0', 'pwseq8uhw', -490628993, 1428117826, '7gri1zpd', -1751069533);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483233, -374233377, 'to', 'tri_12b437', NULL, 'ssxtjt0584ze', '410sw7bvyxsm', -1840273488, 1098542537, 'ex3gs0o', 1993879946);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483232, 1902706426, 'h2mmy', 'tri_12b437', NULL, 'q50', 'qrhdot92koc2', -937806843, 770633349, 'gijk5mon7', 1405337839);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483231, 680187789, 'v3', 'tri_12b437', NULL, '5t6xfgf5y9c', 'j6lhmcpgs3', 617132600, -361510214, '86wjo57', -1641466681);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483230, -1779668654, '2psyv2', 'tri_12b437', NULL, 'nj4b31i', 'lgmdohh6woko', 349812024, -1521786284, '7zg6', -118818543);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483229, 615166619, 'iie5r', 'tri_12b437', NULL, 'lxb2zarp', 'fu6g46xm', -1577312830, -1740013074, 'm00u3loa7b4', -1468988546);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483228, 359852655, '1csx6', 'tri_12b437', NULL, 'iq', 'p568fysmu656', 1436580680, 769377357, 'm19mmpuw', -750866728);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483227, 273492332, 'pwi44', 'tri_12b437', NULL, '7if4tia0czvu', 'w', 1293895143, -1903676100, 'm7', 1515721057);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483226, 1386769862, 'xef3li3ipkut', 'tri_12b437', NULL, '44i8v7y0', 'h7dkcyz7l48e', -348086413, -16902757, 'bj5lux', 1545774314);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483225, 413681204, 'kr9', 'tri_12b437', NULL, '9xla', 'p92v5ckigzaq', -275591409, 733704639, 'gwhkuz5u', 397897719);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483224, 1295847427, 'ho2', 'tri_12b437', NULL, 'f3sz', 'j2yebiln', -1325669325, -992652787, 'e', 325684373);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483223, 839513803, '0', 'tri_12b437', NULL, 'ljn', 'xk8mqnrt7j', 1638845238, -1654701011, 'bvh8kn5', -1653459500);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483222, -1024609910, 'avdl', 'tri_12b437', NULL, 'pt4i7', 'xs3t3', 629795967, -1470527937, '7bno4grg10z', 1248451789);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483221, -1096347095, 'hdz8', 'tri_12b437', NULL, 'uoqjahjwvc8q', 'rc', -259928605, 2056103916, 'g', -943974196);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483220, 1272577780, '5uk', 'tri_12b437', NULL, '61uc5n', 'u5q50lihh', 494622735, 128109565, 'ojrl', -1779329393);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483219, 1772687919, 'li07', 'tri_12b437', NULL, 'fmgdx3', 'r', -723168006, 1964289448, 'grrztiox', 222246301);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483218, -1620336430, 'xjwfkm', 'tri_12b437', NULL, 'i2nq', 'goyuznopf43', -1974152535, -162680121, 'wwu', -1536539553);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483217, 1219758373, '8uha', 'tri_12b437', NULL, '67ks38chi', 'elxmg', -625733555, -1681153347, 'qt4cxkzyu90q', 1971105235);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483216, -1923863828, '4212bsi9cw', 'tri_12b437', NULL, 'u3jdcf1f8', '51ohr9hbk', 153008252, 2097717071, 'ye0z5', -808645819);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483215, -544953005, 'kr7msz9ja95g', 'tri_12b437', NULL, '5c3yc', 'ye', -515468862, 61219972, 'v0v5zj04n2', -710899641);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483214, 793810114, 'qdviaxj', 'tri_12b437', NULL, 'qadelmmrtje', 'b1ggruk00l', 562882871, 205737392, '054lz5', -27890711);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483213, -1741700516, 'r', 'tri_12b437', NULL, 'qzhk', 'm4laax2ck9u', 1567655194, 298551079, 'ohmpzgilzea', -1185039975);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483212, -1923992838, 'kp', 'tri_12b437', NULL, 'iraw0rmlrf1x', 'ijjhlftsvf9', 848843391, -1299484102, 'tonu8smdeg', 535171702);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483211, -281723799, 'cai1nno0m6z9', 'tri_12b437', NULL, '5rxn73g3', '71yj0', 303975581, -1138948594, 'fpye616l8', 586232825);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483210, -291904636, 'yzzz5iutnpgk', 'tri_12b437', NULL, 'nqe0', '8phsw6', 27242638, -786579875, 'ewmn3rzk', -256669780);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483209, -1520250736, 'kh8u', 'tri_12b437', NULL, 'c04p5deuhmw', 'y2romf', 1268847373, 1796303889, 'du6oxuc', -7711800);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483208, 2096525533, '9r', 'tri_12b437', NULL, '48927uvw', 'x2qqhjz73', -4817084, -1852633567, '3nm8dmp', -1439542559);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483207, 1918656311, 't6832v', 'tri_12b437', NULL, 'kdmuow70', 'cevdmx', -2030462719, 152245485, '9vl55jsozefe', -532015685);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483206, 1074460419, 'nnumr811', 'tri_12b437', NULL, 'oijm', 'ghb6rt', -1250264775, -739941236, 'gqfpd7fgsh', 206349680);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483205, -516274215, 'x', 'tri_12b437', NULL, 'pdwjzqiw', '06m3zq3dxf', 994397381, -209237685, 'fzfvy', -42849610);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483204, -1965485940, 'hq65odnmrebk', 'tri_12b437', NULL, 'j03z', 'fw3', -484183855, 2136952772, '9vqb61d2', -820818750);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483203, 24750051, 'u7ni', 'tri_12b437', NULL, 'jv4ybr', 'bb0xfml4q', -733950398, 1034940230, 'e', 1226619841);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483202, 422607258, 'q7t', 'tri_12b437', NULL, 'hw6m6', 'lpf', -1885750641, -173678797, 'jdk8c35ozc', 1615134597);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483201, -829545011, 'ar', 'tri_12b437', NULL, 'tgg5kcz0j', '32ykl5gt1u8', 276575763, -1052626588, 'a1mslegd', 402107474);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483200, 1270236586, '1o9zzrk4wc56', 'tri_12b437', NULL, 'ax9o23a233cg', 'xc3lqdic0', 1214563815, -825394995, '25kw5', -1182646357);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483199, 16959762, 'ock1njai9', 'tri_12b437', NULL, 'lljhr', 'b2sz2mj', 243182395, 2084584523, 'x5t', 2137149087);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483198, 162036473, 'lebon06n7n3', 'tri_12b437', NULL, 'gvaasdtml', 'z1t', -554361278, 1562440539, '54v0dn', -1117938828);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483197, 383866384, 'gnp0onxtvt4', 'tri_12b437', NULL, 'r7xiqx', 'yf6b2', 862798541, 1054529791, 'r14u', 1586311260);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483196, -421961353, 'bs06', 'tri_12b437', NULL, 'nlx2', 'wcs4s2c', -989670558, 2135759996, 'mjxz7hk87', 874521787);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483195, 1183573832, '2lqbo8e', 'tri_12b437', NULL, 'ovw', '946he', 1851901676, -560898199, 'u6u', -258371344);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483194, -1323481, '4fgg', 'tri_12b437', NULL, 'apry8ixa4d', 'ol', 894604433, 998447794, 'bgrvbnnws6w', 1055906508);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483193, -1899710660, '83cz65gr', 'tri_12b437', NULL, '7', 'rm', -1409999604, 280110833, '4oq6d0', 838530815);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483192, -1289579420, 'br5b3', 'tri_12b437', NULL, '18nms', 'twkt3x', 1897183605, 1780810958, 'azr0x', -1943130893);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483191, 1654865375, 'bt', 'tri_12b437', NULL, 'zwv06', 'e', -879086505, -712157479, 's0rkqia9rq', 199150377);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483190, -965817635, 'vjlghivqkw', 'tri_12b437', NULL, 'gt', 'hkc40ovifgz', -688714910, 442504630, '2ns8ak', 1548472219);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483189, 485908387, '0', 'tri_12b437', NULL, '8wme', 'rhb', 1750750662, -261961242, 'c11qsbmusa', -1143612096);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483188, -585973813, 'o7me', 'tri_12b437', NULL, 'xvorxg4jkeh', '20umr', 78970755, 952621665, 'xk2y4ufs', 440926607);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483187, -331056419, 'whr3', 'tri_12b437', NULL, 'akxxrbuhe', 'q', 783873127, -1636684433, '3b0k1x', 1307437815);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483186, -852008874, '4bg3', 'tri_12b437', NULL, 'ywo2x3myiu', '0', -198366875, -1136631233, 'yq4', -1918389092);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483185, 1572034782, '4ndigedb', 'tri_12b437', NULL, '2', 'ty', -1177087922, -1400487513, '5fh0h', 1327106136);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483184, 877437909, 'xq', 'tri_12b437', NULL, '0q9de1smuibh', 'aw3o', -685032582, -1353921634, 's7e3', 326597852);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483183, 845366630, 'uv2', 'tri_12b437', NULL, '53', '318ygd3kcxhm', -240039720, 682989567, '9ody', -740941987);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483182, -1062782659, 'c5lfr1y', 'tri_12b437', NULL, '6fwo5ah3n4en', 'j1dw', -818672321, -1702508820, '8xae', -320711228);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483181, -1141228260, '9', 'tri_12b437', NULL, '2793', 'i4eg7i', 1732396781, 1659782271, 'kwqfwb', 1422044761);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483180, 177226671, 'icm9k', 'tri_12b437', NULL, 'rvps', 'f', 1039747099, -580019922, 'qi32y', -718690595);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483179, 504769072, 'jkag7vy6tg', 'tri_12b437', NULL, 'xf3tf', 'bu', -1909439995, 737295917, 'ysd', -486742913);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483178, -283750194, 'ckwqf', 'tri_12b437', NULL, 'eq73', 'fr2n', -307196687, 2054699092, 's1ct6', 2091012856);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483177, -421315576, 'vcunqrkhm4', 'tri_12b437', NULL, 'oxsy1e', 'a8', -350279226, -1081939447, 'b21w8', -989877058);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483176, -1652496766, '9l5l3trx50', 'tri_12b437', NULL, 'cut48bzvo9j', '08slyl0oh8', 1113709137, -2099843638, 'bcj6l0s8q0', -1869649626);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483175, -94288616, 'dp6qh1fkek', 'tri_12b437', NULL, 'iiv2esq', 'rs6', -2075734902, -1244965259, 'yjwkp2cvc', 970685866);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483174, -2056005136, 'upy8x', 'tri_12b437', NULL, 'nosy6zxo556', 'yd', -37365334, 230917850, 'nto55', 597677983);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483173, 388448776, '6aho', 'tri_12b437', NULL, 'rd', '98tf8fweeoc', 937343917, 29542688, 'lgs', 783504412);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483172, 1023965983, 'lezgkpc', 'tri_12b437', NULL, 'x6gxnrf', 'cbi55akn5v', -314106139, -2037348799, 'nqxnfsq2c', 283578950);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483171, -1124291956, '546cxwdoh6wq', 'tri_12b437', NULL, 'cuu9', 'ga', -297532439, -1890999044, '84gdo', -449589925);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483170, -416228404, 'jb', 'tri_12b437', NULL, '8gx4c9', 'zorgry', -174873440, -500229162, 'mwykwhh3a7', -816962581);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483169, 1127141640, 'i01', 'tri_12b437', NULL, 'hiz', 'u7syms', -891915836, -1245721721, 'mzxcwsy2x1', -660623586);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483168, 2117974368, 'qfl9', 'tri_12b437', NULL, 'ycq11cbuqs', 'm', -976467322, -270095900, '0xkp3tsj7u', -577077845);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483167, -136190844, '4qqev3a', 'tri_12b437', NULL, 'a7ngdo08', '4ih', 1744241736, -1071225279, 'c6fh7zz', 1041496691);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483166, 1884491683, 'ymr0gknz9n1', 'tri_12b437', NULL, 'cxaq2q', 'zzxqvd', 250138015, 1097048203, 't22vn', 905780839);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483165, 1878819674, 'izkt1m7', 'tri_12b437', NULL, 'g4dpmomcj', '0h2ut5cpx', -1464603917, 1731522542, 'k1qbupy5b', -1707023230);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483164, 1972741416, 'iihemz7', 'tri_12b437', NULL, 'gi74', 'y5goua4', 293685972, 709540235, 'lgo3', 2138906242);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483163, -579079987, 'xo6', 'tri_12b437', NULL, 'ew', 'nc54tpa9', 375621815, -93855160, 'vkrsvm2', 670461898);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483162, -1987945606, '3wee', 'tri_12b437', NULL, 'hnz26sq9bz', 'qac1c85b7i', -83978351, -121053503, '1j', 1762057283);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483161, 1651777435, 'm', 'tri_12b437', NULL, 's9bjg', '7', 137919730, 85712613, '1t07qmgsd', -236816662);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483160, 802480291, 'dvbjiwechzm', 'tri_12b437', NULL, '1s', 't2e4bq1u', -654586311, -1636011708, 'zapaagk', -1613403973);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483159, -862830764, '2q', 'tri_12b437', NULL, '7s41', 'j3ro0bv', 932276679, -604639517, '0ihcok', 413439638);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483158, 635288041, 'r', 'tri_12b437', NULL, '82w', 'aragdm', -2127844351, 429942129, 'ar392h8jqg', 552591280);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483157, 1066052256, 'i17vat', 'tri_12b437', NULL, 'hqbiq', '7eozt0', 1462937169, -1756731975, 'ovvtnzb1r3we', -869212513);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483156, 760283194, '7q8m51dl3vv', 'tri_12b437', NULL, 'wo9snswds', 'b8eg88eg90k1', -1792293001, 1498619990, '4kl36', 549848628);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483155, 1609253221, 'yuquy95mth', 'tri_12b437', NULL, 'o590y38j3kj', '50f64', 1496706913, -2106572915, '6jv', -200876594);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483154, 549561781, 'd4di', 'tri_12b437', NULL, 'e4yhy093uwx', 'bbq23ac08ixy', 1570555848, 1787444578, 'ogi98', 942224711);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483153, -2041202219, 'mjm5u6kfh', 'tri_12b437', NULL, 'e', 'obpjp', -591129539, 1953696988, '31bska', 889715685);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483152, 2064531800, 'ptj8c0', 'tri_12b437', NULL, 'pyk', 'n2pbyp6', -1880174720, 1903292921, 'czrj07ncw', 1924175382);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483151, 1509326681, 'bgc29dwd7', 'tri_12b437', NULL, 'tg8k9ejq620', 'bkud3nc', -379606044, -1675226954, '0bdzk9jvd', -396261663);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483150, -752945256, '9psei0qfd20v', 'tri_12b437', NULL, 'avh0p9', 'yv', -28566494, 1867721583, '1', 1512704056);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483149, 587263874, '1ae3c4gylw0h', 'tri_12b437', NULL, 'eb1gp77hs', 'mgu8', 794442131, 1297999731, 'iu6wjo6', -2010798430);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483148, 1227183657, '38v0qu', 'tri_12b437', NULL, 'r', 'gghzkk5z', 571124889, -2098578864, '8r2bm', -1164561562);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483147, -541184901, 'qqt9dxkf7r', 'tri_12b437', NULL, 'nljmp', 'z78jdrzu', 1917543273, 1408487007, 's2y', 992039363);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483146, -1099787189, 'py', 'tri_12b437', NULL, 'pet0kjmwpgrb', 'c', 1991120785, -277730024, 'wrvu', -1262619998);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483145, 83549238, 'oc', 'tri_12b437', NULL, 'pnimpze', 'kydy28o2i6y', -1464443931, -1611284516, 'ss5zmgtd4', 1387537642);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483144, -1180422112, 'g', 'tri_12b437', NULL, 'mx1k', '66123mju5', -1543104783, -635124869, 'liqmi9v2p', -1097426477);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483143, 1692485004, 'zpukwdzn', 'tri_12b437', NULL, 'kpaduvbhi6we', '0lwv1pwg7w', 1584203057, -150356048, 'h86xg', -471240175);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483142, -1809884134, 'x', 'tri_12b437', NULL, 'p06bdt', 'brld8nyscdgh', 1616788912, 243651645, 'paeoj', 846908985);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483141, 1513295215, 'h1xtzhg4jx60', 'tri_12b437', NULL, '2u6d6v4v', 'i', 826957040, 1298973461, 'ceh', -1077391629);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483140, -590619470, 'f', 'tri_12b437', NULL, 'f6umlm3an', 'bqo', 1728334097, 2061517933, '9jsie674oz', -1776221270);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483139, 1104204226, 'dsbbnev2', 'tri_12b437', NULL, '1mny68vj8b', '3f9z', -204132650, 1617793755, 'a6ikznf9', 1525489433);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483138, 619376571, 'tgo', 'tri_12b437', NULL, '3k22pgpui2d', 'il6yxl4xci', -150660814, 1717459409, '144i6il8s550', -533484889);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483137, -316204169, '2nfcq8', 'tri_12b437', NULL, 'v8m6qneex8l', 'q2dn1uq', -2147196801, -766620396, 'q', -1527422771);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483136, 967631988, 'c01lna6bj', 'tri_12b437', NULL, 'rdc00sh3qr5', '2ato5cf5v2t', -1535188192, -1704035054, 'to6', -87285667);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483135, 1219953008, 'md7ryncce5h', 'tri_12b437', NULL, 'qysh8pf0qzpi', 'xaco', -307351107, 1663010439, 'tf9e7', 798422907);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483134, 1946356806, 'igpe', 'tri_12b437', NULL, '50ro3n8bnl', 'qwqadewdlv7', 936383435, 1675946706, 'g2n', -386306490);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483133, -1221943148, '32ligl4a', 'tri_12b437', NULL, 'j01l2', '63', 595959467, -1566726680, 'ws01p57j', 2120754820);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483132, 317923619, 'brh60', 'tri_12b437', NULL, 'vhncg64n4s', 'a72dvqdz', -787370578, 1763026819, 'fw', -179569276);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483131, 953607151, 'crb7le3o', 'tri_12b437', NULL, 'dmh7jmkl', '1xwric0t986', -1198483167, -1457209789, 'u0a9bn', 1569060979);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483130, -1448703534, 'j', 'tri_12b437', NULL, 'czd5r', 'rlyh50v', -1100619277, -854459206, 's', -136971813);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483129, -902748312, '2lsosp3', 'tri_12b437', NULL, 'hr6ma7e', 'c2o94fcw8in', 753642585, 1051280570, 'nmh8c5', 1276987879);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483128, -172434165, '5bj', 'tri_12b437', NULL, 'wr0x945e', 'ajjss0e8li', -500969364, 565684849, 'ky', -1899066934);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483127, 1033356389, 'hgrq7ur78fn', 'tri_12b437', NULL, 'w7xuyzbxx9', 'hjnwm6r627', -835629183, -2094272401, 'gez5d3kv', 40967000);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483126, 868577961, 'vnxx8t4ya', 'tri_12b437', NULL, 'a991qv8d', 'lbd9tyg', -2146057395, 573349513, 'y3e8i0pm', 1759329020);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483125, 1302618921, 'cbfloou', 'tri_12b437', NULL, 'ai81o3utrqwb', 'z', 412523898, 851238762, '4gqe93rjqu3', 890879173);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483124, 1415301317, 'a5zc7hjh', 'tri_12b437', NULL, '6oe2sn54x', '8h0', -687277053, 870384889, 'e4mfy8vnr', 115386392);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483123, -1880916234, 'c9csvl3ero', 'tri_12b437', NULL, 'k1', 'xoob8t', -1658996433, -1359238089, '553amo', 1731922216);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483122, 1745600876, 'w', 'tri_12b437', NULL, 'k7zxwewmkkp', 'pkvaszg6lh1d', 1380184998, 372486354, '1w5b4glb', -1540745606);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483121, -381930522, '7z', 'tri_12b437', NULL, 'tc6kq', 'otf', -1833836250, 691275641, '2w', 270500171);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483120, 336583811, 'q', 'tri_12b437', NULL, 'p61njip8d9', '4108ya97y0', -919979962, 208382857, 'c788', 1517678801);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483119, 1608015910, 'q', 'tri_12b437', NULL, 'ujmyecf0', 'fir', 1661953829, 1390691010, 'g4xg1', 592453890);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483118, 1046461269, 'd7brux0st', 'tri_12b437', NULL, 'js9ysrbtzv', '94oon95mm', -364702237, -1810256899, 'guxlay94s', -2014473306);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483117, 801734513, 'nusdal', 'tri_12b437', NULL, 'bamtqsw4n6pv', 'dyl2wfp3r', -317796656, 2001383317, 'phl', 918871403);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483116, 961127526, 'abzuno', 'tri_12b437', NULL, 'mx9r6s69', 'xdqvxiihv0', 1606683792, -1082587215, 'c2j0fju', 204533464);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483115, -448725950, 'rlo', 'tri_12b437', NULL, 'hss', 'i8eq4e1x', 654859296, -1953263399, 'jjrih2', 1617482676);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483114, 181238250, '0uq', 'tri_12b437', NULL, '7ll', 'vxztt', 1058140937, 1742917590, 'd', 1673485688);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483113, -1133958548, 'k067pnls6r2', 'tri_12b437', NULL, '2pvk', 'oahk7j', 1095775074, 762295705, 'tztvpfv8w00', -2090346680);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483112, 2119300608, '5fac03', 'tri_12b437', NULL, '12b', 'r5hseeo9s', 1163996233, 1476739121, '0p2ewl16', -1572293776);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483111, -821897909, 'wml4n1y', 'tri_12b437', NULL, 'd', 'yyap', -1723171114, -896665637, 'rbg4d', 887710920);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483110, 2134881245, '22xldyvqzixl', 'tri_12b437', NULL, '5dzmc1j2l44', 'y7syfay92u5', -1416540613, 695661102, 'smciuvm', 1007830230);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483109, 140456326, 'uy41fm', 'tri_12b437', NULL, '592it0ecwj9o', 'm918itsy9i', -236925368, 207054375, 'md', -1620864081);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483108, 1713185945, 'od', 'tri_12b437', NULL, 'a', 'l83ql0gc97', -840201372, 707645713, 'zz', 366622932);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483107, -1654498482, 'dyt', 'tri_12b437', NULL, 'baa3okf', '5', 943165690, -562523770, 'fvdu8fephi0n', -1149216366);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483106, 577584155, 'jl9kzhpmf', 'tri_12b437', NULL, 'b90b1ujev9', 'tq2u0gnq', 998699688, -748036799, 'y', 1658929328);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483105, -2141963206, 'bc6q', 'tri_12b437', NULL, 'a', '3h306', 1147226832, 1897021935, 'avy6su32pj', 74732314);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483104, -1075219300, '4yd6je93x4wl', 'tri_12b437', NULL, 'bkc5tw2z', 's23g1quk', -180251080, -1613461346, '6wosb913m', 1423922132);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483103, -20694218, 'mcldege', 'tri_12b437', NULL, '6uetts', 'rovrt9', 53531687, 907142886, 'r30ve46pc', 1307055945);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483102, -1446918289, '3fcm6d9kw5', 'tri_12b437', NULL, 'fjgz', 'df', 536454778, -2106256523, '5qigvd52', -279735781);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483101, 562763992, 'vklcna14', 'tri_12b437', NULL, '55qq8rq5r', '68u5ldzhzu', -1994223004, -34756788, 'lpl0o1', 798232092);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483100, 1344626152, 'acy', 'tri_12b437', NULL, 'c1c', '3ye3ttn', -2019803880, 1790783497, '5', -403239677);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483099, 1976126440, 'ovt', 'tri_12b437', NULL, 'jo35czjolng', 'ykbn3y20ahc0', 1188100556, -941421162, 'i4', 955147726);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483098, -56465756, 'iy1qgc2p5', 'tri_12b437', NULL, '63d4ook', '4', -902810541, 2072932981, 'pu0uzw', -900759027);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483097, 1035443442, 'nkds3a', 'tri_12b437', NULL, 'ecbahvnp50p', 't8jn1z2bvo', 1665733087, -1927765407, 'rdi3q2cbynb', 484382099);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483096, -2131333374, 'zomv8k', 'tri_12b437', NULL, '75fj52jelyvv', 'js7fkw', -1159407096, 77208431, 'goenblb', 1973414324);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483095, -859808188, 'n', 'tri_12b437', NULL, 'wohmvqi', '454z6e5g', 467813616, -165922939, 'x', 1095477640);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483094, -1388530358, 'zdqzo56vnzi2', 'tri_12b437', NULL, 'ys1lhlo4vnab', 'xomrbpe', 1057993368, 2114861481, 'po', 500132973);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483093, 695663322, '4f', 'tri_12b437', NULL, 'b80', '1l5sabf5q5', -1474146225, 247459706, 'gq', -272545320);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483092, -1661568718, 't3r22ucv1ef8', 'tri_12b437', NULL, '9va3p', '3p', -1464357216, 1663786207, 'z', -650910265);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483091, 1264233546, '9v37v', 'tri_12b437', NULL, 'xacmz9j44vn', '2x', -1547215672, -1611328599, 'lfxf', 1536216338);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483090, 417639984, 'mdhnszwif', 'tri_12b437', NULL, 'qsh720', 'hfvx12ce', -1703756564, 406614646, '2', -1137542173);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483089, -1281076037, '61o9zt4hq2l6', 'tri_12b437', NULL, 'xp3rig2s4k', 'vtu0z7z', -1630433802, -576111648, 'rkpi8', 873004336);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483088, -1465878149, 'lf2ey7m', 'tri_12b437', NULL, 'gcl4o2xs', '4m', -1949993652, 945137887, '6cmwfgd7', -581057354);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483087, -1917424651, '5', 'tri_12b437', NULL, '05nsqfjm6j', 'rwpjpvv6s', 2086696555, 806114265, 'zwy', 406264159);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483086, -300355555, '2gertom59aa', 'tri_12b437', NULL, 'zu', '28bpbne', 241015787, -1352029663, '8zunlmm5c', 922820242);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483085, 1497283388, '6azs4751h4', 'tri_12b437', NULL, '5057f9', '95rjo', 411086265, 49295866, 'zyj', 874343013);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483084, -1640549864, 'dfn08r', 'tri_12b437', NULL, 's1chlbvdux', 'zho1edkd', 747145921, 967294049, 'xiyper6v3j', -1314474657);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483083, -1050620730, 'pm', 'tri_12b437', NULL, '1v', 'mzju2h', -2137747448, -1506260566, 'v0', -1867500965);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483082, -945668245, 'kcdcdo', 'tri_12b437', NULL, '2njt7', 'kgv7qls3f', -1722900490, -398684391, '8e', 676805040);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483081, 1548478872, 'xaacif33', 'tri_12b437', NULL, '4e', 'o673uuwpv', 683713267, -614395861, 'v0jwue8qv0d', 658665347);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483080, 1927772904, 'a2', 'tri_12b437', NULL, '3eethaoc705', 'vxo5e2', 1483702805, 2068785469, 'silh', -1321172625);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483079, 622913967, 'ygeo7u', 'tri_12b437', NULL, 'lt6g8b90cgu', '8depnbbxs', -271244704, 1205381208, 'q4u3g8gv662u', 1705765660);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483078, -1953881179, 'qe7pd8', 'tri_12b437', NULL, 'qdhe9l9ssy9', 'u6emwed', -553519970, 388606145, 'bnby8muahmsa', -687803287);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483077, -761155153, 'joh8zw3', 'tri_12b437', NULL, 'q0n80hbps', 'flkqft', -575158509, -166982035, '0azts6y', -1915221513);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483076, -925551158, 'zmfh', 'tri_12b437', NULL, '3y3pt9o1', 'rn948y3', -1711709160, 447146812, 'bodv0gd', 1893494112);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483075, -1070755872, '4g6kxvw', 'tri_12b437', NULL, 'y', 'ehwe8f3sv', -616556661, 1940253947, 'co52', -1625206800);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483074, -303414428, '05rqxr57', 'tri_12b437', NULL, 'e528hkfsi', 't', -1473858184, 1033964631, 'f2h6w5', 1185238598);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483073, 1389638383, 'uj48gebf', 'tri_12b437', NULL, 'xyufu5fb', 'k5ahzx0q8', 1737257926, -1286793646, '8e326lih', 1142707270);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483072, -1960534638, 'svpw52vr2l', 'tri_12b437', NULL, 'uej', 'zmt', -1517057179, -1165931914, 'j0hd7', -1306619877);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483071, 1478896065, 'xen', 'tri_12b437', NULL, 'ahy73v8d7fe', 'j', 912419757, 553819545, '5raqeb2htwp1', 626905853);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483070, 1767146014, 'e', 'tri_12b437', NULL, 'e', 'fpp', -327653626, -838196607, 'qg98s', 1742892734);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483069, -2086252882, 'c', 'tri_12b437', NULL, 'ndya435k6jip', 'm', 377358807, -1528557366, '19', -1419677512);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483068, -72431138, 'jkbvxpdr8w8p', 'tri_12b437', NULL, '00', 'g79dzpo3l6', 1149564438, -1118854622, 'xczxb228n', 1095490554);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483067, 1996994484, 'he4qjg0abobu', 'tri_12b437', NULL, 'zm9yzyq', 'ke63tpr', -296223995, -1267141529, 'oplfwc539f', -1203143568);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483066, -1315571235, 'vd4et6u6p4', 'tri_12b437', NULL, 'gfz', 'mw0cnqka9rod', 1525101601, -221298510, '2ecrzu', 1071047356);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483065, 800625478, '5o8ae3w2cqe', 'tri_12b437', NULL, 'ajep9zs', 't0zz44', 348286152, -103415826, 'vaf19nm', 972969632);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483064, 1180837034, '6rfy3', 'tri_12b437', NULL, 'd3z', '6hhtn07c9b4', -2008023893, 2017683003, '3c7dxratt', 1473548224);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483063, -399570481, 'wstn2f6yy', 'tri_12b437', NULL, '0tgw', 'qc8mk043qr5', 111296758, -2022169603, 'fi0upydyr0pv', 258952702);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483062, 898166861, 'r', 'tri_12b437', NULL, '90', '49m615hj4s', -1944306757, -1874202995, 'e3unykul', 555764866);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483061, -164622656, 'l2rjlimds', 'tri_12b437', NULL, 'tv4e1j', '98', -1926366258, 729059056, 'e96', -263266131);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483060, 946733593, 'l3ng', 'tri_12b437', NULL, 'x4cr4vp9bvmi', 'en8o', -1132633186, 87341033, 'prcd', 1628540240);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483059, -1074007027, 't', 'tri_12b437', NULL, 'oemiqh', '4d7jzj3hj61', 98178919, -870606815, '64fxrj7', 418392423);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483058, -1230753916, 'ootmf04in', 'tri_12b437', NULL, 'mk4t6qj6jk', '5s3k9r8m', -78428567, 791779857, '64lh3s', 853128551);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483057, 1161434634, '1ygo2x4s', 'tri_12b437', NULL, 'ob2i80kn', 'z2o', 361096524, -1895835376, 'go5q0hiw', -644215593);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483056, -1376703594, '1xh5vyz5fp', 'tri_12b437', NULL, 'kbwboq', 'npjqi7sq', -1243856136, -1923740201, 'q1dz22awd', 829617667);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483055, -1624287645, 'igh96e44q9', 'tri_12b437', NULL, '6bc33', 'hhm4uhn8f', 1344194234, -853142173, '4j', 1239401395);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483054, 1406916964, '7l9ox6p9bl', 'tri_12b437', NULL, 'z80g0ic9mug', 'we308re', 2131971300, -781565288, 'f5uh7', -1039613831);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483053, -2020505494, 'b5xjda', 'tri_12b437', NULL, 'hyr96z2', 'cc', 804806140, -363134039, 'z1y', 131427816);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483052, -1642013591, 'nytmb', 'tri_12b437', NULL, 'p', '9z31e', 1698663204, -42006142, 'xpw0', 1688277363);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483051, -1894844331, 'r2', 'tri_12b437', NULL, 'ty3', 'z27', 756485135, 237316339, '4dcd', 2004102428);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483050, -1535974592, '8l1kixvspgl', 'tri_12b437', NULL, '13m', 'j1ju', 1639491292, -817385400, 'bsc', 946670373);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483049, -1586560380, 'n63pqwkuqgn', 'tri_12b437', NULL, 'iojwzwcy', 'e', -603331443, 1089482343, '13s9inakr', 919163120);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483048, 545402309, 'bz9rw', 'tri_12b437', NULL, '85ta3u95c2hx', '1vbxpe28', 9646804, -1868857234, '06yamb8', -1876306924);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483047, 1774264622, 'yaxt', 'tri_12b437', NULL, 'fv80', 'cht7z', -1460222464, -18343309, 'xva', -780006737);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483046, 532237403, 'w', 'tri_12b437', NULL, 'dj', 'vwt256', -853686199, 1479195231, 'wofqs0gguzf', -274978619);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483045, -2043185636, '7aljdi', NULL, 1, 'lfng', 'zyancs', 1750566594, -1904940691, '4y20xe', -655270587);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483044, -1315762872, 'o', NULL, 1, 'd4f1', 'mz', -621509105, 394583723, '72vwfkctuq', 1806419364);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483043, 2135003429, 'q6g', NULL, 1, 'vtfg', 'dhztxltagx', -382499035, 2089769557, 'dh', 1060470725);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483042, 1688244372, 'zspkuzhb', NULL, 1, 'n', 'h2y99wf7u', 202108922, 430707064, 'nl4', -1852976902);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483041, 1316770852, 'g', NULL, 1, 'vj46ju9i33', '9tqqj', -776328706, 757423252, 'n60o3b4nf', 2107452156);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483040, 1726328725, 'lgmqhcf', NULL, 1, 'm3', 'j', 771266866, 1327614652, 'ksppkmu2', -1127296223);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483039, -1547665274, 'dkd5kc96hs3', NULL, 1, 'h7dykvhn043', 'ljq52x856pi', 1666750208, -24797114, 'zn3m32b', -387350269);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483038, 1011157896, 'pfejp8xyrd', NULL, 1, 'ruf', '37p8ryyavi', -370707960, 1454554735, 'vgcsvz1r8j60', 1489699659);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483037, 1281061038, 'gmqq0', NULL, 1, 'cm1zu48gcsm', 'xwnak', -447118845, -1057380284, '156', -837010414);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483036, 660300879, 'icauolz1z', NULL, 1, 'o83fjy', 'g9e6790wtt0', 1780144129, 1359666352, '1yntl3c58c46', 770633983);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483035, -1412744687, '4jdc2et4bjfe', NULL, 1, 'zphjyyxkdi', 'm8vbp', 434632176, 1031108707, 'ekg7r62y', 1023785870);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483034, -888837712, 'kfs9uj8', NULL, 1, 'kudrtzdz', 'ngo82g79e28d', -627802779, -1918377318, '46otez', 1802223206);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483033, 427629881, 'kt5bj', NULL, 1, 'v9fsf1', 'y59a', 828161478, 140339941, 'co4', 1056260209);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483032, 267214961, 'yz1x4dl', NULL, 1, 'lnb0', 'otrjfzpx5ykz', 1876064150, 759503153, 'bokto68xpt', 1913653094);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483031, 1346709965, 'l5t', NULL, 1, 'ymaa8', 't', 565198393, -454558711, 'd', 2041926704);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483030, 1941541645, '8f294ds', NULL, 1, '9ikgipdkc', 'abt0zwg99', -136620643, 1579888734, 'lni', -2111206706);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483029, 1713730507, 'g60989c', NULL, 1, 'fxlyl2', 'd0ysa775m', 415333454, 1727561577, '6o1m33ww', 2114013230);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483028, -173758907, '0qj037pgik0', NULL, 1, '9st', '12pfxvthxylx', -726883264, -129701886, 'm', 1346993426);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483027, -1402750760, 'x', NULL, 1, 'hufemjc1', 'q13zp2yvm', 1325069705, 1187691347, 'al', -170835865);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483026, -569726904, '84s', NULL, 1, '86rjtbgce', '5siraxsibztx', -1755743662, 1063779341, 'zqi0jds4om8u', -1082523229);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483025, -1150895497, 'lg2x9dc1qrqh', NULL, 1, 'mzud95t', '93y4', -931589426, 1504985455, 'thxv', -1159643317);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483024, 1957589507, '2ji4d', NULL, 1, 'v', 'qc', -1525988786, 1752062536, '9', 903902476);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483023, -1283977616, 'r', NULL, 1, 'y57480s58o', 'mbcod0', -1265223252, 1852983404, 'rpa549zrelm', -1136630766);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483022, 1384425686, 'cfoge4xn', NULL, 1, 'h5p7vg5', 'mt35f96f27n', 1834371875, 132572258, 'e1uc7plbdy7', 2115594395);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483021, 1796439769, 'd5tf3bpm9i', NULL, 1, 'p', 'sqifhzr5dl', 1206299061, 256782178, 'k1jiyku', 1048454411);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483020, -533404559, 'vlhqxtps', NULL, 1, 'gm4', 'tlgug0r', 265706372, 1713966062, '1myph8594y04', -1986832641);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483019, -1705885533, 'vj6', NULL, 1, 'h4o', 'xwibtg', -384165317, -1940199327, 'kz4rb', 268116460);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483018, -1488242944, '4338pxt', NULL, 1, '1br9oqkscb', 'j4c8rl967gps', -1735109373, -37801678, '5sl9x1v5', 1448670094);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483017, -1941579747, 'jg2', NULL, 1, '6bo759ziw', 'ar776', 564752574, -291818366, 'dii1', 1913316939);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483016, 1750842902, 'nc1ilgc', NULL, 1, 'a87q818wt68c', '7x7', -490476664, -853994323, 'c4pha6u9m', -1903970783);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483015, -1698227603, '4gt20ba', NULL, 1, 'q', 'man', 1877692606, 1021388672, '5r', -1013023369);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483014, -736048637, '3bs0n4yop6', NULL, 1, 'qru67w3vb', '4t683dy', 109893008, 444105058, 'ttay', 1069054460);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483013, 476924187, '2yf', NULL, 1, '3ld533', 'l7w787g', -1262498621, 1901955774, 'k98mys', 942706892);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483012, -1435528034, 'prmr5wz58hi', NULL, 1, 'z385pwqf', 'rxum6yera', 406579106, 1394808649, 'eysdx0z7t', -2078241436);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483011, 1981022301, 'tkh2du2ty', NULL, 1, 'k8', '843bcud2sz', 616053357, 1151982005, 'i2uh5', 715205929);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483010, 1008542389, 'y8ly6zh59', NULL, 1, 'ee6kg04elrj', 'bmu34', 1780970246, -1383365119, 'e', -1908901123);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483009, 1388397956, 'dg5mhc5ksq', NULL, 1, '9spque1a', 'n5', -359002601, 1276985339, 'jyyf7o4xmq', -1694245233);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483008, -1334033151, 'jc1vtkyvn21d', NULL, 1, 'mb9jku', 'cl', -414216486, 673369028, 'x13r3jcva', 1681371001);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483007, -993309157, 'y', NULL, 1, 'n2omq', 'qck17', 150792339, 932616577, 'u', -1145904651);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483006, 927559543, '857tc', NULL, 1, 'ft0qmm928u', '2ld', -884912510, -1117374296, '9knlfbo', -2005366757);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483005, -1351950641, '7h924', NULL, 1, '3', '6w0ybcwf1ur', -1429280200, -1916912863, 'oajgztzgc8uz', 1936859834);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483004, 1343011970, 'nfr0xpxs', NULL, 1, '7h6ur5k', 'pwc7', 418439586, 1574811688, 'dov0n', 1711878234);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483003, 173370231, 'v9g4jva', NULL, 1, '6ud', 'v', -1610296250, 228034665, '3aaxfohuvvtm', -963643720);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483002, -1882880490, 'kgj47', NULL, 1, 'a8dib9ye', '0', -1386962598, -1840513401, 'lbgd', -1065272924);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483001, -1865068668, 'zklrv0cx', NULL, 1, 'os4gcqxmd7al', 'stgvqn', 1333346080, -528598254, 'q', 1832808592);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483000, 2022897952, '7jm2dh', NULL, 1, '57m8awzp', 'qjw0gz2k8', 2019894126, 1663995288, 'eyzrbt', -815847154);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482999, 770175050, 'sj', NULL, 1, 'ojdxk6d88', 'wf0gjkbq7', -1155933714, -150096321, 'n1vi352x0h', -1990791645);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482998, 724167189, 'ghhupif6', NULL, 1, '6p', 'xqw5', 190006052, 1435095666, 'jvafcdnvz', -514107751);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482997, 261695660, 'azzxvsmr5u', NULL, 1, 'eu01hqo2ryw', '8juszzth3x11', -723498073, 904257489, 'n8o', 1910794208);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482996, 996829872, '917yst3', NULL, 1, 'n9qud1hag', 'cz', 43350550, -677042197, 'c3xfi', -434641231);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482995, 896976126, 'lqg2td8r', NULL, 1, 'sv', 'g', -1633015938, -1227483708, 'xb46q', 1595657171);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482994, 1279338551, 'mc', NULL, 1, '74qwmphuu083', 'rs', -652764177, -1091219778, 'gfjzl4y', 2046816354);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482993, -954445927, 'egcdeuzth8d9', NULL, 1, 'rggb37vi', 'cg5dw', -1159383953, -2118491656, '5d4oy7eefo9i', -968825926);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482992, 758785075, '21d5bzvj', NULL, 1, 'xkwr', 'cfeygfj98', 2083099952, -2090635128, 'jrl', -1858853651);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482991, 799093345, 'e', NULL, 1, 'sip159g6', '2ie4f', 1662994537, -795050997, '3h', -1516266261);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482990, -2092348380, 'l3r70sstxr', NULL, 1, 'tfa', 'mdu6nqjfi', -1356364634, -686589885, '9h86wmcjt1', 592956099);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482989, 486706723, 'byd', NULL, 1, '71l1fxvnzpi', '2m', 1139554087, -1220201725, 'i6k', 1360199629);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482988, -575734631, '9l', NULL, 1, '9fqr64lc71', 'zm0bjb0b', 685148816, -1701489479, 'c', -1777996638);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482987, 834291610, 'xb7q', NULL, 1, 'cjuomirkqt5l', 'ef', -487061607, 983474252, 'z', -2001898185);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482986, 1660462114, 'ju7vaj2xq', NULL, 1, '02wx9ip0', '7ov', -1955201441, -568520552, 'hgvrzgdu', 1814068785);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482985, -1459333438, 'oc3b5s6ga8', NULL, 1, 'y0c9u5i479', '52tpl', 1800116269, 1967278084, '6kj', -1749560702);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482984, -1055461970, 'mns64v', NULL, 1, '3vto', '8k8qu0nh1d', 1403815935, -854248692, 'y114pkaux', 1762285121);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482983, -377800100, 'cclk9l', NULL, 1, 'c643hfqstb6', 'mtbcg', 764167757, 1935786533, 'lydaj5pyoo15', 443695941);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482982, -147081049, 'qq', NULL, 1, 'an69z', '16', 148686382, -1534811071, 'fsbl2v0fxw', 1432921351);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482981, 1766133111, 'ad9eom', NULL, 1, 'wiejrr1b', 'e', -1857299952, -1804317280, 'yahaf6e', -75676042);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482980, -1849194492, '3nf33ojyhi', NULL, 1, 'kvn', '7li9plb7', 438321197, 456640705, '793mtnkxi6z', -2123363065);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482979, 1772897470, 'w360jnd', NULL, 1, 'b5', 'fyzek3y', 1046284873, 863064824, '643c0ff', 925998016);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482978, -1687999076, '3y63bz8gdir', NULL, 1, '092s', 'io06y2rfwf1q', -986288009, -422606480, '99pcfurxrf', -868882712);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482977, -297763772, '0decipzk', NULL, 1, 'qk6a4qs', 'q2scob4', -1874191333, -830278861, '4', -2000611746);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482976, -2026386421, 'roxncee', NULL, 1, '9tgkyaps1z', 'pirgxbe8grw', -1910800577, -607720941, 'p233fd78e', 998925558);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482975, -1357079574, 'dah', NULL, 1, 'wfoo2pgee', 'o', 1613383917, 799268909, 're0', 1005494378);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482974, 1639945894, 're', NULL, 1, 'c0xpqsy', '484ikqws6k8', 45260467, 346204863, '8ouz', -1528758942);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482973, -1449356655, 'rfm5iqd07p8p', NULL, 1, '78qvy9', 'pxekr8dvk75', 969174650, -830863093, 'ump77fy3n0', 158228612);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482972, -9691079, '2c31e', NULL, 1, 'w821hbuwbxoe', '5np65', -1714892347, -1561478107, 't4', 1159959225);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482971, 268617592, '37trd', NULL, 1, '8acf39kohihf', 'ewfc7ya2', 1192809684, -1358190888, 'p', 1765797309);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482970, -1465049487, 'ahci6', NULL, 1, 'jzq', 'r6fuo6q2m3', 398008294, 560283799, 'ubgaj9cb', -1114881045);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482969, -2091327920, '026gjv2m6', NULL, 1, '2uax8sjluo85', '5v', -1062006295, -1605981576, 't401mdr2950d', -729837270);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482968, -1491785783, 'wp2wovs0er', NULL, 1, 'd', 'ip', -618960699, 1500245496, 'eg3xr', 165101963);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482967, 784666921, 'haa2mvnr', NULL, 1, 'zyr8f', '2p0bvbs', 239283355, 1345700328, '6mciocm', -799637493);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482966, -1753891888, '4', NULL, 1, 'ia', 'mjy0pp340', -2066754219, 797278506, 'f', -253895692);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482965, 1031208630, 'y0mrmgg0', NULL, 1, 'l', 'il32hnvrt4l', -1926810278, -991740856, 'bji99p8op', 824020256);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482964, -1740005535, '9rgn27b', NULL, 1, 'vxe4t54h4y', 'hy3kl1qjd', 616331904, 103890273, '1dm1m', 1661356800);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482963, 792891618, 'rfm6i', NULL, 1, '8x30heb1', 'upmt', 1792397448, -832658669, '0', -1756118709);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482962, -2102435647, 'ypkk4', NULL, 1, '8ud1zz', 'us27cpl', -337827620, -1014099825, '3srdet', 1422262467);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482961, -2039362408, 'cas', NULL, 1, 'g5k0s6hezd', '3f8w', -1589466085, 28240307, 'hm2', 1099374219);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482960, 1240775043, 'ce4wk7r03j', NULL, 1, 'is', '3mloa4', -2092111805, 214694936, 'q4u0nk4', 897637851);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482959, -898569924, 'kd', NULL, 1, '5sgy', '6t5', 783666752, -43018235, 'p9akyg73', 1179485047);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482958, -1133135786, 'da', NULL, 1, 't8crx', '144s3vl72', 1674880443, 1400053165, '56na5', 1280580955);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482957, -779128910, 'j64', NULL, 1, 'l', 'f53ofvh955f', -1330616579, -1282300186, '39cfn', 871672971);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482956, 1947993643, 'biuxlpvo0', NULL, 1, 'g', '6cm', 1058759754, -2032316324, 'j', 1371631737);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482955, 783839168, 'u97bpkdv2', NULL, 1, '61jcr1u', 'j56u8c1qfhfi', -185560776, -1143179181, '0r5', -1331006655);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482954, -164051140, '4781j4c0d0', NULL, 1, '5hrn53q88', 'ez', 130707986, -1800329559, 'sjckd5', -337818871);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482953, -638103801, 'h6o6', NULL, 1, 'm90', 'mqrhtd4wtl', 539187015, -538038588, 'hhrqc26g5', -1878515868);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482952, 761887665, '0', NULL, 1, '7goz', 'ge88s', -970704528, -1702369878, 'uitrsxq6nv', -125642872);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482951, -1088541588, 'x1zl3', NULL, 1, 'c92yj6svu9k', '4yb5tlqq48', 114184459, 1973054985, '0949', 998239628);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482950, -700529775, '34zu44', NULL, 1, 's1qp13r', 'ppc93k2', -766007228, -1464129424, 'jf45x', 1044738185);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482949, 514527906, 'exiq4c6', NULL, 1, '0racoybfzee', 'a1783s52', 429041612, -1121090257, 'wd', -1780180915);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482948, -146799627, '1hnc', NULL, 1, '7umnu', 'k4', -992347132, 1494450106, 'dscki6', 773590085);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482947, 1366425050, '5asm2lxs', NULL, 1, 'r92r9x6wsmea', 'uxd5180w4u', 1138508334, 174122995, 'r4n1so3xxkm', 1233779052);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482946, 1724226169, '5', NULL, 1, 'ha95m', 'ovwcb6', 388031640, -451468736, '2h1m', -1039742044);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482945, 1675047967, 'd51odf92pzz', NULL, 1, 'f9psmnp', '96v', -2058706628, -1980694332, 'r', -2100820825);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482944, 1529014144, 'a938', NULL, 1, 'hd447m4y', 'qgu', 1375054418, 1690112282, '7mveeykxi', 1383537364);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482943, 265506178, '1xxgtvr4', NULL, 1, 'e299um5vs', '4r', -80456789, 1841010565, 'wz7vib', -732351707);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482942, 1794892005, '2', NULL, 1, '7l589', 'v4wk2pcjd', 2016015428, 1173713470, '3e', -840425179);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482941, -1678211019, '1miyx55', NULL, 1, 'bahb', 'd', -696196525, 970017061, '28vrfi9h3r', 1251430260);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482940, 1833914683, 'uo6cx33yvu', NULL, 1, 'emjdx3dwck', '9fhp', 1399928744, -1978142473, 'dik5l6960', 2064600737);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482939, -765202134, 'wk8zci', NULL, 1, 'o7ct3llx0', 'y76ryypf', -6536572, 1022257077, 'v6rjpw5ifw', -1296672484);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482938, 668339055, '2pd9zub', NULL, 1, 'fgycbq', 'm3xcwd', -537891612, -1468669359, 'hoexj7v0uy', -1705128164);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482937, -435094014, 'rahbwiocx0', NULL, 1, 'z3hsrx0', '7', 1643585252, 1095537366, 'o7m9th4mqd', 1322489702);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482936, 994427107, 'n8r', NULL, 1, 'yl458njvk6v', '11qwc9xsv8wj', 22301752, -1034326052, 'zwwmpvzn08', -629651877);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482935, -1684562651, 'c71', NULL, 1, 'y', 'lu4nrdhs', -278908699, -501293954, 'nl', -1821391603);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482934, -1322772607, '2x', NULL, 1, '3', 'p8c', -1936163509, -1727842852, 'gf8i', 530954377);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482933, 1381855297, '1hmg', NULL, 1, '1tz', 'ao1cicc76', -749979192, 1991962902, '5adjjj', -654478109);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482932, 1147506136, 'j96nl2', NULL, 1, 'n', '90te7g0v', 14076966, -538045426, 'rii', -1190225102);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482931, -2084251041, '6z09cjv6koy', NULL, 1, 'ztbhhv3', 's348a7', -535298991, -1602030908, 'tmo', -921576281);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482930, 1094505859, 'ryr', NULL, 1, 'ywt', 'posf', 406220896, 546211168, '4plswf', -405725027);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482929, -72949808, 'zb3bcu9vsrx0', NULL, 1, 'z4ymy', 'tpkk70w', -864210107, -1057240604, '3tvs3b6iv', -572078907);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482928, -537460999, 'tc', NULL, 1, 'fkrtefqvyelm', 'rk', -302486805, 2087423213, '3jb0chhh8hys', -553777342);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482927, -1735599617, 'c87p2w13', NULL, 1, 'pxr13', 'e', -198316170, -695952750, '9', -2024178491);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482926, 1219026567, 'ylcughrnzkx', NULL, 1, '3mehv', 'jxckzhpj17', 730182331, -951329069, '8xb17g4ag8q', 1372614165);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482925, -1400333996, 'eeuiy44', NULL, 1, '32o', '4ozs4gfa07', -10210828, 783145311, 'angeuq', 73097485);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482924, 2045019497, 'z3mj8cs931', NULL, 1, 'aqj', 'bwh8i0', 2069729503, -2075742875, 'p', 1904604927);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482923, -2147051303, 'gtdj', NULL, 1, 'ghg44mi', 'k0opp492fw', -946556659, -1753238373, 'wbd975ywdka', 1838564162);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482922, 149977613, 'xywg4z5i', NULL, 1, 'rvnzvttzvco', 'ftgrr9on2uqx', 1350550226, 1354092839, '0aiaa2d9q', 544872442);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482921, 883076268, '8a0mu', NULL, 1, 'czy6y', 'o2nz', -1542951917, 356666148, 'rb', 1499911903);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482920, 657844164, 'm8v', NULL, 1, 'tytp6cg4u7x', 'sjkfjegg', -1927456889, -1025895403, 'hnz8yackemva', 1991800614);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482919, -32436144, 'j', NULL, 1, 'e32tt6onzv', 'wydgcy4', 1475470365, 1577664539, 'x7jc6c1', -879395956);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482918, 1116207357, 'g4ml2rcvy2x', NULL, 1, 'sn7mdyau', '5o', -1931154680, 2064862100, '26dldv0', -102075051);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482917, 1937962818, 'zrgt', NULL, 1, 'y5', '56751ij', 758869198, 541040667, 'ng70y9nbeiq3', -1476173537);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482916, -201518515, 'lygu0c2', NULL, 1, 'xa3fgv1ji4', 'l6mg', 321435219, -69901581, 'ueqj9tu', 76520488);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482915, -2018258354, 'wk930nfawcn', NULL, 1, 'arjh', '9iyuey829', 304716729, -363892591, 'uzwx', 4142122);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482914, -1843714619, 'iixp', NULL, 1, 'mwbgw2', '49zuyx8z', 864062563, -240735251, '6cc2pvgp8nm1', 1436711490);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482913, -1651624964, 'k1czgbd3g1g9', NULL, 1, 'qb', 'rv4m64h3k', -1040765867, -50522237, '1se', -189703870);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482912, -366822733, '5sms9wotqp', NULL, 1, 'bg', 'x305wtf2snoi', 893998271, -1440921523, '6n', 522322906);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482911, 85019732, '1pszkdjl7l', NULL, 1, 'jtfwybysho4', 'hlqbv', 846103799, 352187429, 'i8xie', -1260875795);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482910, -2115107110, '0eer', NULL, 1, 'v5', 'qckbme5lsq', -655528151, -962960756, 'u', -1219202459);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482909, 119382396, 'wrlbngt6xoiy', NULL, 1, 'eqatzky6he', 'wo', -1936269313, -1747695025, '87fpv3n', -1262932805);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482908, 1033943015, '5her9wu', NULL, 1, '0oksn1s', 'obbmgg2mb', -922020143, 956670846, '0zq6794nch', -332676176);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482907, -665200504, 'dtshamw8', NULL, 1, '9bddky5k', 'n8bs43', 1670549252, -1232186906, '98prghg0tv', 1457374215);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482906, -618865701, 'tzsjzzq', NULL, 1, 'bnni2v', '67hnk7l', 413234484, 1537266319, '6jjwyinm', -426890819);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482905, 32752917, 'iugod0d03', NULL, 1, '8sn', 'vh9nxudy2rc', 1195703604, 776831149, 'ig8xwm1x', 441982076);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482904, -250270782, 'we', NULL, 1, 'dabx', 'gtg3p', 1469534537, 1648588115, 'xtb1', -1968991952);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482903, -687284341, 'bgsrk', NULL, 1, '5r', 'oftyj', -1441392292, 505763175, 'hmmtttffqv4', -1031341436);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482902, 721148627, 'oyaqc2', NULL, 1, 'fb7mte', 'g', 402980800, -219191528, 'zivcicklz4g9', 841083580);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482901, -1664253549, 'prmfmgra6b', NULL, 1, 'y6u', 'geuky1b', -281261238, 1291903831, 'kle8', -222399555);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482900, 1884098606, 'i9h', NULL, 1, '9', 'ji1', -1868088624, -729141719, 'giknz740', -1055454780);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482899, 444097706, 'oze8amg', NULL, 1, 'hh', 'uda6wjun', -1243859968, 1976369550, 'z8ass8hf', -1788175550);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482898, -1819489747, 'lnz', NULL, 1, 'gmuqan', 'kr', 293971637, -1515213084, 'wck7hc6', 1839846361);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482897, 1245673018, 'nzl1w', NULL, 1, '77y10', 'my9g29qg0', -2109497207, 1741245170, 'kiql', 179375092);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482896, 1954803536, 'ppgepsm', NULL, 1, 'nr7', '71xjs2q8qlp', -1143919169, 48462493, 'bfrqdz9', 1394183035);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482895, -126198623, 'bjhwre3a', NULL, 1, '1y', 'o6tdw4v9yg8', 910542107, -919913335, 'h', -2138617384);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482894, -1878791910, 'eu7fg', NULL, 1, '1a390khzmf', 'l', -394278126, 82116078, '3g', 2106725564);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482893, -799991503, '9pd6', NULL, 1, '321uk167etm', 'aeg9u6w', -1453220362, -653418611, 'cco', 376694968);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482892, -373436313, '3epgu6y0m', NULL, 1, 'i', 'slwah4vs', 727960956, 556832132, 'lnwrz89ebk', 1582679195);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482891, 1743535852, 'kbcvp1g', NULL, 1, '63yycgtkw', 'h', 928744904, 680665036, 'd3', -1892227016);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482890, -764203698, '4', NULL, 1, '53vuj1n', 'vc35q', -1939090233, 1756568536, 'vrw9ajr2amti', 1189036396);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482889, 1747022361, 'hjs6', NULL, 1, 'p', 'c', 873651312, 928680086, 'bkx', 793851993);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482888, -1357266133, 'jh5by3', NULL, 1, '9', 'j', -2048665238, 1781372931, 'r5gak0', 889647470);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482887, 1810409839, 'dxrb4', NULL, 1, 'me0', 'yuj40s7er', -148462546, -1053325991, 'ok1pop8hv6f', 138834482);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482886, 58453183, '4m11ngao6kf', NULL, 1, 'kpa', '8aghrfhj1sa', 207973688, 1043166636, 'l', -1932467940);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482885, 768285822, 'k', NULL, 1, '4x1la', 'wu4y26k9tcmm', -1110157983, -450521964, 'zuciakb9xfl', 194355166);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482884, -215838994, 'n6nn', NULL, 1, 'qk6fi903td', '3', 179666497, -2081051327, '73tq8aej69g5', 1609400);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482883, 974786059, 'gz42m8wxog6', NULL, 1, 'fv', 's1o29f', 1354354229, 1070620649, 'x8', -2008996128);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482882, 551886888, '0ab5xitk', NULL, 1, '49', 'bk3hle', 1048842164, 542513789, '754wz5yuc', -1584080600);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482881, 1503019717, 'l6yy', NULL, 1, 'jo5p1d7d', 't6i056', 1369938644, 1618246001, '5kwq2ocbseo', -118652937);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482880, -1327147791, '5vpu4zkh2tvh', NULL, 1, 'hq4b', 'uw', 1733346361, 924674855, 'ynh', -1224028127);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482879, 443196982, 'k7', NULL, 1, 'qip2lz3lom5c', 'vfsw', -1028065332, 1294355790, 'chiyrs2wg', -1765928624);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482878, -1005949914, 'nspcz5lq', NULL, 1, '87xkogt', 'xd', 414871478, -1098236471, 'vvacc9gab', 1332649743);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482877, 483489532, '8aejx7', NULL, 1, 'h3k9gmp9763', 'e6uu82', 1018418084, -1496454317, '6mr', 1685782280);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482876, 1192182613, 'gkbyre', NULL, 1, '0leo14', 'foow8a3', -1552436438, 1484094473, '8w6dxm1pm6r', 1603977567);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482875, 479852802, 'jayqq', NULL, 1, 'wllwk', 'gul1', 10907028, 806647326, 'yf5u6t', -1096553139);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482874, 763584342, '66', NULL, 1, 'cmxvhm', 'xc1gq', 25101080, 902740655, 'kwtelrc8df', -2032225143);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482873, 2133209624, 'kod7cixyrz7', NULL, 1, 'zjic0a385u', '4c', -1718878160, 1828024105, 'fa259', -1868175797);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482872, 1174827830, '1401w67ywubn', NULL, 1, '86hu', 'd0ek9x5c5x', 1521857129, -63769031, '0lgkjcbd38h4', -483579528);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482871, 1736230928, 'jmf8uw1cxzg', NULL, 1, 'izf89ekcph', 'jfr5', 1395010330, -432830136, 'yoxtlohs7whr', -1639416828);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482870, 47554943, 'i7ekp1eva4', NULL, 1, 'ew', 'lj3vpx9g3815', 116109938, 433648217, 'dw', 1415249802);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482869, -1784480461, 'z', NULL, 1, '67dh2s', 'wr1xu', 1274945765, 1819938109, 'gef5i2dciunc', 1929592437);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482868, -1299895629, 'yq5l52ip3', NULL, 1, 'jjgf', 'hjsxu', -1435708029, 288539869, '3w', 1311699385);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482867, -494476659, 'dwm', NULL, 1, '99ca3sht', '7y2jb4', 705718188, -734426240, 'ovd3', -1566398437);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482866, 11236455, '1r', NULL, 1, 'zyem', 'isz3n4tjtt', -2016678839, -1791967181, 'g6y8p5', -2120154369);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482865, -1770631942, 'su9ie', NULL, 1, '7bymm', 'va', -1836164980, -69831257, '8mcx9i', 2030720012);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482864, 746310062, 'br6gm6', NULL, 1, 'aij9c', '8z', -178621709, -185577389, 'ersxryba', -879180328);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482863, 1487813463, 'nb3m1sp', NULL, 1, 'wp0e7h', '579xjlj2d', -1750001506, -1160576271, '9gocdlx2c', -1051731024);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482862, -1444956356, '0tnhy353', NULL, 1, 't3e', '7b5xis', 931789227, -1271959301, '77df', -1655419850);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482861, -303726401, 'xthld6ylen9v', NULL, 1, 'rksewn', 'y86307vw2p9l', 334537727, -941211278, 'yupkfljun', -463463733);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482860, 929755324, 'm1y', NULL, 1, '4j38uxwmz', '4l7mgl9chv7u', -1685618433, -1394933851, 'qnr', 1959567284);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482859, -1097705434, 'k8l', NULL, 1, 'ebwh', 'fel7158onc6d', -492732864, 991565359, 'xjasri6ol', 1142606666);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482858, 661743830, 'o0eiwx', NULL, 1, '1w4dgcquq', 'geuxkrcw', -1937290869, 1668180573, 'wrxhsa', 111557040);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482857, 493959718, 'cz', NULL, 1, 'p1f8qr', '4n', -1464294632, -1025908911, '4w', -1245643110);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482856, -1403562497, 'h8w4jkqr', NULL, 1, 'yyube', 'i', -806665897, -1949684197, 'ubtiszn11yrd', 1532182247);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482855, -1043685716, 'ac4mhgd3cl', NULL, 1, 'g8vspr', '1a96ahh', -715349456, -1859765882, '1wxurl', 294640303);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482854, -1629926821, 'w7hkd0a4', NULL, 1, 'dk', 'rbhp4r2', -1266993231, -1287554910, '9rhn401tj', 300178145);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482853, 1082369040, '6yecwdd1b3j', NULL, 1, 'l2', 'yi264ff0t0', 1668288720, 822107930, 'h5ep', 1965288400);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482852, -643528470, 'dfeei', NULL, 1, 'udrhmcs', 'vy5', 790527996, -13919882, 'eis59za', 379436313);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482851, 561955288, 'q0n', NULL, 1, '9i', 'tu', 1039931119, 235119052, '32tcrs', 1447283780);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482850, -1140299610, '7wnwu87dahaa', NULL, 1, '1c581mwbg', 'clx', 1807105175, -275816218, 'h1y', 6345647);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482849, -1958546022, 'tq5zt00bx1p', NULL, 1, 'uk0nh5', 'joovyic81pwk', 262265550, 1653973432, '6hwi56lh14m', -503740130);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482848, -605515524, 'y0rorp4y', NULL, 1, 'fir', 'p', 1542918824, 660791753, '24', 1373568290);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482847, -461782973, '7q7fgsa2jj', NULL, 1, 'sr', 'd6pk', 40998545, 630213568, 'dbf', -1767804480);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482846, 2008446187, 'oqxdo0co9afj', NULL, 1, 'r9', 'bi77ojrm', -1488021918, -1632376010, '9r', -364920258);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482845, -289802852, '1582', 'tri_12b437', 1, 'wyb', 'kj73ro', -739965029, 1706153016, '1iq375f8syv', 1778762023);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482844, 366365321, '6ws9gxyk', 'tri_12b437', 1, 'a6', '0', 636522528, 1787882264, '5dy', 1767084177);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482843, -1012004880, 'qt3yvt3it5', 'tri_12b437', 1, '655', 'n65rxa4po', -729642156, -1340490799, 'b', -1851124961);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482842, -542043685, '052wg', 'tri_12b437', 1, 'didt1lgelrqw', 'u', 141337679, -70181349, 'jzmmivybojf', 382507027);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482841, -1703739052, 'pdu97z', 'tri_12b437', 1, '1', '2u5whyjkluvk', -1250429276, -813637486, 'x6ujpb3ld9rj', 165892228);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482840, -948732935, 'zsn3', 'tri_12b437', 1, 'agsq', 'm2o1yubx', 768999017, 543992014, '0nr8n', 941348896);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482839, 1331270493, 'p6vz7koqi6', 'tri_12b437', 1, '1gv10v3', 'owhe34bpjjrr', -1219739501, -137689932, '33dr863ls1', -2120327113);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482838, -114417129, 'sxa', 'tri_12b437', 1, 'st2al1p1qrk', 'wjx6zdz', -731157751, -1280898587, 'o3nn339w', 1207836003);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482837, 1237838769, 'rxygmiw', 'tri_12b437', 1, 'xd', 'ob', 893026604, -827175034, '58291x94whg6', 1509436703);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482836, -1427600102, 'hxccstpax2', 'tri_12b437', 1, '3183x0', '9x50p', 653844952, -1176836530, 'mbmd', -730587345);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482835, -770381012, 'w', 'tri_12b437', 1, '456slzqpif4', 'qe4tgqf3', -927242547, 984599004, 'gdy', 1828109781);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482834, 684220125, 'c2jezw0', 'tri_12b437', 1, 'd134y40peumu', 'y1714tcov', 1839878322, 509261781, 'u4adupdv', 1339341051);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482833, -1927646385, 'dku33ykt', 'tri_12b437', 1, 'z3uf6wkpuwmi', '530or749osr', 992537276, -1444195725, 'd', -660151059);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482832, 1454848039, 'qdpcg', 'tri_12b437', 1, 'heh6e7', 'hw3kry', 538522561, 656898065, 'v94h82hnlt', 999224720);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482831, 38013419, 'ycyfg', 'tri_12b437', 1, 'njbcy3', 'uogu', 893693786, 85410542, '1x0xrn5yyq0', -116763115);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482830, -1774384117, 'ql17', 'tri_12b437', 1, 'ly', 'iyqbjr4oj2', -2084815505, -1774862754, '8ikch1s9', -103174691);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482829, -2017420336, 'y6adjkso', 'tri_12b437', 1, '1xnfdqkc', 'u6i89abk7mgq', 1050281019, -901760416, 'e864', -1604489844);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482828, -1312360239, 'ba44ek8cov3b', 'tri_12b437', 1, '0', '2qadycyx82', 337349801, -1391753925, 'wgx2yz40', -359760917);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482827, -1720648279, 'qdb', 'tri_12b437', 1, '6kr6', '2', -863396499, -541380537, '5jbteo', -1360148067);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482826, -1518341318, 'tm2', 'tri_12b437', 1, '76m', 'zeo90171v', -1327788600, -1928167705, 'g7jbsw5yuz12', -469955587);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482825, -671691709, '8nlj7p6503f', 'tri_12b437', 1, 'xsi2', 'g4n1rlyo8zsn', -1266077827, -1572486849, 'pvxmqioncfv', 1273376193);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482824, -1903577792, 'i8szja7c8ed', 'tri_12b437', 1, '301b6w6l', '55', 1959944952, 1410977790, 'hrlod37wtbpz', 1818751219);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482823, -1727889025, 'l18zxvfef', 'tri_12b437', 1, 'q9p', '35ewdolpd24', 654614196, -1947957738, 'tyh', -1576736771);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482822, 249362781, 'ti1od', 'tri_12b437', 1, 'pg4su7hpgyh', 'fdq', -1003436956, -1792041223, 'v13jx3y3', 430034652);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482821, 1597266447, 'wgs2we1', 'tri_12b437', 1, 'r', 'qdw2vgwu', 2121855262, 628511900, 'n15l5', -1022978149);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482820, -874060082, 'j6q7qk', 'tri_12b437', 1, 'hzj4k2v', 'b1wnn8uvfz', 1575685149, 896809427, 'kk0d', -1980568942);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482819, 241331765, 'qrcfqwy5', 'tri_12b437', 1, 't', 'm85lw4', 2002032895, -1290148402, 'f27vi6o', 347818547);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482818, 907415516, '6ll1gu', 'tri_12b437', 1, 'j', '22ub4fp', -865340363, 1327654786, '2gr7', 1828276501);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482817, 1264176578, '85khobu5t', 'tri_12b437', 1, '2p', 'bzn1476sl0ap', -698586898, -1825941218, '1v4y9z449', -1404477074);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482816, 74178534, 'wski9eizgt3g', 'tri_12b437', 1, '5hhmdj8ihtz7', 'fr', -1838682774, -1543146901, 'ufh65qco5', 375119076);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482815, 667330731, 'hajq5rw', 'tri_12b437', 1, 'nw', 'vsi3qv', -1549306647, -158626983, 'cfr0i73howk', -536192876);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482814, 1293844142, 'bf', 'tri_12b437', 1, '3o051do1n', 'gwac4nu', -1048112964, 396986358, '8a', 1849474670);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482813, -1082099798, 'cea1', 'tri_12b437', 1, '1hu7j488s', 'h97811', 500723125, 17409822, 'xu9uiaz', -825661066);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482812, -690635035, '480ou', 'tri_12b437', 1, 'zsh7ovqla', '5cb', 655706506, -816656442, 'cbch64yb', 461903578);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482811, -199412552, '3blwa2ek', 'tri_12b437', 1, 'g7u8uofuy', 'isjx5', 99823299, -650278704, 'oldc6d9', -1076719135);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482810, -1314542766, 'bg0', 'tri_12b437', 1, '1xgmdqnpuq5', 'kiakk24jq', 1215792541, -738679759, '5wvthjtf1', -509100348);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482809, 1189954374, 'h38qkvjb5sg', 'tri_12b437', 1, '56hnbwlk1', 'mo', 2073245559, 1256005239, '11', -1414038369);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482808, -1346170135, 'k', 'tri_12b437', 1, 'yxz5oighg75', 'vm4', -550268793, 494957112, 'dyh6c1imi', 387955991);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482807, 1201614069, 'n1o4v2m7', 'tri_12b437', 1, 'hy1f', '7b4', -1784462918, 602853674, 'q6w6yy', -112866294);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482806, -1662962781, 'dcj', 'tri_12b437', 1, 'x8mu', 'z65e3f', 14993878, 1426813606, '2fzwkb7ul8', -54504540);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482805, -129154290, '4b533dzkys', 'tri_12b437', 1, 'h4ghhjes6adg', 'hqo', 464768127, -969886618, '8', 1717381835);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482804, -853713088, 'vih410d', 'tri_12b437', 1, '9xza0', 'k', -342817689, -836207701, '0bdd7mj', 1795683847);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482803, -1341029020, 'ev6p', 'tri_12b437', 1, '4rs4e45i2', 'di56e1n', -2001520502, -1677131733, 'yyf0p', 1650373642);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482802, 289237441, 'p', 'tri_12b437', 1, '0', '69rx', -181923963, 446611811, 'xk6tjsefhud', 26237936);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482801, 161192410, 'nfzp8og1', 'tri_12b437', 1, 'q7e4', 'kjsp', 1079877433, 1418834949, 'sxpk5xt2if', -131445394);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482800, 1397371573, 'u5ga4b6i', 'tri_12b437', 1, '3', 'o', -1835315095, -434679390, 'gdnfj3kat', -121028660);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482799, -1245559960, 'qi2', 'tri_12b437', 1, '927t', 'u3zfs5kbvw9j', 375417328, 509421148, '1', 1915835269);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482798, 17977652, 'yil4m9', 'tri_12b437', 1, 'wtjy7hr1fl', 'p6fyq2', -2108685056, -2042175959, 'iy7qrhfzceem', -1862319795);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482797, -751410143, 'm3u', 'tri_12b437', 1, 'hte037u8k34', 'hdarv4s1oad', 1295320559, 1716137030, 'pylozi', -1580134380);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482796, -2042395469, 'ynt14icrm', 'tri_12b437', 1, 'tpc41', 'tqtufda', -841042221, 868566812, 'ly2kxiyq6', -1556924243);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482795, 396857542, 'r69', 'tri_12b437', 1, 'njyue5bbqk', 'hyqbn9uws', 1687750849, -693279888, '8msffv8t1g0', 127096639);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482794, 2045961406, '4z7mol', 'tri_12b437', 1, '2xaq', '5unr6owfc', -1966254695, 1455175167, '5aj', -671229167);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482793, 1104785291, 'e7as5hjq383e', 'tri_12b437', 1, '8', '2w', 2031743718, 436937868, '5ul', 1503681978);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482792, 536666538, '64i', 'tri_12b437', 1, 'ype', 'mbfzkl0m', 2077694733, 1302443214, 's3fh3', -1663052695);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482791, -1038927811, 'swhl', 'tri_12b437', 1, 'a1icuhop', 'myxk', 877562650, 938745491, '5zxsb2sy', -1868616030);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482790, -698081142, 'ofgm25', 'tri_12b437', 1, 'ds0', 'mh5o0sac9i2', -1498964616, 1060180699, 'a7zt', -1529822985);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482789, -1878759693, '9x1jctcqey', 'tri_12b437', 1, 'sy', '0s8k1', -925684271, 1925979233, 'nlnqw8eeu', 1248529682);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482788, -1970342747, 'qch', 'tri_12b437', 1, 'zpsr3zedv13', 'qoh6poek', -1483001067, -1427165566, 'v52mr0r', -680379326);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482787, -1641125442, 'o7peigosc', 'tri_12b437', 1, 'zlpfqzgy', 'f21km6', 383804311, 1623999988, '7tz7kq63j9', 1147806276);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482786, -268477914, 'b', 'tri_12b437', 1, 'nzng0', '32q', 370690460, -592891473, 'ubq7', -1610697072);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482785, 1678856168, 'bcjhzn', 'tri_12b437', 1, 'm6nvr', 'sqfygj', -1064382982, -286404137, '5j6rs7ic', 2102332746);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482784, 1108406602, 'x8f2wwl', 'tri_12b437', 1, 'ez', 'zw', -1111676264, 738007841, 'rxrqza0dyv', 957217578);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482783, 1737486431, '30dmhr', 'tri_12b437', 1, 'kzaw66c4', 'bxpai00', 1340172831, 1670636097, 'yputtw', -1901686672);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482782, -1933094035, 'pv1', 'tri_12b437', 1, 'l', 'yn8', 1972360100, 1620489812, '8x2', 1591398232);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482781, 1533277024, 'srk', 'tri_12b437', 1, 'xi', 'u3dzm3', -301916554, -1123113290, 'nusqc3', 1949144405);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482780, -1043259436, 'uw3t4a8', 'tri_12b437', 1, 'hc', '0hbblq4k', -512673623, -641327431, 'u4fyo03', -1625262715);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482779, 929650081, '1k06drl', 'tri_12b437', 1, 'x1oeqh3', 'qxhvzoask9a', -1671836487, -760326800, '2', 674109585);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482778, -1056677210, 'dhef7tn', 'tri_12b437', 1, 'omt', 'ck96', 486892868, -1362908195, 'hmzh8w4', 1016860200);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482777, 1559145546, 'unf5dns6t3', 'tri_12b437', 1, 'rxbskbuhg36t', 'k63l97udyw', -402056776, 501934398, 'cp25oe9d', -2077752195);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482776, -2099934684, '9x', 'tri_12b437', 1, 'b60ju', '1vhqqho', -73799422, -1851283649, 'w6l0xc9784l', -2068606021);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482775, 1841946517, 'k', 'tri_12b437', 1, 'qwc6b4cq', '5q5', -788261462, -1184366287, 'kyr2n83', -1042942519);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482774, 75270495, 'mujvs1c18', 'tri_12b437', 1, 'e381pxf55', '87y', -2129863500, 1823358966, 'q694', 1980634400);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482773, 1848709012, 'b2n', 'tri_12b437', 1, 'ji7', 'i0z29l1r', 1488787393, -1772603268, 'pp5tn53ij8', -507856390);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482772, 500470778, 'a', 'tri_12b437', 1, 'q5ihjl9b', 'j7ik3doup6xs', -1840710015, 1326512613, 'ko0k', 1284151928);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482771, -959906092, 'ax4c', 'tri_12b437', 1, '53dqvr', '4hb70gu9hv16', -2134954391, 1053493826, 'q4db40yl', -1405211171);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482770, 1915489224, 'p5wo46dgz3', 'tri_12b437', 1, 'fwrjefjlay3', 'pkqu8n', 754792711, -1737000253, 'gcq4ln3', 394957642);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482769, 564937796, 'f2', 'tri_12b437', 1, 's4', 'o8uf4v6iec3i', 1749139327, -1851289000, 'za666xoeov', -1457577947);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482768, 477385695, 'togilr1lljn', 'tri_12b437', 1, 'fsxej68', '253hnb4pk', -146580594, -1687792413, '0s5ei54ida', -360741089);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482767, 1166767161, 't', 'tri_12b437', 1, 'ncmb9i0aqwe', 'pmpq7g8l', 363886929, -1699759635, 'u09kc7i7b', -639013612);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482766, 776882896, 'w1lamvekd', 'tri_12b437', 1, '46', 'uhzjanj', 79729624, -1562601354, '7yk7xym', -1276947447);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482765, 2047015030, 'kcd2y3g8b1', 'tri_12b437', 1, 'cuzsay', 'wkcqkztugm', 1685907653, 247975272, 'tsuv5x2', -1737275011);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482764, 847304314, 'jo', 'tri_12b437', 1, 'q9mg29', 'g', -1124082777, -2085862882, 'thfs3dtb', 444204271);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482763, -1868538764, '6', 'tri_12b437', 1, 'n8m', 'zs5xtas21l1', -2146196919, -324183973, 'ohorf50rxx', -70441544);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482762, 1076120142, 'r4ce', 'tri_12b437', 1, '93aaxwypnzqj', 'p83', -1090954409, -1666628047, 'i', -289687714);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482761, 544310615, '83', 'tri_12b437', 1, 'f74dakqpr70y', 'khqysp91o', -437096879, -972550409, '9lk', -2019388466);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482760, 2091128708, 'gb5otvd32', 'tri_12b437', 1, 'gnzjovu1m4c', '3mh89vmuqj', -1602106681, -625791492, 'r', -904130386);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482759, 1723674224, 'ya3', 'tri_12b437', 1, '2jv5r', 'd8x70tu627', 100614334, -93640915, 'ry53', -1054421003);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482758, 1051861531, '7vq', 'tri_12b437', 1, 'kflori', 'ya510j60hy1k', -1061229450, 1086326412, 'i2a8jy1v3aj8', 1192855172);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482757, 947166068, 'f', 'tri_12b437', 1, 'q88pz01', '0vqc', 942777553, 1022043387, 'm74gw1xv1k1', 856179860);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482756, 913166424, '6o16', 'tri_12b437', 1, 'dtnye68', 'g', -915284997, 1473848317, 'm5pfm', -66671640);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482755, -1021224429, 'gy3u0zh5t', 'tri_12b437', 1, 'bu', 'vz3uf0my7p1', 112662017, 1431954877, 'cv2h', -1485217122);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482754, 1066013877, 'euzot9z984', 'tri_12b437', 1, 'p6xoi3n77occ', 'zv5jb', 1720328333, 1658651838, '3wh', -1900956327);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482753, -1812134677, 'wq7r8ze', 'tri_12b437', 1, 'i85s7hbiy4wp', '0qo9wfb9', 1338501608, 1135401513, 'dgxtu4gk2v', 202099679);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482752, -619307366, 'lpbirbcgwl1', 'tri_12b437', 1, 'cb5wna0rh8', 'icrpivyf7y', -1013741333, -1764738011, '4', -984493918);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482751, -492890329, 'poyjzx0k8d', 'tri_12b437', 1, 'vo0', 'c8y4ys3c6', -129047383, 2142800686, 'qdr9', 903452316);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482750, 1372246831, 'm0e9', 'tri_12b437', 1, '77wveuij', 'emdwp', -93250598, -650807004, '6g6', -249908463);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482749, 271166611, 'db', 'tri_12b437', 1, 'w0xl4z', 'lftc1bb', -2087841399, -986850945, '8gn3f', 1145044593);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482748, -49898964, 's4js57', 'tri_12b437', 1, 'z3', '3yafn0vk2at', 187411668, 302764293, 'bal', 1584888149);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482747, -1817599694, 'jidjq', 'tri_12b437', 1, '4cazz', '8e', -726326357, -1179706848, 'hs29lcc', 1718059022);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482746, -204337489, '4b3yohwfe', 'tri_12b437', 1, 'pg', 'p', -775685850, 103163361, 'aypxn179', -1263063138);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482745, -1352014030, 'x', 'tri_12b437', 1, 'kl', 'vrp32id3ws3', -89499070, -619721747, 'l5uk', 517293873);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482744, -1435766714, 'widpq', 'tri_12b437', 1, 'bjz', 'l6ma7o', -512542856, -1350789216, 'f94tqb', -1933375567);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482743, -1318521450, 'mmu73vvtdf', 'tri_12b437', 1, 'rjp3ayfxzs2', 'er', -1447409306, 2142171747, 'x', 256470977);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482742, 861102375, 'c0p59', 'tri_12b437', 1, 'e8', 'ams3gt6r0', 1486828214, -244603131, '1ksdk', 144779635);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482741, -686101860, 'xr', 'tri_12b437', 1, 'jhzjwjip', '3beqp', -1281363601, 646642327, 'jue230x', 1494977966);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482740, 1546632776, 'zbvoj6i9v2d', 'tri_12b437', 1, 'p', 'zlvy', -146205143, 82154129, '6hd', -20878774);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482739, -1662126729, 'jm4', 'tri_12b437', 1, '0ubbuc5noty', 'hpzkmv4d0f', 841413757, -53762569, 'yjlt9kx', 1126651644);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482738, 1884833139, 'n', 'tri_12b437', 1, 'ndc6em2', 'j7pkela9y', -1331728715, 1675713122, '9i95gp34cl', 1934442379);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482737, 1896588018, 'wib', 'tri_12b437', 1, '7', 'ax', 687644389, 435515227, '8af4pnjkh9', -1328715823);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482736, -2040457938, 'w2lrkmethrz', 'tri_12b437', 1, 'am8ne91r', 'f00u07b7h', 1338860095, 1460156030, 'gzkk4rrrkh64', -75501019);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482735, -276240688, 'xhz8sbmmfrg9', 'tri_12b437', 1, 'drq', '5b1lu7hwo7f3', 1775138251, 1654396087, 'vm4oyrdx6gty', -292573295);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482734, -1745819770, 'hc1iawn', 'tri_12b437', 1, '2d9wn5i', 'fjeh0', -190040815, 71064777, '0sf0fwpmx', -1589670753);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482733, -465558473, '00j5mvwk', 'tri_12b437', 1, 'u35p', 'b0v', 1840700260, 1281609337, '5bojzzxtev9', -1816841214);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482732, 1877774208, 'kaclz2grp', 'tri_12b437', 1, 's6eev', 'biubc2ezjn', -1387571654, -744340463, '89mkh', 603246740);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482731, 1402688864, 'r3xwon68ocy', 'tri_12b437', 1, 'uo39u', 'bp2', 1685460814, -175109420, 'l95zl2uyc', -375174805);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482730, 426927166, '5wns', 'tri_12b437', 1, 'wp9qhd5krwd', '1i2', 1635185831, -1860610171, 'mek60wu9tm8', 691448558);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482729, 46413022, 'hdr6pazykwnh', 'tri_12b437', 1, 'zzgk583w', 'aisfrirgc0', 1379501998, -1642742304, '3mx', 1608962964);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482728, -680937812, 'tf6qb', 'tri_12b437', 1, '8r8d989', 'z2wrewz', 948114116, 664552849, 'gfzh5q88o', -613038955);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482727, 926212958, 'xqnjrq6f', 'tri_12b437', 1, 'zs5eg14', 'rhk', -1256134490, 1577610434, 'lda97dc4w', -696465896);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482726, -1042408739, 'qm3zml', 'tri_12b437', 1, '5q5rkal', 'sxdjrbsw6p5u', -424242220, 1551976584, 'c7vd2t8aez', -986510613);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482725, 1272776830, '8bnbmo2bqu3b', 'tri_12b437', 1, 'd88a08n', 'uaq70', -1803523419, -714510412, 'gtotqakv', 670740486);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482724, 941212549, '27', 'tri_12b437', 1, 'gza', 'a0fo224', -1426685845, -388600580, '9t5gvzpwrt', 83255224);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482723, -1519108829, '1c2mrks', 'tri_12b437', 1, 'd29gs8qk', '7i9sv', 27022347, 276743864, '6v2fgk53okx4', 1239332521);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482722, 453618100, 'tsj9', 'tri_12b437', 1, 'x', 'inrf1cj6', 400626138, -1697401866, 's7', -473731873);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482721, -792331583, '2io', 'tri_12b437', 1, 'rmtd', 'mqjrx', -607515160, -1834975212, 'd9ox', 777714553);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482720, -1359358579, 'e', 'tri_12b437', 1, 'girpzi1xtump', 'n8p7ev6kzq33', 1822649844, -1103047854, 'dwie0mricqqu', 1119140698);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482719, -1769573241, 'nk', 'tri_12b437', 1, 'tlz3glml', 'et329i', 1633566474, -495376633, 'qohkel', -710782330);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482718, 1086274593, '0c5z', 'tri_12b437', 1, 'p', 'vqo', 465158043, -2038965014, 'ifqg5e4p5', 320549483);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482717, 855271065, '2p6asbpbrq', 'tri_12b437', 1, 'liwpd60', 'r', -2114116640, -1094619025, 'n2z8xsnfaps', -1861763375);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482716, 508580811, 'n', 'tri_12b437', 1, 'z5chsyi6c8d6', 'v', -98236576, 1477623245, 'c6w2xe67b0', 367717772);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482715, -246560734, '7y1dzp', 'tri_12b437', 1, 'wnqguj5mec', 'i', 286468411, -1354981370, '1q0bt4', -1667440419);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482714, 324827010, 'w5dv2n0n', 'tri_12b437', 1, 'tatn', '7qhv3bja', -703968849, -1428232503, 'bowtg8pf01ws', -1490351478);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482713, -751481034, 'f1t0wzpu7heg', 'tri_12b437', 1, '4xyi13', 'xc02q3n4qmr', 1582205587, 1662808857, '05j', -1184073542);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482712, 1419345871, '2c1', 'tri_12b437', 1, 'cv9tthyv0v1o', 'jb9y', -1293135486, 1883880874, 'kz', 187314226);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482711, -1689461294, '5apetcbzn0zg', 'tri_12b437', 1, 'btfggzm', 'afjfair7au', -1576752603, -69558874, '8', -1515917850);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482710, 1208495992, 'w0bh7kc', 'tri_12b437', 1, '3yvb', 'sfq3', 213836574, 908569146, 'ter', -1563181807);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482709, 1361353786, 'pal5b', 'tri_12b437', 1, '8nv7b3igcs', 'o', 1352251558, 545578555, 'mir', -1898768313);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482708, 820712381, 'yof7bx3', 'tri_12b437', 1, 'w', 'zeuc0be9s9j7', -1784175565, 2056763317, '0', -1412690298);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482707, -1515686990, 'midgwidc1pn', 'tri_12b437', 1, 'jakrignj', 'nf5ij', 507664200, -282352678, 'bc', -1189603888);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482706, -160336532, 'wspg6o6ac', 'tri_12b437', 1, 'o3fduuim', 'w9ykghq', -1451495829, 1425266488, '11', -239268106);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482705, -1386616895, '7futf6ln6', 'tri_12b437', 1, 'k5ao', 'gqid08ew7loh', 51893728, 1058621261, 'uwvxv', -2095908151);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482704, 564403597, '7niig9gco', 'tri_12b437', 1, 'mmaze', 'ek9b', -1467174323, 942873781, '86mbo4', 862415840);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482703, -64082280, 'pjoe9ruu', 'tri_12b437', 1, '3fmhwa16', '7vbjlqc', -264881496, 1791782793, 'turaurj0q', -500531255);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482702, 1934278400, '1k0siuosq64y', 'tri_12b437', 1, 'ylwfudew', 'lx9v', 12545578, 1474028329, 'j', 1817166999);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482701, 1301335296, 'p7y7xj9xnjx', 'tri_12b437', 1, 'dz86s', '98raujsgfme', -717807815, -575567, 'pog0qnm', 952844107);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482700, -971147501, 'crf1225llfgt', 'tri_12b437', 1, '6vtrvvd2hidc', 'ftelf9sz9l5', -340238882, -90425822, 'n4zlb7', 1104222587);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482699, 1128482890, 'xsd9ocpzw', 'tri_12b437', 1, 'ospcl6h', 'q', 1357895901, 895401218, 'm', -1216953996);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482698, 831657085, 'aan8pmovluqt', 'tri_12b437', 1, '4ezp', 'tk9k9oj', 798741913, -1705416382, 'r3qy', -1326533082);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482697, 1469622195, 'rmvgsomdx', 'tri_12b437', 1, 'vcg', 'wbdyim9363x', -2045412860, 2034597723, 'lsph0gfmh', -1615187668);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482696, -1905213224, 'y8n2lawrc', 'tri_12b437', 1, '6rds74lj07b', '1', -821993598, -1908414054, 'f', -1639925846);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482695, 1693656251, 'siod8c', 'tri_12b437', 1, 'jl66tm06zp', '4ujwc59dspw0', -1517742999, -1085807927, 'ubk', -926019772);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482694, -794274547, 'g', 'tri_12b437', 1, 'e', 'ih91', 870176246, 1048402114, 'xuivn3nc6e', -1831610190);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482693, -1133647009, '93', 'tri_12b437', 1, '6f', 'cfg33uh', 681596441, -993725900, 'f1mxpgk', -819671865);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482692, 1142152299, '2uibb1o', 'tri_12b437', 1, 'gyx', 'athof', 1806564934, -341657453, '33wywzw19l', -470056124);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482691, -1282350766, '0dnkx3rj4o9', 'tri_12b437', 1, 's0r32pg', 'clsiq42h', -304010278, -469023920, '5metu4mz7is8', 1088819180);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482690, -688108593, 'n8qjwwmlbkk7', 'tri_12b437', 1, 'itrlvvg0zb1', 'bas5d2', -708501811, 798252660, 'x', 787391885);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482689, 396977860, 'zgy9', 'tri_12b437', 1, '3hwf', 'hawf', -1414341519, 1952695246, 'qhopw5bhyfy', 529526930);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482688, 1832618865, 'xgwwowz47s', 'tri_12b437', 1, '4', 'jvet3cwpn0', -719341965, -931262189, '1ojmg1rah', 1845088223);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482687, 46125976, '52e82sp3', 'tri_12b437', 1, 'ibpwalzf4by', 'j04q', 1038747572, 928958084, 'z0m3tuv4l7p', -1520337340);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482686, 1662405095, '0csnqisq', 'tri_12b437', 1, 'iwzlfn', 'ek0x', -1895268653, -242503654, 'y8p', 1998236045);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482685, 1090930648, 'ah6kpln9', 'tri_12b437', 1, '6z6kn', 'y4bc', -1102169044, -120375858, 'm6', -894981553);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482684, 405721875, '2', 'tri_12b437', 1, '3uf', '8n61', 159508575, 499627131, 'ccwflt5uj', 878594942);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482683, -172408146, '57c', 'tri_12b437', 1, '5uz0co', '5x6ymjf', -813141033, -1540433793, 'oqdcw3bfxaux', 1779169253);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482682, -591529264, 'h71', 'tri_12b437', 1, 'fs1gj9rk0ieu', '9gnrbx0s', -1428247880, 143147605, 'hy2gy0j5vk', 1483711770);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482681, -1372218447, '37lmev2s532', 'tri_12b437', 1, 'abu60kyhl', '6aoj6gb3uaf', -1559656898, 821952387, 'xo4buw47tsq', -1160465849);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482680, 601979439, 'e5176', 'tri_12b437', 1, 'l', 'kvjc', 1005949121, -740485505, 'vfsmxbr3c', -1175502267);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482679, -1647966386, 'c62kmxs', 'tri_12b437', 1, 'rfs', '5', -1583693256, 2093323577, '8tyatwle2g9j', -477275663);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482678, -1094050945, 'ijtp9f', 'tri_12b437', 1, 'llggg', 'mlfbc4rjb', 430485049, 1236175063, 'hd3os', 257335895);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482677, -370718444, '8jxy8fft2dhi', 'tri_12b437', 1, 'criewe0nghq', 'r0yy', 673010450, -682456166, 'cs93v', -553987653);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482676, -186508847, 'whapu', 'tri_12b437', 1, 'loczfms9v1', 'kg', -2004112138, -599055112, 'lrlu9by', 1469655646);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482675, -860042169, '9bnhgup', 'tri_12b437', 1, 'kiyrj2', 'xajehq', -2087426623, -1273811662, 'gusxrksncn4', 642964580);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482674, 1586380770, 'ta', 'tri_12b437', 1, 'bltg7lj9a', '9r33yigkbn', -1627011646, 529493198, 'lic1uzxm3wy', 356633411);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482673, -328229397, '8', 'tri_12b437', 1, 'mglcs', 'n3776p590k', -178065827, 452562897, '39iywgc', -1151801502);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482672, -928696239, 'tgta', 'tri_12b437', 1, 'ijqaxpwm', '0d', -1151364950, 968397718, 'ge7b570', 1638698703);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482671, 71923428, 'xubw', 'tri_12b437', 1, 'cl780l', 'g0l77p', -2138288130, -1388740798, 'h', 79168688);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482670, -922470798, 'rh4sz8tn', 'tri_12b437', 1, 'n1', 'x2tfcpwk', 1639496722, -502947012, 'z24zz3m7', 449731901);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482669, -1134646882, 'qwoq3qozr', 'tri_12b437', 1, 'mp2gdrhpjh5j', 'z1vi1bw5k4jj', -1055391811, 1474832973, 'kuh', -1269291210);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482668, 1169955712, 'djk', 'tri_12b437', 1, '1', 'ngr', 2015343620, -87419425, 'ig5l9oa', -1489700635);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482667, -856201964, '4av7zxvjiw', 'tri_12b437', 1, 'zek5gzfil', 'h0', -78258401, -2129837341, 'e4l', 1636476860);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482666, 144257643, 'x5xvxeo4n', 'tri_12b437', 1, 't7g', 'lh', -153178344, -86009880, 'kz61w', -1757362153);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482665, -241534388, '6jbwv5j9byh', 'tri_12b437', 1, 'wqioejuka', '33yviv', -1088181219, 1156432767, 'gg3kiyxn', -2018108529);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482664, -332991374, '5mszu9v', 'tri_12b437', 1, 'jrkbv5o', 'xhas0ze6il87', -1165510249, 1467790483, '4bvftlcs4qj', 398053963);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482663, 1012357314, 'ce7', 'tri_12b437', 1, 'o', 'd', 117901713, -812062193, 'sph5agg4k6a', -1327864495);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482662, 614594173, '922u9y7wgfz8', 'tri_12b437', 1, '9k7t', 'wmp6rkazn', 557335496, -1989062504, 'ed22', -655147241);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482661, -1297357262, 'myfpdkxapp', 'tri_12b437', 1, '8pl', 'yb5zra', 2076763253, -379677212, 'ze41hxs9', 1747361916);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482660, 1181638094, 'vnjarhkpoji', 'tri_12b437', 1, 'xo0rx91guokj', '7', 77167953, 965885659, '5zsapfjo1g', 983806085);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482659, -502661237, 'td85ta0z7kl', 'tri_12b437', 1, 'qg79yu3h', '7u', -1393650, -997207366, 'j', 1743951769);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482658, -755408041, '6gi', 'tri_12b437', 1, 'bsoij5da30w', 'w1pth7snr', 770544637, -622454635, 'i7vs816', 810343727);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482657, -82126032, 'pjjghx', 'tri_12b437', 1, '0lyx4c4ozp', '6rm53', 2089311379, 1526035281, '15o0xeoewtc', 1614082013);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482656, 358842247, '8sp6fsmaze', 'tri_12b437', 1, '7', '2epxln8b2x', 1169105060, -1968542052, 'pbdlh', 838230167);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482655, 656307299, 'buip39', 'tri_12b437', 1, 'flia6kdhwq6s', 'oppad6', -1871633899, 1179519776, 'gtndlq', 867317933);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482654, -2028982569, 'go6ii', 'tri_12b437', 1, '1whmys1ucwk', 'f9uddtw3dg4', -872334527, -1789337919, '0njf9rowq2v', -1814977537);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482653, 1189822007, '9m', 'tri_12b437', 1, '2x11414ofzt2', 'gx', 478723263, 48480725, 'baxkj44s', -1975127295);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482652, 1483897052, 'od', 'tri_12b437', 1, 'cux9z', 'b', 540962909, -1537638441, 'cngkigrp', 2127714705);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482651, -1683786590, 'w53ojq4', 'tri_12b437', 1, 'mdra8p886u', '4bsuxprw8w', -910472364, -1267515353, 'ibgj65jn', 821863328);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482650, 1626876555, 'lbfaxh', 'tri_12b437', 1, 'j4qrkqzmh0y', '7', -1986280638, -192267348, '4', -904855752);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482649, 1080978264, '4o6ex', 'tri_12b437', 1, 'odvd7qdz048x', 'lv3gc', -1578403347, -1051157838, 'hobxurji', 2042023621);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482648, 1744950503, 'mxmm2gz', 'tri_12b437', 1, 'ycjy8wvs8', 't2k8c3uob', 1902123500, -721939997, 'q82gtyrs3', -955047548);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482647, -235343896, 'wef1je5', 'tri_12b437', 1, '51z36r', '7', 1726264591, 799966145, '4r8he5g9c4of', 982647846);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482646, 929141099, 'z', 'tri_12b437', 1, 'o9hileav', '7fz', 1524471108, 1699815201, '1dyb', -1222896997);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT start_station_id, start_station_name FROM (SELECT start_station_id, start_station_name, COUNT(*) AS n FROM trip GROUP BY start_station_id, start_station_name) WHERE (n >= 200) ORDER BY start_station_id, start_station_name NULLS LAST;

/*
Gold Result:
(None, 'tri_12b437')
(1, 'tri_12b437')
(1, None)
*/

-- Prediction Query
SELECT start_station_id, start_station_name FROM trip GROUP BY start_station_name HAVING COUNT(*) >= 200;

/*
Prediction Result:
(1, None)
(1, 'tri_12b437')
*/