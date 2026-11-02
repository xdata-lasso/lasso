-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: station --
INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483648, 'sta_5e117e', 582.588439, 680.190136, -55602865, 'Palo Alto', 'swwqcgsk');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (2, 'sta_5e117e', 452.041295, 153.0663, -1986907724, 'Palo Alto', 'wtu');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (3, 'sta_5e117e', 998.241511, 728.468867, 907636171, 'Palo Alto', '9dvetwe');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483645, 'sta_5e117e', 266.859502, 412.423979, 1968248398, 'Palo Alto', 'baye0');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483644, 'sta_ff4126', 528.720217, 645.28702, 1348125446, 'Palo Alto', '1s78arzv5pb');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483643, 'sta_5e117e', 201.101132, 420.848568, 969466978, 'sta_0b9351', '6d03wjk6dj1w');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483642, 'sta_5e117e', 945.073906, 259.208136, 1123598454, 'Palo Alto', 'axj');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483641, 'sta_5e117e', 200.202799, 50.562232, -1878885665, 'Palo Alto', 'bi15cai1n');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483640, 'sta_5e117e', 493.755472, 849.748155, 2035597190, 'Palo Alto', 'z3s23g1q');

INSERT INTO "station" ("id", "name", "lat", "long", "dock_count", "city", "installation_date") VALUES (-2147483639, NULL, 431.877624, 650.924138, -723498073, 'Palo Alto', 'kln8oscz917y');

-- Inserting into table: trip --
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483648, 1610062532, 'pgu7vfe4', 'hria2ypuzhs', 700293388, 'wbbp6luhvdlt', 'tri_361e50', -841692980, -1364429300, 'nprmdposii', -1823627488);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483647, -1209887326, 'klfa9000t', 'c4ecigce', -1585009206, '52zb', 'tri_361e50', 757448742, -1179823637, 'rqro', 775304493);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483646, 373262291, 'p5s5bbp', '02eutliqa11r', 2137741668, 'ytoo3o9hl7', 'tri_361e50', 1178636309, -1390245819, 'x14ji7zwau2d', 1485335077);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483645, -511185946, '13pyu', '8d99rljsl', -346339240, 'yp5qi2rk', 'tri_361e50', -705985602, 537874887, 'z0f8jegd21vy', -792092619);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483644, -1492524358, 'wb', 'v', 1581736075, 'gndqwnqc', 'tri_361e50', 555413010, 722884590, 'hncprjtu0dz', -1748371085);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483643, -1742081330, 'n2f3dqv0g', 'cb98ozk3zbil', 982314585, 'kn6vc', 'tri_361e50', 1784916884, 37673509, 'h0f8jswwlq', -566887085);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483642, 602161869, 'xa', '7ryfdrz16n', -1496556994, 'i', 'tri_361e50', 1746373317, 1360271423, 'ogrgjd8y', 1129658414);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483641, 1250290042, 'og', 'itsj3', -491938169, '1q43', 'tri_361e50', 1235416111, 1923912467, 'jh3den8c68', -683007527);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483640, 2035306060, 'x7afu5w1of77', 'zo72', -1957268147, 'c', 'tri_361e50', 1303877941, -1284905200, '62', -1744557630);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483639, 1870300798, 'q8qdjpe1', 'o22', 2004147439, 'tjpttg', 'tri_361e50', -2033879835, 1798111945, '5zi36c', 1722106924);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483638, -2072838897, 'foa', 'cd07z2zezjo7', 304189298, 'xd', 'tri_361e50', 1999335832, -526612570, 'cmr0oz', -870767087);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483637, -1699185893, '5i3lq5lnpim5', '58q', 1817366143, '7p2r94gt', 'tri_361e50', 1273687251, 333302050, 'najj', -1351793914);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483636, 1919033056, 'v8u', 'tmu2n', -1817527403, '78lfvyz7zz', 'tri_361e50', -2052653308, -489120589, 'v42', -2060082151);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483635, -1122409769, 'u', '3auvm', 274891948, 'pdjwzw5chn9', 'tri_361e50', 101754718, 628082526, '9n0jxfofwsz', -210159774);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483634, 270415200, 'b', 'q0k32od', -613916489, '5am', 'tri_361e50', -1177989415, -1352968577, 'ngc1dj9', 681061317);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483633, 1935791961, 'izgk1yoeyo6', 'l0hdt6fuqyx', -1418927432, '521gwnlas6e', 'tri_361e50', 1468640756, 1048147204, 'eowi', -1610380698);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483632, -457369423, 'xih6', '2q2xlyoto', 1774679448, 'oaawg96aq', 'tri_361e50', -2061634386, -850941333, 'indz39tajz', 261633665);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483631, 748154000, 'cgumbc', '3tdu6bd0w960', 740386991, 'xw1rxe9', 'tri_361e50', -505019168, 1968783602, 'qk162nh55', 2105860871);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483630, -141591627, 'ohvu06dza3', 'rmkio18r', 431832073, 'hy08ftp6', 'tri_361e50', -1853955201, -805997097, 'xnjaby', 462225708);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483629, 1528227252, 'fx7h', '3p6sto1c', 170892881, '5k', 'tri_361e50', 1106724223, 1966809332, '7dyyd', 357443379);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483628, -1502591405, 'h', 'qta8y3a17', -735270562, 'ygmayq3qdpu', 'tri_361e50', 1595033206, 1291298007, 'tdqr', -1670945624);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483627, 555368535, 'ic7', 'dn2np490xdm', 1996699977, 'tgelc', 'tri_361e50', -1025517017, 1374676344, 'f2ccukjq1', 1584429327);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483626, -1575692857, 'yhb08hl', 't1pqo', 1222311103, 'ztv', 'tri_361e50', -1304516770, -1558272216, '78aqqlud8ft', 1183069552);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483625, -1057355067, 'e6bje', 'uuwsj8kjh8', -55270062, 'xlvr', 'tri_361e50', 1205111943, -459075802, 'aqt', -1218774640);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483624, 697582781, 'c8s3b7v88k', 'dmdbdh', 313797011, '7nxar50h', 'tri_361e50', 460471995, -1515201134, 'n', 1195320303);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483623, 1463445550, 'p', 'nmwfwx', -1040088060, 'awk', 'tri_361e50', 558684943, -120625031, 'dqtsmg97', -2098439423);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483622, -459764012, '20pj', 'ddlysu6ip', -1664440372, 'u2g', 'tri_361e50', 1352531282, -269868995, 'q51oa2', 1907670428);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483621, 1265709623, 'uoi1pavc', 'wnyqro', 917675957, 'rlr', 'tri_361e50', 323781506, 1026055008, 'it63xy', -711121679);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483620, 1977502251, 'p26m', '3', 1893953818, '0ju', 'tri_361e50', -352678633, 1498627641, '133ir', -270436559);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483619, -569461411, 'hpl2i9e', 'ap8pg', 1752727653, 'qwt', 'tri_361e50', 1339281953, -69263912, 'qjektb1d2', -460035045);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483618, 1794943626, 'rjkwns47j2ja', '8dccy3vjwq49', -516707997, 'nxs6dvdxdo2v', 'tri_361e50', 1805923837, -699779308, 'j9f', -1519752081);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483617, 906349223, 'n7k10z', '2my1ogyv1rg', -1873650788, 'x', 'tri_361e50', -316078323, -754769711, 'ly', 139907579);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483616, 914471233, 'il', 'e019', -1958403507, 'od033dlhd', 'tri_361e50', -929713613, -1239290359, 'd2', -1066046077);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483615, 972991637, 'u331spxpw', '0bgwkxgi', 404445908, 'j6i', 'tri_361e50', 1004962990, -1318740197, '1l2o3ak16', 1562909425);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483614, 950497469, 'g', 'eev', -582813835, 'lu49ku', 'tri_361e50', -2051917235, 833662145, 'e', 1557266002);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483613, -775706063, 'khllbwvdpu', '5v0eduy9v2z', -54963162, 'epac', 'tri_361e50', 1372042958, 1147974039, 'f0c296xi', 2011754567);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483612, 1755688363, '8xjhc', '46', -2003500453, 'perxa61sjv', 'tri_361e50', -1265768652, 2081562124, 'd', -958249959);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483611, -1446721688, 'zc', 'ehia3', 652687353, '7', 'tri_361e50', 848275284, 736542812, '0', 1434462631);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483610, 1621309369, 'wo', '1esks', 1403715810, 'q82qg01hu', 'tri_361e50', -1585280787, 128895724, '8kqhiu5gm8', -1728059226);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483609, 1652765764, 'qjlsawsp', 'kwi3hl7j', -113489293, '795ybv8', 'tri_361e50', -197208169, 2089151689, 'z19xgjja', 2062713020);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483608, -1725535379, 'kfb5if', '180terbf', 1176294340, 'vee', 'tri_361e50', 59326585, -1371170489, 't6lu2c', 1224512097);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483607, 771073365, 'fc', 'mn5', -1846239934, 'i0f', 'tri_361e50', -2013600868, -415366855, 'qxs2', 81406544);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483606, 1276865022, '88y1k253s', '5', 1772219707, '1ehn1', 'tri_361e50', 1134827548, 320743233, 'aqqhyyzsnp64', -1669961050);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483605, -1220782619, '4m0rrw', 'j', -1449073012, 'p', 'tri_361e50', 1851648795, 1130223592, 'b7jjpl', -604038417);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483604, -1369846060, '42', 'nyj5yrji5m', 1253306312, 'na3', 'tri_361e50', 172299659, 1705419178, 'wb2d0', -1318060436);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483603, -613511812, '7', 'tp5q', -1147699861, '4c6', 'tri_361e50', 749598659, 902707245, 'kd4k', 825979697);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483602, -1565247126, 'axz', '90nhs', -1205570400, '6', 'tri_361e50', -976193147, -15423424, 'phy', -2074051940);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483601, 1487440939, 'y', 'hvyx8s', -1957842577, 'fs3qn0b', 'tri_361e50', -1500616, -1001218462, 'crwfx0', 1950697910);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483600, -964661721, 'z8', 'lqme2wb1', -179078143, 'n66e0i', 'tri_361e50', 499998313, 1915216858, '070zi', 207340898);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483599, -1205465222, 'q833g86', '5zm6dpewew0', 796830191, '0u2vil21', 'tri_361e50', -555808510, -2091367850, '6q5ziqoauy0', -215230989);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483598, -669329028, '994fqc1m9gr', 'xjqbloxd4', -928434146, 'il9wnd6d', 'tri_361e50', -698277997, 748510826, 'wakmwgw73fy3', -1884996250);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483597, -1930352392, 'txfb', 'l10qx6j6d4fc', 109383153, '4s2a', 'tri_361e50', -1532823638, -755912743, '6xuj90tefx', -199427879);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483596, -18235088, '709qf9lx8', 'qzabivuumwu', -2091687257, '0jw', 'tri_361e50', -1674574732, 1874367397, '79', 1342717090);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483595, 1100953564, 'zrv1ll930xvk', 'viql6n0rlp', 307649752, 'axeeinmbciv5', 'tri_361e50', -1191120749, 2110758629, 'eqv3', -986328637);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483594, 1784235325, 'doxa0o', 'l1zmjrssbh', 133794777, '404qpp3303a1', 'tri_361e50', -1232267276, -1034606204, '8184d', -619092341);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483593, -1908406235, 'lz', 'dyxk', -384734946, 'cql1c8c', 'tri_361e50', -656017519, -2126129717, 'p', 1401274472);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483592, 569834975, '2hj', 'xpg1lcg', 219919626, 'gkjog8dw', 'tri_361e50', 1314064183, -805818449, 'jd', -1332047564);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483591, -2058646672, 'kr2tzdlb6i42', 'tew5c29d', -617631089, 'havc2c4', 'tri_361e50', -429097391, 1690729846, 've', -390816038);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483590, -1748913439, '5t9', '9kvnbhvi6t', -1082755849, 'fndtw', 'tri_361e50', 232457376, 782631880, '4eufiof8of6', 1796323549);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483589, -1022360195, 'rad', 'fhj8zr6k53', 376872332, 'olf0yf1u', 'tri_361e50', -1457401052, 903854855, '50', 1657449784);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483588, 1193519861, 'znqcuex41f', 'x', -2006745200, 'e44', 'tri_361e50', 774567335, -30821492, 'dbp3ce', 598317289);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483587, -471858269, '3oylciif0l', '46upleo', 788036815, 'm3q0pq97', 'tri_361e50', -30073701, -70372742, 'xbk11ysp', 1408494635);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483586, 1686931087, 'v4pmp', 'jve', 1806134886, 'trn6j72v', 'tri_361e50', 857954744, 809540172, 'gr', -898823195);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483585, -1406885347, '5jw5pbgwojnh', '6v', -164454935, 'dx5hn75b73', 'tri_361e50', -197352413, -445327932, 'yx', -852843717);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483584, 1737246157, 'oua4yi', '4h5c4f1q9w43', -1597057552, '8s8', 'tri_361e50', -215535291, -1116027668, '9fo', 1090670329);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483583, 1783185410, 'iae6aj6q', '167', 1083169975, '8qazkjyfxs', 'tri_361e50', -1161047208, 1450500765, '0235v8ikp3qu', -1947520594);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483582, 970728092, 'wgr124vu6v8', 'kl', 1277665386, 'u8yb4qp', 'tri_361e50', -1154116262, -55064672, 'dhct', 931265534);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483581, 177710966, 'whwhlh5i1', 't', 1718452961, '8ry9', 'tri_361e50', -1633323209, 15319141, 'v7j452k1qz', 1308402480);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483580, -817991918, 'uw42p20gwtf', 'k1', 1444022422, 'bjksuye6', 'tri_361e50', 536967336, 1761543456, 'boodlz6', 822981708);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483579, 798014875, 'ufc', 'vfghixbu', -1744541202, 'slq', 'tri_361e50', -251766416, -880471265, '44u2f', -441907095);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483578, -638516078, '3q5br37qobv', 'j', 393716354, 'kpxc567pv', 'tri_361e50', 643045605, 1922111976, 'flntlcorqt', -1374868354);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483577, -763290795, 'dbvf3ya6l4', '1gfeg6q6', -1736300823, 'fjtvxt41zjf', 'tri_361e50', -304309687, -1492410135, 'e4dpb', -109711729);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483576, 2033372614, 'rl72q8', 'ppx', 2144707422, 'tkf5j4ce', 'tri_361e50', 570999682, 1786584480, '5ys1gz7p3', -1624769339);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483575, -1733083999, 'ytzip2', 'a6d2hqs4zc1', -254442524, '2rnfvkrmf', 'tri_361e50', 1667042356, 549119239, 'pzucnn53i98', -1166137624);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483574, -1041632451, '0hvv0o', '59', -1568596349, '6dro', 'tri_361e50', 410637411, 1730574324, 'qb9jae9ps4d', -1830074601);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483573, 835780485, 'piqkuizi6', '308npqdb', 868170608, 'ew42zl4ptf8u', 'tri_361e50', 278497828, -393305044, '90t2kl', -2127892574);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483572, 1955390593, 'gno6r9d', 'zdayv5uh', -1176524414, 'ccwraq', 'tri_361e50', 1791561235, -1871524022, 'n', -1188144607);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483571, 1539201953, '70691', '7', 692583137, 'i0k8thq', 'tri_361e50', -980180561, 209714160, '3yyxg3', -745917239);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483570, 1675947773, 'efrzw0qgiqh4', 'o', 1208695669, '9v09407sw', 'tri_361e50', -158691005, 1382068330, '9kf5l6rnd3rh', 376343297);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483569, 1275382784, '96v5', '122bvxjnuw84', -1291688734, '1nfs4niom2u', 'tri_361e50', -17400164, -992513509, '71kpjnnbs', -40599967);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483568, 1040296707, 'rj', 'o317kajtw', -1017874103, 'j9f945', 'tri_361e50', -1983237870, -46116361, 'bzjmeuvjvc', -392675823);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483567, 421059825, '15y8am0q', 'ut2', -1751666019, '6fr11lu', 'tri_361e50', -720395989, -130970718, 'wggg30zch', 1922961793);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483566, -1175155753, 'xze42lwenn4', 'lc3', 1441332845, 'w6gv', 'tri_361e50', 1246780528, 538410706, 'l5zmrsv64', 1525278638);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483565, -793539869, '8ygqo', 'fzr1qv7z6ikr', 284729405, 'hx1dlz', 'tri_361e50', -2030631507, -1464232115, 'zzuuwyewb', 1533864667);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483564, -1614519539, '801ev3gqe2', 'ehcn', 2134974396, 'v4lraxg0gt', 'tri_361e50', -593591690, 1106541902, '1lrh', -524520263);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483563, 880857056, 'eyhmlrnycz8', '5', 399889710, 'btcpo1ke8euy', 'tri_361e50', 629009789, 773955054, 'cxl8e4bkfp', 684639412);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483562, -518242106, 'nm0cmn', 'usy4c1vk2', 111968174, '4uv', 'tri_361e50', -1787219074, 894128511, 'g', 625106229);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483561, 748669029, '9r', '1z82t', 1705616658, '4o1sqir', 'tri_361e50', 1505875875, 2140983620, '1gx', -1325539976);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483560, 256346440, 'hx5v', '7jo', 1440780484, '1skvh4q', 'tri_361e50', -1296362361, 2109358643, 'p0', -1475649316);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483559, -60939452, '0d0', 'gkgqavutce', 809990944, 'kdvf12j4', 'tri_361e50', -1358351689, -567298605, 'nheb', -1221167808);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483558, 2141308608, '2zt2ugy7qn', 'j2d', -928035601, 'a91', 'tri_361e50', 2040233149, 1845406169, 'ug9rta', -615675122);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483557, -1252742289, '7az', '6gahj', 844210576, '84vxo5', 'tri_361e50', 997629714, 1072213049, 'ra', 946754934);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483556, -1262942078, 'lwczduqt0i', '19', 132846311, 'lr', 'tri_361e50', -1350605914, -1394371468, 'kbtog', -1189171828);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483555, 210109936, 'nlvwnzpkcp', '0q9z43', -789800145, 'g25jlkkgg', 'tri_361e50', -549418526, -557174317, 'fnbop1', -98939200);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483554, 233495545, '9nw16bb6tec', 'aio', -1310826078, 'f5tulso', 'tri_361e50', -720003270, -2044534767, 'v293muo9o5cw', 1587263314);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483553, 1007592936, 'fuy2vtctr95', 'snhqc1jc1j3d', 155279221, '6qohr35i', 'tri_361e50', 1074058348, -1639499826, 'xti78hf', -1985673660);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483552, -607510855, 'mxv', 'ftaq65', 777530818, 'o7mfr86mok7p', 'tri_361e50', -818906275, -347271276, 'w', -1641998003);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483551, 1223106837, 'g8eizd0', 'u', 1090297537, 'g8', 'tri_361e50', -1739525341, -1301745780, 'wbd', -1194088179);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483550, -379077665, 'nxzfoas9', 'zd', -1859171141, 'r841i6vn9a', 'tri_361e50', 2841233, -1421250640, 'y7etff9', 1245769485);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483549, 1325587487, '5cayzma', '7w', -1672798111, 'xo6stk', 'tri_361e50', -329985830, -603769972, 'vo', 1708336152);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483548, -2015196480, 'wqbvoyhadym3', 'api', 1411559422, 'zjd2zxpmaspu', 'tri_361e50', 2095400124, -2087911973, 'l7jufkhq6sd1', -1639009684);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483547, -381527382, '2pbzz2fp2', 'rds4d', 810930278, 'oymk', 'tri_361e50', 1207986970, -433805586, 'ff', -890885662);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483546, -488726144, 'ssva836i', 'iizc5c', -1933824833, 'lp4l71l0q4n', 'tri_361e50', -886157545, -18383241, '6p67904l0daf', -136826782);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483545, -167254422, 'szsmb', 'zk5pao', -103397202, '5p37ekw', 'tri_361e50', -1618569225, 137778811, 'p091mps38ve', -63563920);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483544, 1604307119, '4', 'z1h52f', -1806662365, '5rr8lvq', 'tri_361e50', -1691017441, -251117267, 'f0wras', 1941642896);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483543, -1418146482, '0io2', 'dui5ig2e', -1584100925, 'vgb68hbw21f', 'tri_361e50', -1667086412, 298397406, 'b5af', 40105431);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483542, -1409454673, 'ynaj', 'pok4nr1', -1724387453, 'xf', 'tri_361e50', -1569360533, -901431319, '572', 1909255424);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483541, -1642662659, 'wp', 'hdbn16', 1847851281, '83ytqv3c110', 'tri_361e50', -1007634016, -577206208, 'acfpx1sia', 870084185);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483540, -904035326, 'uvyn3ea', '7', -1879635632, 'ko5', 'tri_361e50', -703740824, -751761545, 'ks6ry62kek7h', -1599546278);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483539, 1508402498, 'fh8imiukqf', 'xs0f3gcwa', 424895416, 'hv0a9e', 'tri_361e50', 1200950615, 746234158, 'e27hv0uy', 2003079069);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483538, -2072802468, 'pq9c3reyy', 'rfk', 930116887, 'upbwnk4fgnm', 'tri_361e50', -1147403321, 527009374, 'mu28jur73', -129168287);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483537, 1366167506, 'f', '14p8sxfs', -669875813, 'wyo5krex79', 'tri_361e50', 1247815996, -1439679522, 'f8voonl', -517667594);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483536, -1323124482, 'ovv1mq0', '76', -1624902253, 'x10hzmg804o5', 'tri_361e50', -2117029694, -1493853956, 'cnctmrf', 1517298970);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483535, 2072972624, '3o89', '0', 1616298234, '7bfhyh50z3', 'tri_361e50', 1890283060, 535938990, '7rl1wba9', -1288317591);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483534, 793557185, 'yzbou0gyjit2', 'fgscgmfqs8', -2033902741, 't7ni', 'tri_361e50', -1866538950, -375882938, 'q5mmu4crtn', -157512566);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483533, 717146737, 'zbbz1ve2s5ue', 'nd4ryz6', 44143003, 'yy48udesd', 'tri_361e50', -51634673, 1739642220, 'migcgl', -1196019631);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483532, 809734729, 'a5ymsyq', '2m', -1983863928, 'spwou', 'tri_361e50', -761033404, 1609215461, '2gtyi8oy37fc', -1532012042);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483531, 606197245, 'h44ewr', 'gwhf', 1882621652, 'askba', 'tri_361e50', -133093015, 390677204, 'gt1ge577of', 1635811353);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483530, 811072118, 'py7d', '20yo4lx0', -639196592, '0', 'tri_361e50', 93895447, -1424113909, '2b8e', 295349060);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483529, 206731773, 'wweolubk', '0s', -279395570, '0sso', 'tri_361e50', -1109968833, -479088535, '42jc1bi', -2050772762);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483528, -1249282824, 'cso6kngyf0', 'z754ee3rj', 1939911032, 'qmia', 'tri_361e50', 697399052, 1812466794, '5cdpg7t', -2091765007);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483527, 1474995403, 'r', 'a131s', -852880269, 'nsewm7', 'tri_361e50', -8629358, 2132315761, '3c2cvtvmkki0', 309227335);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483526, -947030705, '8azlg', '9b7ke6w', 1257412508, 'z7n00o', 'tri_361e50', -1025286076, -1014980239, 'wjq', -1736726146);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483525, 281168500, 'pb', 'l', -1539051194, 'zqntdh', 'tri_361e50', 463638251, -1225360905, 'dbd', 1804971030);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483524, -469683625, 'xtsknn719nbi', 'vw4hq5zahkeo', -614603640, 'j9cuti0zwcmv', 'tri_361e50', 1021965245, -1359506760, '2468', -1431925103);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483523, 170129609, 'va4tntw8', 'h5de', -878148726, 'mhqms', 'tri_361e50', -1468427304, -320520812, 'arfcnltmafl', 927757149);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483522, -163495062, 'xridwpemvmdp', 'ijz9xfb6', 1730321583, 'b3j17954wgw', 'tri_361e50', -1751419005, 45719889, '64uoryhibf', 1434313721);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483521, 557958017, 'lpwmn8q', 'eop', 1567447494, 'redoattl20', 'tri_361e50', 1922461001, 1191942371, '9zgwoq8e9rv', -1602263908);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483520, 1110551583, '5yty8elwww', 'al4zvb0w', 1636736172, 'ewudv3', 'tri_361e50', 615008082, 1974524165, 'gyf3', -1959945726);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483519, 1774512846, 'bc08gf1tfq', '3b67ki7yi', -465449203, '4y32xcw', 'tri_361e50', 1706325013, 335397121, 'mnmpyojg1m', -1361094350);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483518, -1913444248, 'ythdtlydi24v', '5se6fae23ia', 1554496234, 'ndd3', 'tri_361e50', 845426621, -261447516, 'y8vsand970', 18136058);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483517, -83453733, '0yq40lm2wx', '0fl4s', -884638464, 'os18gifd', 'tri_361e50', -1348238446, 979886746, 'nplc3nev8', -135809379);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483516, 938440174, 'px7if43f', '7tciep9sn5r', 1912475195, 'c8kboz', 'tri_361e50', 999203900, 1518717785, '4unla', -376880628);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483515, 28025589, 'fqf8r3ndj8g', 'aek', -1273920341, '6s9em7bx', 'tri_361e50', 934841428, 2014744654, 'f', -1840633050);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483514, -1321477393, 'rr', 'h6m8o2', -1854136236, 'wymp7h', 'tri_361e50', 1067579474, -916085256, 'kco32ur', -1187231327);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483513, 17819189, 'hrc', 'n9no1mcyqwm', -935943446, 'p54', 'tri_361e50', 961271561, -811319315, 'bttk9rnp', 1082116528);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483512, 542707362, 'e8lg', '1ynq76swu', 1362507361, 'z4p2a9b5d', 'tri_361e50', -904852428, 242182242, 'kf0obtr1w0i', -840310304);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483511, -1827822796, '70v4o5j0foc', 'k0qs', 1646819292, '8b', 'tri_361e50', 809899785, 134617238, 'pu', -1669527371);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483510, -273362763, 'a929yb3', 'ftrf7q', 1734353005, 'o4rnoo9u7', 'tri_361e50', -1591276817, -232573333, 'u', -913847592);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483509, 1944945082, '1tfzyhgh', '3jizr1fu', -1493251463, 'w9zcvgp3u4a', 'tri_361e50', 736618628, 701754075, 'i6mt983k4gv', 558572743);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483508, 517428968, 'y5lx0', 'm5bl2pku0', 447070119, '9wl5', 'tri_361e50', 859573577, -1592380275, '17p', -629227931);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483507, -752294942, 'c', '7cnltrtr', 1804792577, 'ehob1', 'tri_361e50', 1791426424, 1131711472, 'vvegx6kq', -525812376);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483506, 483960694, '8j2u0k8548', 'q', 2057529728, 'fsg3nhy', 'tri_361e50', -1257549895, -252335361, 'j', -1210636064);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483505, -1886162589, 'aqwwb5cbz2il', '2jjm6', 209085026, '7na4w', 'tri_361e50', -1301878179, -1695797651, 'l5w2q', 1861896548);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483504, 231114904, '2pssi04buzky', 'm0pjnq0', -1053324169, 'z1axdxc9114s', 'tri_361e50', 2054059439, -764307310, 'zcx7y', 1435621158);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483503, 1043196542, '5ab2uess3q7', 'y', -1420232256, 'ijuhe27nzxmd', 'tri_361e50', 37714846, -336476666, '0p5a7', 1887975033);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483502, 1968720421, '59e3mth', '1s', 5018727, 'xc90sq6m', 'tri_361e50', 517570858, 2069062652, 'qt4f8b', 254356008);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483501, 1546745684, 'wwpk', 'rsnlh', 43943493, '1c7l8zys', 'tri_361e50', -2102240936, 619931092, 'kmxq', 1034284455);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483500, 1619573640, '5', '43u5', -1624183303, 'bu2yqq5', 'tri_361e50', -1621735918, -1409659954, '3', -555339829);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483499, 1102401893, 'pj9qch', 'wgesfxz8a', 115123454, 'y1ul1wwed', 'tri_361e50', -2041120189, -277713587, 'qwqq54q', 674495467);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483498, 819695236, 'xv57yvh6l', '6gfqnxgycwrw', -3608505, '0t7seki', 'tri_361e50', 1868752648, 203256496, 'v7ld5jf', 1115907797);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483497, 890382312, 'z7dcowum', 'tpv4', 1975451483, 'vyo', 'tri_361e50', 159240967, -193725191, 'yj3v0obs95vd', -1645426325);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483496, 1739620607, 'cwqiem560sw1', 'lk0l7tp', -841742089, '6', 'tri_361e50', 743105121, -1070460651, '3f40', 411991696);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483495, -678307051, 'vuf4krvmnb', '4', -337896972, 'pp0', 'tri_361e50', -305675789, 1229747108, 'bdzg3glr6h', 1856355189);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483494, 22515166, 'wsr', '5r5numa19c', 1189996898, '8lbz3ubwgz08', 'tri_361e50', 1230689024, 1217995041, 'mqqbkdc', 1950943635);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483493, 1737240164, 'j3peb4', 'jaqr', -956531702, 'sr09nz2e8db', 'tri_361e50', 1383473893, 486459045, '0lyf4p5r52k2', -506478214);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483492, -1215484130, 'up2pjjwe9qy', 'g', 1900374462, 'm', 'tri_361e50', 478611977, -1209817890, 'fysh9y8v3ce5', -1250151030);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483491, 1790941031, 'wcl8hon2v5q', 'xsi1onolu', 2037987725, 'm2x9ee3jg', 'tri_361e50', 1489651100, 1987754295, 'idbuw', -2086978500);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483490, -607224912, 'b5y2o86cch', 'o58adh', 1232645771, '4md2', 'tri_361e50', -2074831735, 998420056, 'm83k0bxojj', -66059418);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483489, 770918330, '4n8w', 'z2ii', 1400911530, '913615', 'tri_361e50', 589004356, 818851142, '8', -728799214);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483488, 559819130, '8fsqlr0k8y', '8vq0h', 1380306696, 'r', 'tri_361e50', 1002818597, 119077438, '7mbjghrnt', -1737016712);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483487, -338914495, '650ptz', '00cpumu', 1040894549, 'qif', 'tri_361e50', -1101921958, 1785779628, 'pnm8zg8b2', 1936544059);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483486, 506981387, 'jox', 'm2g', -809924615, 'e', 'tri_361e50', 960728725, -13188019, 'jve', -610239629);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483485, 1255625077, '4kva5d', 'p7ak0u', 1221539609, 'cy38lhkok5k', 'tri_361e50', -1515479700, -1717677553, 'r', 26196098);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483484, 968274790, 'xbk7v82zkjx', '0nuaazgrflq', 1521726202, 'g38mhqaatx54', 'tri_361e50', 158466614, 846063940, 't3z', -1838883056);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483483, 1633350588, '92wisw', 'l', -46060967, 'x7f95k0o06u', 'tri_361e50', -680769346, -1177213799, 'jsoqct5x4', -2056187956);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483482, 944230786, 'cnp', 'yf4yeh9n', 2124257846, '4ldon2eax', 'tri_361e50', 197766476, 1571746993, '7s7', 1828827550);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483481, -1193966265, 'wdu', '3kql', 97900430, 'lv3', 'tri_361e50', 1851884488, 1598890494, 'ci2', -119333369);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483480, 1211424199, 'pt3mhqbm2', 'iko7cgey', -2051428543, 'wsbom2vnvmob', 'tri_361e50', -155078994, 258477549, 'd991y6t1bc', 252743768);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483479, 1307023455, '7', 'f', 1148261381, 's5wx', 'tri_361e50', -584036758, 462612305, '110u', -1379643052);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483478, -254470470, 'pbwbegqwo', 'ggz0n6', 181802548, 'x', 'tri_361e50', -1573471473, -560063872, 'fj61qwwmoi', -1349618536);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483477, 1089129978, 'o8gw6z5', '6n8x', 55973709, '3a9k5dk', 'tri_361e50', -1775605305, 384879742, '8a1b', -1899749389);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483476, -1204013051, 'atog3ni5b', 'ftst4g3', -1337804415, 'd', 'tri_361e50', 508317998, -1834111847, '4tgiirdojw', 882117857);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483475, 836802129, 'gqw', '85djsqfm', -769466451, '0w4e', 'tri_361e50', -427235718, 237386121, 'ir', 1978434901);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483474, 1404983491, '3zww', 'r8n74bt5k', -83132659, 'r', 'tri_361e50', 2082559707, 219789529, 'jzam0abem', 181275815);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483473, 771230013, 'tbg5q3', 'm9871', -51964854, 'k', 'tri_361e50', -1610366468, -531307094, '2wqzp39', -1726810313);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483472, -2086083338, '5v74hj4h', '2', 134041175, '4pdyqr', 'tri_361e50', 1772263447, -1788986149, 'n47bw', 943049279);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483471, 2053892871, '9s8', 'tb9a1c79g', -186415831, 'j1', 'tri_361e50', 1066571588, -475471681, '0dzd13', -627192002);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483470, -10885567, 'b7vp0nwa', 'nnn40yin3c', -1099072808, 'l', 'tri_361e50', -206931232, 1540597597, 'bcv31s', -2055988264);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483469, 2036277862, 'fac', 'jst9', -55131432, 'er81ypsh', 'tri_361e50', -1382894241, -378181498, '5af0yog5m', -710421840);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483468, 1767585151, 'vz0', '171i9jbi5jou', -98454536, 'at35i', 'tri_361e50', 896792952, -1537731400, '4f12ok', -734475427);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483467, 760426891, 'ehjaxso', '83jpmybcuz2', 1220822035, '0kyhwzd5549o', 'tri_361e50', 1788539566, -142452123, '6rg', 1550021189);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483466, -2051497173, 'le7', 'oxrayuch', 1920354104, '7yqu8y8kmox', 'tri_361e50', -1240186276, -1064054159, 'fqr7atvw', 1101231734);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483465, 1655809935, '3u', 's68wf35f', -377649869, 'ae8ovv', 'tri_361e50', -574271559, -1473334750, 'u408n1', 1957901817);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483464, -458964256, 'x9', 'j09k22tr0i3y', -2008412565, 'cp5cy', 'tri_361e50', -102419289, -1065139435, 'vwg4x5p4d', -1968930705);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483463, -1849296793, '3tyeu', 'r5770p', -1618167425, 'uh', 'tri_361e50', 15670546, 415201415, '53uzzjxxme', -691425243);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483462, -1206369920, '6vlznfsiu', '9jm8l03z', -74052424, 'gxxs3c2czi3', 'tri_361e50', -1844543544, -981439232, 't', 998958663);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483461, 1808678572, 'jtrpf728qh', '80scpwa', -716597411, '5r5az3', 'tri_361e50', 1777842391, 1349273509, 'tzfra4', -625028064);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483460, -1150430454, 'rad', 'f7desf1', 1192891519, '68ubhl', 'tri_361e50', 1468650725, -521235499, 'x2aho', -2007754597);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483459, 975648102, 'sij80f', '4opm9m7vh35c', -1988224106, 'bn98', 'tri_361e50', -472946133, -1528325654, '1snxifqle4rh', 407947651);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483458, -1474587815, 's5i', 'gr9', 273817404, 'drloqybjev7', 'tri_361e50', -156163790, -789306102, '5qiagprf', -1024912518);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483457, -715641638, 'us2m7', '7gug0', 1596380336, 'eab', 'tri_361e50', 1946609634, -1930910114, 'eb6rd', 1697548802);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483456, -1617849302, 'ka1wk', 'mx', -924795265, '4xlx28itejt', 'tri_361e50', -863478350, 122413799, 'lo', -276364258);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483455, 1468400030, 'ssxk6nu', 'uc7efqtb3z8', 144940580, 'q1uuqwjuer7q', 'tri_361e50', 1433135342, 870936845, 'd', 396984964);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483454, 354249469, '3ewpx8ft4ouz', 'ebx0g56k', 2027326322, 'cudn28b', 'tri_361e50', -139665856, 1449235781, 'is6n', 1096788672);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483453, 576282750, 'u3hgb1t8', 'evrdyug1b7z', 1613006588, 'lrofzmbd28g', 'tri_361e50', 1072456645, 1294356391, 'fhe0r4gchyx', -1701319747);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483452, -1799263613, 'v', 'vcr', 67829231, 'fueyz9uvwkw', 'tri_361e50', 1559070976, 1576140415, '80ciro63u0y', 2090171646);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483451, -1610537530, 'p9rwh4sw', '3auk072opps', -264873186, 'i', 'tri_361e50', 2038757491, -802431138, '3pgpml1rte', 2067405640);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483450, 1988592739, '1uj', 'oevd1qx68c', 1015314307, 'z6q8hkya', 'tri_361e50', -800191359, 1564681824, 'ibqvlstocb', -1026431108);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483449, -552860240, 'm4yrpbz7z', '1darcrn', -907877162, 'svi6d24ca', 'tri_361e50', -949594475, 675172776, '2jpq592yha', -1522895227);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483448, -590834054, 'ydx72rch1ub', '2', 1451660189, 'auemvdgg', 'tri_361e50', -1965534133, 2115475119, '8k2q5iz2b', -457102561);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483447, 1200849171, 'ui4xl7x', 'u8zzy9r12f', 832043492, '9', 'tri_361e50', 1364158830, -1374137631, '1mtvrmqf2fy0', 1238405515);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (2, 1695438605, 'rsv3vx', 'vg4oqeg', 143746420, 'scr6t0u', 'tri_361e50', -1717740265, -1310462807, '5m9byew1vuo6', -1024328483);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (3, 700843190, 'vceybm', 'eno7hv', -1650660669, '7880r', 'tri_361e50', -234310606, -1854352826, 'bw8g', 1415790785);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483446, -2117371866, 'x5lvurla', 'fm9xewjwr1ll', 557519887, '2x8xhp5ue', 'tri_361e50', -1642767880, 401471040, 'kxoxf62', 1982892044);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483443, 1017506161, 'jsdqccnc', 'rjp', -1549217765, '0jtr9vlo', 'tri_361e50', 376887155, -30460274, '7f2', -1491754727);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483442, -771051015, 'k0yuex52f', 'o01954p3cf', -1730274206, '7sx9m9n78sf', 'tri_361e50', 1690484660, -1548825905, '7w', -921379479);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483441, -1977254663, '5e5e', '3cnn4wrd', -1334498161, 'bk', 'tri_361e50', -1124757541, -2120012102, 'mxa6rxl', 598203404);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483440, -1151485849, 'ycpeuk2', 'c8k0l903', -1259184182, 'hgm524d5c', 'tri_361e50', 175480606, -304797928, 'bdjego3olg', 1257903361);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483439, 594151693, 'j900qzzx', 'b', 1364617738, 's6vd', 'tri_361e50', -133966712, 1344387075, '92qkl6p', 346230208);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483438, 1630257742, '6olrjs5y', 'o', -535457707, 'pf9z', 'tri_361e50', -920419759, -2099933601, 'nfoz', 594146831);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483437, 730629163, 'zynxi47e5mpb', 'kr0vc', 931172932, 'ltf', 'tri_361e50', -1498907269, -1968719559, 'g6bgceurpwl', -788111477);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483436, 664289290, 'vgs', 'skvkyrdvj', 428005408, 'yc', 'tri_361e50', -634368578, 1554996781, 'qh7t0e3v', 394105277);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483435, -1926383232, 'a0yjlks7z4r5', '660e6', -1912480794, 'yei80fqboiiv', 'tri_361e50', 1860992539, -1696223356, 'i24636efcw2', -267159224);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483434, -1686165461, '3n0feg', 'pu0dte30', -1771736373, '31wg5t62', 'tri_361e50', 175470743, 1606807056, '1f3erf3w21', 1837404843);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483433, -1497512223, '9', '5y399jf', 297769031, 'exsrh6e2ct', 'tri_361e50', 820010136, 1128470985, 'mgj87tyyg0bc', 1947914551);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483432, -2038497029, 'k9ohjfg5eayu', 'vgbcuubx2vw', 1976632615, '4rjb2gvbhim', 'tri_361e50', 1777500436, -1474861124, 'cotp', -955274193);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483431, 314772014, 'e', '6pjn', -1826935565, 'yybimy', 'tri_361e50', 1118136426, 564238827, 'shrmlqwl5hn', 1202146317);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483430, 2093356073, 'c5j94ctndgz4', 'cb0618eui7by', -1263500265, '0ohjd7n1eqk7', 'tri_361e50', -669383081, -259463419, '9', 816311498);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483429, -636229198, 'jmxt31', 'fa8263fl', 145321535, 't45u88qyqc', 'tri_361e50', -2090219293, 2041550997, 'a6', 46903249);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483428, 1408612275, 'bqei', '088khrqgoll9', 609861915, 'nf5cvi7gbbcj', 'tri_361e50', 423113490, -1592638177, 'o9l', -1041151181);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483427, 151019646, 'mp8i5vjxuhx', 'luan0uvcj2', 1383214422, 'gsv3auo26', 'tri_361e50', 1915480284, -336659164, 'ly9gzhscjd', 586285011);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483426, -1147560150, 'zsrsj0b16', 'js', 1269434788, '3dskxk0liz', 'tri_361e50', -257002213, 1466665262, 'ofhuwiahipz6', -1801111547);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483425, -1997830383, '89l0xsk1nu', 'xhtwvgu6c7i3', 641435916, 'c548wwe1', 'tri_361e50', -1888400228, -1186922170, '69b5l8c', 766618428);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483424, 2123801487, '693dxk5', 'spdldy9fr', 1063944999, '2pg', 'tri_361e50', 834391295, -594372098, '8cgtz', 1840985872);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483423, -874959305, 'op9fn1lttrqb', 'du8zjr5mrav', -1769716273, '2', 'tri_361e50', -1629911456, 445589183, 'y8gk2', 668549356);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483422, 166672310, '6z7xgw6', 'cnuvsqmv', -1516053957, 'ml83ayw', 'tri_361e50', 1242287500, -1948357236, '31ailh5', -592173566);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483421, 1341350950, 'zub3hiqy3', '5bqyvo', 1256356713, 'nei77o', 'tri_361e50', -2136966440, -107446732, 'h4mot4uh', 452224303);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483420, -1570508649, 'ct3sw6m', 'hq', 1098721558, 'orx8z', 'tri_361e50', 1155669013, -256552821, 'go8fh', 1933913289);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483419, -410640939, '5s', 'ctik34', -2000284440, 'yjegc8dmdj', 'tri_361e50', 1604563613, 1917800480, 'jt9o', 1558222627);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483418, -1616511616, 'w', 'ihqswyo5s1d', 780908370, 'eoppuzu4', 'tri_361e50', 1887673296, 97420804, 'w3obhsi93pv3', -306734603);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483417, -301597438, 'f', 'w', 1558071049, 'q', 'tri_361e50', -386852259, -298855774, 'lbjkj', 138273153);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483416, -2027259463, 'd', 'yb7', -715421968, 'c043yta', 'tri_361e50', 1198016976, 1566811727, 'tg6genzlohan', -1591515995);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483415, -645674648, 'aw7v0g', '9', -861185151, 'os2kpnu', 'tri_361e50', -657742225, 1369494745, 'rsr93q', 1154216610);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483414, 119640681, '98novfhx2iwb', '49rnqauvyd5', 1847107035, 'bshu4nm', 'tri_361e50', -1512679483, -974732319, 'y81m59lwa3', 1879715547);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483413, -482006612, 'w', 'yovweso', 1490145702, 'fx26rdkh', 'tri_361e50', 195574986, -1453123983, 'qyrnemc7', -1092410030);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483412, 757063700, 'a9q', 'xbb3', -1281616368, '1ejrb', 'tri_361e50', -1969923734, 1187610151, 'kjwufdjth03', -86891337);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483411, 247564068, 'z8egrpmkm', '95zhayllg', 191944482, 'nm1yh', 'tri_361e50', 1855532923, -1050207168, 'z4tfenoz14h', 1860963937);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483410, 1611840422, '71gduwzews', 'v', 1951927685, 'r28dtg36ik42', 'tri_361e50', 1978612381, -1886348638, '5le', -614122296);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483409, 163272269, 'vvpwfirw', 'tjco', 721167835, 'jzm0bq5sgapb', 'tri_361e50', -1606568866, -1883687375, 'wgt0uo', 1495515983);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483408, -1001154646, 'wwmrksyn', 'nbxd4cgu', 1086340801, 'q80', 'tri_361e50', -1172782035, -2127009375, 's4x1x68', 2110705707);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483407, 2079004750, 'w8phn20pz', '6d', 936907637, '32keglm4xlmx', 'tri_361e50', -1733523871, 1981854539, 'vp93ukz', 501565740);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483406, 1318893936, '1owunen', 'kuq', 695028848, 'bc5rwed', 'tri_361e50', 856228694, -2004819872, 'mvhuo7x', 2069444479);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483405, 1673009560, 'oyhpo', '3', -1915815636, '7', 'tri_361e50', -759061234, 912783278, 'hq7i', -999768437);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483404, -680600659, 'g0tngj', 'glys', -311034279, 'rdy69a', 'tri_361e50', 965848740, -1430723102, '5gtbhj', -1525723714);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483403, 2114107506, '83s', 'v4r0dfemfx', 2084270157, '7oykkee454w', 'tri_361e50', -127822928, -1415926162, 'w4ipghhx', -1226076347);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483402, -846039969, 'a3ahae', 'nxb1', 192303367, 'a3', 'tri_361e50', -522630408, -1860046249, 'h', 711893924);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483401, 1246797346, '35l05o7x7ku', 'fbpj', -1222432674, 'ibt6n6d', 'tri_361e50', 1982905497, -844146089, 'h54u1rlfpo2f', 2036901614);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483400, -1279653902, '5cb70hv0f', 'gsv6k5jz', -1852122034, 'dps', 'tri_361e50', -66208791, -612028171, 'rde3iit5r', -1344974807);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483399, 1886537562, 'xwkbiudpi', 'd', -723075109, 'nbkxn', 'tri_361e50', -627247352, -972642567, 'qeh5y', 1834664181);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483398, -897218401, 'fba44oi', 'gf', -405487457, '0omn24fhia', 'tri_361e50', 484071324, -2017339797, 'daopb2hqh9', -481974086);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483397, -649011566, 'y34ga', 'zdn8enmvvo', -2141604550, 'l0fn8', 'tri_361e50', -531132215, -1906384371, '4eacx', 1095134296);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483396, -661834063, 'fz', 'akgkbw73', -840071302, 'q', 'tri_361e50', 1812563288, 1329580554, 'l8yljop', -1139878536);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483395, 795884681, 'hbc0hk', 'ma0xt7ctq', -133671720, '6ioda', 'tri_361e50', -796439713, 2143577246, 'b', 1111219960);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483394, -1046652383, 'icdw9my79b5', 'jh', 657017017, '1zx3jtyjq7', 'tri_361e50', 1273963101, -1448770790, 'em41o1e43zg2', -1044155597);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483393, 1266354799, '97ban0gs', 'jdc3ux', -1512798983, 'nkptaek6c', 'tri_361e50', 349595487, 1055416468, 'ua0caknl', -1527869658);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483392, 129789586, '1zrp', 'esh1j6', -245538021, 'too6', 'tri_361e50', -1619211839, -2104524092, 'r', -1241251835);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483391, 18988390, '9g9bql5mg4j', 'c', -497448576, 'wq7xbotorb', 'tri_361e50', 1313609104, -1994757202, '7pw1pr', -1789232128);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483390, -838211954, 'vuznkrmn6', 'q', 1183864222, 'pf0wmt1i', 'tri_361e50', -770811248, 687350697, '8u1stbvg3ep6', -1433684839);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483389, -1070943807, 'dzb8gkpjjs', 'kb1t4344', -1870613146, '0m6i', 'tri_361e50', 1444383927, -1104744796, 'gcmmvoxggdoa', -1918049476);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483388, 442620140, 'rbe8xt9el', 'resi2axj4xv', -133255248, 'k36xq0qr', 'tri_361e50', -321005839, 1603717664, 'dbmuuoy5i42', -1925413552);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483387, 1474516388, 'c88r9rioo', 'vic6jhnst', 2030823347, 'oin7', 'tri_361e50', -2125109507, 582689394, 'lrilc1ivv2', -839462500);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483386, 2021304676, 'ssgyx6n', 'mgnkulyz', -915189769, 'u2tzzg96d', 'tri_361e50', -954865462, 853195076, 'g5', 497183252);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483385, 535715591, 'ex6rybzyg7bj', 'g', -1999060793, '9ab5lf', 'tri_361e50', -1963357299, 225242488, 'g', 274358254);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483384, -1379248188, 'w5x', 'wkl5x8kv9nn', 2029407146, 'wanwyrkv', 'tri_361e50', 737380008, -2056090438, 'c6', -396063843);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483383, -1060907640, '4b', 'mvvnq', 1569905898, 'wf89m6hp', 'tri_361e50', 55752568, 582897735, 's1', -683277697);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483382, 1629743676, '9y62d', 'oonitsx', -1666063066, '53', 'tri_361e50', -2138262720, 1918450866, '2pj8y9zk', -1538526166);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483381, 5139198, '8', 'r', -1543141417, 'gttjw', 'tri_361e50', 1466531961, 1043275303, 'sxd', 795592870);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483380, 1778340458, 'asaybfo', 'rof5th0vl', -1023855960, '5', 'tri_361e50', 1175053967, 2061341679, '58t3s', -840974360);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483379, 689321153, 'b5z', 'vvh', -1549139661, 'gbz5sjp', 'tri_361e50', -471355538, 2068204725, '4ztwx', -150105883);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483378, 1722128925, '0ljbw2z', '3e8', 1278307621, 's84c8ug8', 'tri_361e50', 971383322, 2121728725, '8op0vwva69w', -1855301067);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483377, 1528003720, 'yvhiul1s1lm9', 'hcln', -1427514720, '284tnwpq1d', 'tri_361e50', 221612394, 1810011867, 'wsxbp', -1011343027);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483376, -1628794802, '9lyo', 'rgm38ip4qa3', -206625658, '14ni', 'tri_361e50', 680569129, -17414292, '5rh9a13o5r', 1512165017);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483375, 1555651099, 'g771ls6o', '4bzlvhzy9u4', 1804395627, 'jo7k', 'tri_361e50', -469256800, -482062194, '2', 1496714606);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483374, 570511188, 'otkryl3crkur', '5w', -749302735, 'jn', 'tri_361e50', 2020048142, -2135913616, 'qsg85cgtex6', 1844162084);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483373, -1565840126, '1jntw', 'l5ba2d16', 1077831723, 'w9ew995', 'tri_361e50', 2059429519, 1377352073, '3x7fjhcy8sm', -1312339657);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483372, 1168987768, '6lah1c', '5jkvwfb', 541533499, '90ih7f', 'tri_361e50', -2018142211, 1849192482, 'tz7dr8nv', -1009761695);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483371, 1262299873, 'jt', 'ezu7e7z', -1937433979, 'erwy', 'tri_361e50', 651884446, 246507387, 'c6m20hnns1', -530681237);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483370, 963413602, 'z1m3wqpcp6zk', 'q', -2020002009, '2wmcdro0lx', 'tri_361e50', 422588408, -868977593, 'q', -506829124);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483369, 2051849482, 'oib', 'ovjm6', 856059074, '5054e7ix6fuv', 'tri_361e50', 1054959634, 1364197795, '5jy', -1768179682);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483368, -789799785, 'vwv66o7', '59bp6rbvfu', 1922343784, '7', 'tri_361e50', -79502516, 1444558858, 'ssg', 1527325195);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483367, 1711049849, 'd8777', '0o5wdn87w5', -1390068705, 'n12zs', 'tri_361e50', -1426764181, -1349882526, 'mh8r93dsnwwm', -1367927962);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483366, 153037223, '888t', 'ywnrf7hik', 1748538601, 'bw4', 'tri_361e50', 524315607, -1923707338, 'jvb3x44wn', 334423957);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483365, -2049480188, 'k', 'zg', 982936126, '4az', 'tri_361e50', 2006072444, 1965600232, 'e7gidxr', -1817458725);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483364, -246241448, 'obw', 'vyny4t0', -527809291, 'q', 'tri_361e50', -806829223, -1297754035, 'r05j4wsjy9', -1372261330);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483363, 2067066391, '6fwnue2uw8z', 'edj0rck', -797621694, 'l', 'tri_361e50', 907351924, 1343035697, 'rvy6h', -813415704);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483362, 39309901, 'y9hfdywpz', 'gqqpbl7', -805366872, 'u', 'tri_361e50', 1467452311, 1074935521, '3rsmrdd0', 1007099555);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483361, -685984423, 'q', 'aa91o4z0tv4y', 560716817, '1ai4wvm', 'tri_361e50', 481795153, 2036557227, 'lp853lvm4c', 1449616595);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483360, -1911003022, '7blsjr90vk', 'e', -358648962, 'gpkmjxt7v', 'tri_361e50', -29204319, 1202635820, 'xb4nbp86', 1346554675);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483359, 846329907, 'h5q', 'yz6o014xmg', -1863575077, 'zqd8cfod8q', 'tri_361e50', 430720840, -1910148092, 'iq20e2on', 1898317282);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483358, -1482855942, 'vk1rn9ses', '61b', -1144557020, 'vfvj6l4hww', 'tri_361e50', -51743315, -78263934, 'ihi6fm0su57g', 751764864);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483357, -1331594737, 'ysbfdo8fyb7r', '10399', 1053476594, 'l6', 'tri_361e50', 263826902, 983647968, '89e', 1829562448);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483356, -1438461659, 'mimk6m3i1', '4v', -926055679, 'nb', 'tri_361e50', -1640572025, 333685450, 'un8', 1325779776);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483355, 372343812, 'p5nnb', 'lyzp7es2a', 1854761306, 'uvk5m1xe0ky5', 'tri_361e50', 1802340352, -710338374, 'tdeeq24q3ogu', -997281907);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483354, -1466311959, '2ko0sju8m', '1fvyl', -1988304907, 'd3ubs5wchz9', 'tri_361e50', -1604746925, -750824002, 'mefq90a6y9i6', 194876705);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483353, -1336821642, 's8r8a2d', 'ol8ejww1', 1820389501, 'hfi', 'tri_361e50', -890768053, -1695609758, 'f3', -1458668182);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483352, 1375270252, '53d', 'bzk', 801339075, '6otic', 'tri_361e50', -1797213524, -360396901, '4j28r', 1205957043);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483351, 1381074171, 'hjye6wr3i8', 'n3', 549051331, 'g1nq1lgmhuu', 'tri_361e50', -625449959, 1205507194, 'cwiu', 459174870);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483350, 1687180109, 'xy', '0fer7jrk4f', 276252954, '703xj86m', 'tri_361e50', 1927136448, -1699383411, 'gy6h67h', 2004025240);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483349, -1766677738, 'vk6keybox2y', 'ougei3u81il', 471531767, 'e', 'tri_361e50', -1700387739, 1062175029, 'f8noy', 1918811540);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483348, 2141086439, 'lxp', '9xup', 33161729, '1', 'tri_361e50', -1983950939, 1312156264, 'hvnv9hm8mlmb', -1525779063);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483347, 920753088, '7', 'tk2r9', -1309776906, 'ah', 'tri_361e50', -537631851, 1059253306, '1de1f6shhg', -371794657);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483346, -335428815, '0mggzg2', 'l3mz538', 1697795712, 'uv3', 'tri_361e50', -1642739212, -309724744, 'h8dcjjhdxixn', -201380181);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483345, 1986948485, 'h22mrll3m', 'x', 506516231, '0c377xpor', 'tri_361e50', -480410126, -1752095748, '5scmmn2o', 1046104821);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483344, -875592520, 'yenw', '3arc', 72617350, 'fb', 'tri_361e50', -514720025, -667786356, '8ef1btc', 1488082034);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483343, -1375654369, 'z', 'gm1q5cfedj', 1137987393, '0rgem6w', 'tri_361e50', -688900015, 1435579129, 'hhfgxi', -242388397);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483342, -1253938544, 'yq1ir97b6', 'rq6q', 236308214, 'fdo', 'tri_361e50', -581283516, 1373886335, 'zx8p2qb', 1785989210);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483341, -1247150265, '56', 'iwg', -1772278859, 'r', 'tri_361e50', -950391558, -1869484693, 'kvu26ha5m8', 1082339328);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483340, 166044930, 'oxwo3w27b', 'mhk0m1y9z', -429166135, '9g4odut4o7', 'tri_361e50', -1588287532, 1474252587, '9xn2v33y', -3077684);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483339, 1420793262, '6fqja7y', '266819', -356351655, 'dw', 'tri_361e50', 237963077, -818846895, '8i68le', -144430597);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483338, 640115273, 'rfsr0f', 'rstvh1eo', 181183695, 'let9ux', 'tri_361e50', 1167248608, -2087520291, 'tmihi', 1487124213);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483337, 1461758970, 'oktw18', '8gzfx2mw', 1465364940, 'g', 'tri_361e50', -934924227, -1269509272, 'ie06mi36cx', 213977435);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483336, 1484248210, 'c1t', '14x', -50677188, '6436zuz4lyw', 'tri_361e50', 275649200, -908902737, 'wlk', -792921891);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483335, -730586548, '7426d2', 'ikyt03', 446874265, 'gp1iutrx', 'tri_361e50', -1194553783, 313812634, 'it6yaa1hkio3', -605607430);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483334, -652609452, 'e', 'ewd', -1550449145, '5absh8', 'tri_361e50', -476347711, 542565611, 'jgq', -1287057418);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483333, 1754713421, 'hy56c2qrkfy', 'hkg03ji', -415684606, 'p', 'tri_361e50', 694152748, 1198649656, 'jkz25nkfa', -412534230);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483332, -595473613, 'rzuwn', 'axpvmzte', -1319427361, 'r', 'tri_361e50', -1074038075, -898712676, 'xeb', -1808289500);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483331, -1551071653, 'mfbl2p7saxl', 'apvegu6k', 73761210, '2', 'tri_361e50', -919835558, 870891637, 'gnom', 1782020761);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483330, 921213226, 'przns', 'nwikeqww', 1989624258, 'blmgiv9j1uu', 'tri_361e50', -1340967979, -942027205, '5e3rys0re8', -1830475342);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483329, -1320181724, 'uzt0tu2', 'f', 1562566175, '527siqxo', 'tri_361e50', 306649323, 313242270, 'd0btn6a79', -500918300);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483328, -1000138230, 'ttgsup5f4ye', 'uvmr6qu73w', -2056595376, 'z4wd2007j5l', 'tri_361e50', 1557429671, 472821481, '0uo5p', 654967000);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483327, -1333781166, '2fg6vj3sw00w', 'tueew7p', -563381786, 'kaiuogce51o', 'tri_361e50', 1363375930, 540631992, 'ytme17e87', 1786625982);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483326, 1360449174, 'wqoq6', 'c9', -419024841, 'yhwr', 'tri_361e50', 2082047610, -2067326520, 'fz89', 1404446544);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483325, -1476254168, 'dwbhcginmur8', 'uouymuh9', -1586025952, 'd', 'tri_361e50', -1301750530, -138759218, 'vpyod72', 226715831);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483324, 698550133, 'ahq844sktyeq', '7', -500887114, '2zt3yjeu55', 'tri_361e50', 1106666469, -1201157010, 'wkusk', 1438749211);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483323, -2031422381, 'zl', 'tzpn', 182364100, 'ff6q', 'tri_361e50', -829461295, -456741348, '2n55cpuski', -1075072581);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483322, -1039466266, '5y', 'juhuvt0sr', -1569216080, 'foyy75', 'tri_361e50', 1478646247, -1904389584, 'd0vrjoh', 1834940742);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483321, -873415873, 'khmq5o7hy426', '95zb56126nzb', -1341873976, 'q', 'tri_361e50', -522891684, -177715171, 'dhj4ej', -1557367834);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483320, 51723575, 'kxia', '24pq', -960892661, '8m2', 'tri_361e50', 1538955861, 2092367737, 'kqixpi', -1604525226);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483319, -296637401, 'pe3lh4qe', '4nqiyzb', 1691085404, 'noygw9l3n5m', 'tri_361e50', -699890766, -431958009, 'igstb0m5m', -1000758314);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483318, 1360018078, 'mrmjs', '8cjl3ofmf', -307822434, 'rk', 'tri_361e50', -1409664386, 6088369, 'n5xz', 74748376);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483317, -404863744, 'qs8cwiy8q55', 'dt', 1148244357, '34fcw2ykn0z4', 'tri_361e50', -14104207, 1786411646, 'f7w5w7htfta', -1743758368);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483316, -1990647367, '00db2lo5n5d3', 'ppyn6', -2047781785, '1m', 'tri_361e50', -717775387, -44725662, 'r', -25330880);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483315, -458260138, 'u48jesh1ts7', 'uduomkfpto26', -2005037926, '0t81bocwbxki', 'tri_361e50', -1529259629, -2011325394, '7lj65', -1384041286);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483314, 2087608847, 'sy6z5bfvlxd', 'dbj', -1473780004, 'tcnn', 'tri_361e50', 26584749, -970611568, 'jc666mr028dg', 705951127);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483313, 1192604586, 'd72ll', 'ci3yqlxqa2ui', 1332913261, 'zfstt2f1', 'tri_361e50', 935409151, -1328952369, '1bijg6hmdmqb', -1889473904);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483312, 1065839518, 'gqt', 'y', 574133924, 'n38yx', 'tri_361e50', 453382234, 1988224128, '44k8zytn', -1545727044);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483311, -180771098, '5xmrc0la', 'bk5yuo4c', 1923271127, 'x', 'tri_361e50', -1355369542, 310938316, 'cjrywyjs', 1177636404);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483310, 1730627134, 'ewrtvbih96hc', 'v6nmxk7m1a7', 1154639708, '9', 'tri_361e50', -1025060773, 20278677, 'tx22', 2143541695);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483309, 1330200305, 'hcbf84g4ocp', 'tixg4a3x6e', 684318583, '51cxe3vd', 'tri_361e50', 2057238893, -570406863, 'b2', 453495387);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483308, -935929335, 'y', 'fyovpy0wmgp', 823605438, '1ca950i1l', 'tri_361e50', -701494922, 1585002385, '26nnsig', -1789226964);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483307, 414555540, 'a', '9i8g', -244938863, 'jjnxxlwf', 'tri_361e50', 1816801845, -955111449, 'eagcovn', -1740563773);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483306, 1381706737, 'cc1t4cl8', 'y', 337774687, 'q1', 'tri_361e50', -57415019, -1735546444, 'sm8006qd', -583474965);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483305, 494810468, 'fq', 'n', 2050756490, 'rxlg', 'tri_361e50', -1210897350, 1669976770, '4df1fx', -76263662);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483304, 578436775, 'hb', 'rfaa4x1op0', -1235189228, 'cgw8wmwjepl', 'tri_361e50', -1010902076, 873061216, 'at99trus5y', -1076578406);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483303, -1479771555, '7vfjo1uvz', 'yxp3hd9c', -204410967, '5e', 'tri_361e50', 476032667, 1609876806, 'qt6w5', -113510792);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483302, -512924795, 'vgs', '9ownf', -1724574019, 'fql08l2lz5', 'tri_361e50', 1453659717, 1056676235, 'yl2', -1477188947);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483301, 1527873728, 't834iq30jaw', 'oe5piyopku', -1573346907, 'noeb441bwa4', 'tri_361e50', -519600847, 440941773, 'upd9f', -467729993);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483300, -51503563, 'p7wfpknp1', 't8v58mj', 1873748354, 'farrp2', 'tri_361e50', 1469530701, 1038210919, '26qcb11szjzb', -278258702);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483299, 545746779, 't3oly', 'b2qq6mji', -1382170728, 'ikd', 'tri_361e50', -670368858, 1677564153, 'd72d', -1165450724);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483298, -649944300, '94pm', 'zp7mugy', 1793920356, '2av0s8942', 'tri_361e50', -1384212083, 1536417315, 'rctlhhv4', 792770659);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483297, 1499819485, '7ho99ieg', 'n1s', -1932444500, '1ty8oj97u', 'tri_361e50', -1571474804, -426771780, 'gid9ym', -1600525032);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483296, 1292444356, 'rc', '5j', -234375625, '4804gwqw', 'tri_361e50', -76271955, -433484177, 'b6gebsy', 687335715);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483295, -1506324707, '10c6tgz', 'gny7slm', 1381055728, '1o2b23qgo', 'tri_361e50', -1037958588, 956982862, '468shu', -319046726);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483294, 229658125, '9n5hh', 'm27s23', 738937502, 't', 'tri_361e50', -289838964, 1982414010, '39uywi', 1746429914);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483293, -303980304, 'n0g76ug6p23k', 's0h6p', 2065423483, '47np', 'tri_361e50', 1064440383, -248925756, 'rhl8y', 234085164);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483292, 689833258, 'o34noo0', 'dh', 1914641245, '3az7e', 'tri_361e50', 138669121, -313478403, 'kq', 1570472992);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483291, -679275782, '3', 's576os945', 1985299439, '9y7jnsdo6', 'tri_361e50', 1180229837, 1353345170, '03t9yb4', -227329299);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483290, 248037371, 'btfsaddq35zk', '9bxgcxrohc', -137756108, 'czih', 'tri_361e50', 1987967420, -1334120251, 'uwb5i2wm0fz3', 1162846313);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483289, -1989357824, 'gp8qgbwm', '2aw7m7u210', -1964975930, 'pl', 'tri_361e50', -668900313, 1697345526, 'e27f53wo6', -882222474);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483288, 550752627, 'rlhh', 'kcnnn7pezvjt', -1654951544, 'myu92uue7qr', 'tri_361e50', 926091597, 1803575573, 'lh3powir2zy', -2125354136);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483287, 840886873, 'esnmuep2wt', 'i9o6k989cm8', 363764869, 's1kyfq3jdq0', 'tri_361e50', 1378812550, 861253940, '8', -1359337969);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483286, 1417771645, 'lo', 'glqvdh', -2033784975, '4i8g8zfdmy62', 'tri_361e50', -5143941, -884040380, 'ritekz8hymkw', -1727543171);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483285, -654768892, 'lpuqiobpcl', 'w8w84vc8', -683622754, 'u81hu8u6y', 'tri_361e50', -1811789210, 1917843631, 'bm6', -932604798);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483284, 1589067104, '2xt0mw', 'qu6rq790', 474792315, 'b', 'tri_361e50', -1734611996, 399536658, 'm195', 811508252);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483283, 673549099, '4otnt', 'aj5pd6', 1822187373, 'bo', 'tri_361e50', -1651750393, 394997291, 'uck7c2gjk2', -546964867);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483282, 816680373, 'prryp', '140gkq34', -1329222456, 'ij134y8p', 'tri_361e50', 1675800747, -825421507, 'k81pt3odz', -255599205);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483281, 1901659471, '3hll', 'kkxrfqozw6', 1050860795, 'w', 'tri_361e50', 713833531, 1663384086, 'z57htleht', 1594546654);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483280, -2073892118, 'jahdxp', 'yaszp3chnxy5', -1690183533, 'aaz', 'tri_361e50', -1035422822, 1047192483, 'f24qb', -322138941);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483279, 884928726, 'kz0', 'y5tp', -1833183582, 'fvaqq', 'tri_361e50', -509726737, -228187021, 'gm4dg8gwsnw', -1611217771);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483278, -2039220531, 's1', 'ffr3q1', -550636585, '76pb6hav', 'tri_361e50', 518108400, 1516306669, 'dtj', 1792218152);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483277, -2008361061, 'jj34z4v5xy', 'kjb3tw', -918069529, 'whvjr1kbs74e', 'tri_361e50', 1822017014, 1830988367, 'mqic', -1872563376);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483276, -11944136, 'pgca103', 'jhsuu1sxf2', 1251027962, '6r8iscnun', 'tri_361e50', -580700684, 1808766257, 'f6e279bq', -1601938207);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483275, -13758928, 'bco1ru', 'ib3hv', 816380492, 'b9l0k', 'tri_361e50', 1776784660, 484791330, 'cip7geck7c0', 392517370);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483274, -29330289, 'cw', 'n5sgwqk8s', -1746162708, '35', 'tri_361e50', 2075691244, 1964597457, 'dma562t', 1694324400);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483273, 135976811, 's', 'mx', 1828290855, 'pni8w', 'tri_361e50', -1508487603, 1952398423, '8n7mpy9d', 1917028705);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483272, -1601089346, 'c0oytsb', 'ppj7p1gnsg', 1772284673, 'zip235fsta8', 'tri_361e50', 1418303339, 1664861460, 'wtr8', 546266675);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483271, 452602850, 'nxu', '5', 85014253, 'vzwip0mq9', 'tri_361e50', -50835551, 1869054128, 'rsjtcv4qdq2', 38771107);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483270, 687248878, 'z', '519', 1663192, '9qrq6ht', 'tri_361e50', 51685642, -487943775, 'zk9h', 954690168);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483269, 1583168814, 'r8', '9163a4dz7eyo', 1210976377, 'o8kms', 'tri_361e50', -633152535, -538808601, '2w5p1', 1332858002);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483268, -1976996318, 'gbu4pcoi', 'iv16d0', 1305023800, 'kz6vs6', 'tri_361e50', 837906497, -470645328, 'kmkv3', 170256065);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483267, 851425000, '6o40gg', 'l46', 522002198, 'e5xr39a5j7', 'tri_361e50', 458431481, -1939087535, 'dwkyw6e5p8u', 1908485562);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483266, -984631189, '7kx9e', 'blrsfjzm', -1519106311, '5q7i0', 'tri_361e50', -1310660701, 20300974, '3ifpba9f', 661220324);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483265, -1296801141, 'ssiojy', '87', 1773103321, 'jqh6dtk', 'tri_361e50', -1299830905, -891943442, '3eznqg', 186290886);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483264, 119640078, 'a1', 'aknqs3hytuft', 1379006740, 't918no6td', 'tri_361e50', 798567448, -276207432, '57aw6orkqonj', 974096862);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483263, -835463987, '3oe1jw6jfd78', 'vnrochrkut0', 349248581, 'seq8uh', 'tri_361e50', 277745614, 2106363395, 'k27gri1zpdf5', -374233377);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483262, -1654338664, 'ssxt', 't05', 199901172, 'ze410sw7bvy', 'tri_361e50', -886235097, -1840273488, 'z', 735965493);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483261, -143587773, 's0o7yjqh2m', 'ylq5', -949138191, 'o', 'tri_361e50', 204399674, 1701433223, 'shu7gijk', 1473031484);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483260, 2038413685, 'n7bjhahv35', 't6xfgf5y9c', 526900615, 'lhmcpgs3b', 'tri_361e50', -361510214, 1659431306, '6wjo57hc9', -1779668654);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483259, 2093483999, 'psyv21nj', 'b31ilgmd', 1054552154, 'koqj', 'tri_361e50', 492805829, -118818543, 'phuriie5r2lx', -202336406);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483258, -2140486197, '2fu6', 'g46xmv7099', -1577312830, 'lm', 'tri_361e50', -387673772, 524322753, 'loa7b4ck', -1422350405);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483257, -276018682, 'x6hiq', 'p568fysmu656', 1436580680, 'q3m19mmpuwu', 'tri_361e50', -1962414679, 950002088, 'i447if', 1947513655);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483256, 412523651, '0', 'czvucw2dshm', 1424063288, 'fzwyz7gxef3', 'tri_361e50', -1404069067, 1093815289, 'kut2', 624681103);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483255, 729660418, 'cyz', 'l48e0c5tu', 1210046241, '5lu', 'tri_361e50', 1040419307, 1545774314, 'kkkr9m9xla', 463634666);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483254, -732797800, 'k', 'gza', -1046708331, '1pan3gwhkuz5', 'tri_361e50', -1168581643, 1675423549, '2of3', -437038216);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483253, -1502509148, 'ebilnmf', 'r', -1920836506, 'wva0', 'tri_361e50', -1547253296, 1048532554, 'xk8m', -1035951823);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483252, -982491762, 'jo686oz6q', '0z', 1106508001, '8k', 'tri_361e50', -1224814430, -1653459500, 'kqm', -1337566689);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483251, 366372531, 'qpt', 'i7rxs3t3', 629795967, 'kp7bno4grg', 'tri_361e50', 957803762, -1539290082, 'vnhd', 996612284);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483250, -741629244, 'jahjw', 'vc8qhrc218za', 1903759846, 'vu50l', 'tri_361e50', -17488792, 38262851, 'uc5n8u5q50li', 1236314405);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483249, -1850958490, 'jrlf', 'dp', -1403416252, '7wfmgdx', 'tri_361e50', -1946481802, -723168006, '2grrzt', -1610306717);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483248, 1967423045, 'ao6xhwvxj', 'fkmni2', -1264238293, 'goyuznopf43', 'tri_361e50', -1974152535, -162680121, 'wwu', -1536539553);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483247, 1219758373, '8uha', '67ks38chi', -979421083, 'xmg', 'tri_361e50', -625733555, -1681153347, 'qt4cxkzyu90q', 1971105235);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483246, -1923863828, '4212bsi9cw', 'u3jdcf1f8', 60317687, 'ohr9hbk', 'tri_361e50', 153008252, 2097717071, 'ye0z5', -808645819);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483245, -544953005, 'kr7msz9ja95g', '5c3yc', 2112704861, '8u', 'tri_361e50', 1095232139, -698113247, 'v5zj04n2ovn', 793810114);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483244, 604581288, 'd', 'lm', -1287413821, 'jeb1g', 'tri_361e50', -955903253, -341856264, 'z9sv054lz50', 100457377);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483243, -963266092, 'drnqzhk', 'm4laax2ck9u', 1567655194, 'fohmpzgilz', 'tri_361e50', -1823578117, -1185039975, '2', -1877149646);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483242, -1560411935, 'w', '0rmlrf1xij', -1624006993, 'ts', 'tri_361e50', 1774870594, 848843391, 'wton', 2043517073);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483241, 430653222, '0m6z', '55rxn73g3', -301543623, '0ep', NULL, -1780789646, 997651090, '16l8p6aoy', -291904636);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483240, -505500510, 'z5iutnp', 'kn', -1232474805, '0x', NULL, 1555421734, -1634681698, '661tuy', -1878252246);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483239, -1325333183, '3rzk2vgjeokh', 'uc04p5deu', -618458873, '2romfao', NULL, -369867086, -1175145855, 'uc52af9r248', 254773428);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483238, 2038927994, 'w9x2qq', 'jz', 2107017019, '5ve213nm8dm', NULL, 1699765606, -1439542559, 'ut6832', 462025253);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483237, 1658777627, 'muow70ucev', 'm', -578211970, 'bsd8y9vl55j', NULL, -880589128, 1054408855, 'fe', -532015685);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483236, 1074460419, 'nnumr811', 'oijm', 1715346421, 'f4uc', NULL, 435711573, -1068477369, 'd7fg', -2001762254);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483235, -892171088, '4pdwjz', 'qiw06m3zq3d', 306509417, 'qt', NULL, -209237685, -810446539, 'fvy5ycw', 1035685253);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483234, 1234560080, 'dnmr', 'bk', 1648317816, '3zkfw3y', NULL, -1115542925, -718201767, 'vqb61d2tk', 24750051);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483233, -1296550317, '7niwjv4ybr', 'bb0xfml4q', -733950398, 'oae4hjq', NULL, 94132292, 1914748025, 'jlpfdabb3', 1907260721);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483232, -148897540, 'zcrd', 'dhar6', 1958004332, '5kcz0j32yk', NULL, -9440707, 777653219, '5qg5a1msl', -1874084293);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483231, 1939122331, 'm4r1o9zzrk', 'wc56ax9o', 385580207, 'a233cg7x', NULL, 736831169, -179788128, 'dic0w', 1470262048);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483230, 452113082, 'kw5bo260', 'ock1njai9', -1486143393, '0b2sz', NULL, 737269765, 1919110979, '5tbs84', 516114056);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483229, -2051046141, '06n7', '39gv', -2088467654, 't', NULL, -1298724739, 1523344744, '1txxe680qu54', -1888639471);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483228, -1117938828, 'bl9zgnp0onxt', 'vt4ur7xiqxq', 920367921, 'f6b2bu2or14u', NULL, 1586311260, -421961353, 'bs06', 1656804625);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483227, 1161152437, '20wcs4', '2crce', 242133105, 'jxz7hk87sln', NULL, -888694463, 1465733016, '8eio', -620106922);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483226, 212772104, 'he5x4lu6u', 'k5im4fgg', 411650017, 'ry8i', NULL, 591230628, -2147192269, 'g', -1166916417);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483225, 894604433, 'hbgrvbnnws', 'wjk17de28', 1677479985, 'z', NULL, 21915057, -1725960389, '7', 1441785747);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483224, -958853197, 'hox', 'oq6d07v8', 838530815, '4rbr', NULL, -137946242, 155271179, 'sxtw', -821373845);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483223, -585112618, 'khsaz', 'r0xdnifbtr', 1400662954, 'bef6qs1vc', NULL, 510023144, 2098551431, 'kqia9', -1652517991);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483222, 2098646552, 'lgh', 'vqk', -661682641, 'th', NULL, -1971862097, -372090212, 'ifgzo7', -688714910);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483221, 442504630, '2ns8ak', 'mk3d0o8w', -1286148077, 'rhb', NULL, 1750750662, -261961242, 'c11qsbmusa', -1143612096);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483220, -585973813, 'o7me', 'xvorxg4jkeh', -896367943, 'umr7q0x', NULL, -60833115, 1542895023, 'y4ufsib1mowh', 1767751643);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483219, 40732894, 'xxr', 'u', -1640379444, 'q', NULL, 783873127, -1636684433, '3b0k1x', 1307437815);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483218, -852008874, '4bg3', 'ywo2x3myiu', -2102275434, '35pljyq4d', NULL, -638218519, -99779201, 'i', -1706391949);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483217, -1889875885, '2', 'ty', -1177087922, 'ur5', NULL, 1788637998, 939252316, 'huyf2exq0q9', -1906511627);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483216, -289116732, 'muibhpaw3okv', 'f2kw8', -1353921634, 's7e3', NULL, 326597852, 845366630, 'uv2', -1770659422);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483215, 906206613, '18ygd3kcxhm9', 's2qwo9odyu', -274025274, 'qayc5lfr1y6', NULL, -1787380085, 1418952273, 'ah3n4enp', -1918966554);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483214, -818672321, '9a769mgkp8x', 'e', -320711228, 'os', NULL, 1544109179, 2027663996, '93ui4eg7i', 1732396781);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483213, 1659782271, 'kwqfwb', '8', 1320156801, 'cm9', NULL, -1431052969, -906258933, 'f3o8ex2tqi32', -508553811);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483212, -1493520074, 'ag7vy6tgrxf3', 'tffbua8dxbj', -485801073, 'y', NULL, 129047671, -1854330152, 'k', -637821631);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483211, 1998107547, 'eq73', 'fr2n', -307196687, 'rs1ct', NULL, 4857585, -696412012, 'vc', 2031457577);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483210, 1188966630, 'rkhm4', 'oxsy1e', -350279226, 'crb2', NULL, -318374189, 134250688, 'sh19l', 895967357);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483209, 1713496134, '0cut48bz', 'o9j08s', 1407305599, 'l0oh8x6', NULL, 1113709137, -2099843638, 'bcj6l0s8q0', -1869649626);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483208, -94288616, 'dp6qh1fkek', 'iiv2esq', -1384254475, '6b21n', NULL, 268043287, -1518361363, 'p2c', -714149633);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483207, 970685866, 'i', 'upy8x', -1258092706, 'sy6zxo556g', NULL, 1986913830, -37365334, '879c', -873372618);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483206, 1813633157, '557k57dlp6', 'h', 1689665045, 'rd', NULL, 161327770, 1252520832, 'eeocce', 1561010895);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483205, -1385929270, 'zg31l', 'zg', -1452362366, '0', NULL, 1003451004, -969261554, 'cbi55akn5v', -314106139);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483204, -2037348799, 'nqxnfsq2c', 'gpu546cxwd', 1334798480, 'ocuu9', NULL, -1830925917, 1060316703, 'd', -843468898);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483203, 1607749940, 'do', 'zx', -416228404, 'jb', NULL, -1682620334, 741002914, '9', 347884690);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483202, 1268370246, 'gryb3', 'u', 63995629, 'mwykwhh3', NULL, 1849806292, 97150289, 'ts83ji01jh', 1202385254);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483201, 1778412617, '7symss', 'n3', 655368578, 'xcwsy2x1wv', NULL, 2117974368, 1533595163, 'fl9yc', -296001909);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483200, -1963382562, 'qsamrh', '1v0xkp3ts', 498897101, 'ux263h14q', NULL, -1062877709, -673304134, '4', 455755166);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483199, -1939828688, '8i4ihaa', '7q21c6fh7z', 1806480371, 'l5jymr0', NULL, 1357830019, -1410186435, '9n1xcxa', 1875654630);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483198, 1469383279, 'uzzxq', 'd59zer', 504733242, '2vn7bq7q', NULL, 116585882, -387964923, '0izkt1', -1725252983);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483197, -1903583803, 'momcj90h2ut', 'cpxks7o7', 371237345, '1qbupy5bkk8g', NULL, -1905780801, 160535159, '1iihem', -1689737162);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483196, 125879022, 'y5goua4', 'cbnlgo3pkx', -2031087254, 'xo6gew3nc5', NULL, 1607318388, -850055318, '9', 375621815);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483195, -93855160, 'vkrsvm2', 'aocco3wee', 266634557, 'qac1c85', NULL, 404078962, 81198670, '4x41e1jfn', -1989738260);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483194, 350977100, 'bjgb758b7', '61t07qm', 663256408, 'sd2zidvbji', NULL, 1749038653, -1615650469, 'g1s4', 483740795);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483193, -132913720, '1uwp9', 'vz', -458498621, 'aagk', NULL, -1613403973, -862830764, '2q', 109478394);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483192, 1469500587, '1zj3ro0bvg', 'kx0ihc', 1103857511, 'ca0', NULL, 1719977895, 2094032060, '2wwaragdm', -2127844351);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483191, 429942129, 'ar392h8jqg', 'biui17', 2096142213, 'thqbi', NULL, 760671633, 1325256505, 'eozt0bb3f', 1726750711);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483190, 1076006919, 'tnzb1r', '3we3tfv7q8m', -44556247, 'l', NULL, 1281202848, -732031227, 'wo9snswds', 164465418);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483189, -1840922474, '0k1fy99yt', 'kl369why', -749635766, 'y95mth', NULL, 607097414, 1545292634, '38j3kjr', 638726152);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483188, 1496706913, 'i', '6jv', -200876594, 'rod4die4yhy', NULL, -2040559882, -1009938777, '3ac08ixynjr', 1933010147);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483187, 942224711, 'w', 'mjm5u6kfh', 1631857666, 'obpjp', NULL, -591129539, 1953696988, '31bska', 889715685);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483186, 2064531800, 'ptj8c0', 'pyk', -1221763844, 'pbyp6d4i8c', NULL, 2135392657, 1002386729, '7ncw3qt', -1430579634);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483185, 1854927595, 'dwd7tg8k9', 'ejq620ybku', -1933629990, 'c0th', NULL, 1586811351, 1701937881, 'dzk9jvdz7r0w', -752945256);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483184, 756503794, 'ei0qf', '2', -702719174, 'avh0p9hyv5m', NULL, 1867721583, -329859905, '3c', 1663476682);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483183, 433695616, 'ylw0h8eb1gp7', '7hsmmgu8d7fq', -305295016, '6wjo6c', NULL, -1210496481, -1172661845, '8v0qucr3', -1727342238);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483182, -1654830030, 'k5z', '3a0s8r2bmoy', -541184901, 'qqt9dxkf7r', NULL, -1049255076, 1365859920, 'mp2', 1719555881);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483181, 979078213, 'zu1mt', 'ois2', -1813146857, 'e', NULL, 1408118948, 1131448444, 'jmw', 1862928414);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483180, 2111484037, 'bbchzc1wpwr', 'u6ns7g', -1152319213, 'pnimpze', NULL, 625691408, 733062761, 'y', 273195901);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483179, 451600438, 'kv9g8hq', 'ss5zmgtd4', 1387537642, 'mcgm', NULL, -301729998, 47087687, '23mju50llyj', -1415339914);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483178, 256425443, 'swc6liqmi9v2', 'pp435zpukw', 1759206364, 'nkpaduvbhi6w', NULL, 1990443818, 678880956, 'wg7w', 1584203057);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483177, -150356048, 'h86xg', 'vfjcxup', 1691726260, 't', NULL, 1360472591, 938802630, '8', 1358277572);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483176, -1625318110, 'f90tpaeoj8p', 'h1xtzhg', -93771789, '6022u6', NULL, 1952766938, -702826191, 'ejx', 1298973461);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483175, 643789525, 'hp', 'e12x4df8', 1679028416, 'mlm3anlbqo', NULL, 1728334097, 2061517933, '9jsie674oz', -1776221270);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483174, 1104204226, 'dsbbnev2', '1mny68vj8b', -195549861, 'z2e38i4a6', NULL, 680452793, 646754022, 'znf9cscaltgo', 642685547);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483173, -1451584267, '2pgpui2dil6', 'xl4xci3', 901256728, 'ye144i6il8s5', NULL, -62922306, -533484889, 'wv2nfcq', 2118633165);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483172, 1445473115, 'ex', 'l1q2dn1uq', -2147196801, 'xaqjjq', NULL, 967631988, 30781983, '1lna6bj', 548457032);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483171, -1918142443, '0sh3qr5', '2ato5cf5v2t', -1535188192, 'gb', NULL, 1935903200, 821808596, '64d7', 573593583);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483170, 1636203283, 'ncce5hq', 'sh8pf0q', 1815801050, 'ioxa', NULL, 1573000764, -1206478666, 'c', 1531807022);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483169, -822298968, 'e707ufpeo', 'igpe50ro3n8', 1316790417, 'lqwq', NULL, 1417023222, 1167145461, 'wd', 1171006211);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483168, 68344110, '4yc', 'g2n', -386306490, '0nz232ligl4a', NULL, 1562581380, 1552598637, '2e6', 760668165);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483167, 595959467, 'y2w', 's01p57jxsqbr', 31494390, 'vhncg64n4s', NULL, 2143442582, 2097715111, '2dvqdzumr', -1730955214);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483166, -611118613, 'r93cq2crb', 'le3o5dmh7', -1486161942, 'l1x', NULL, 1203328776, -974262311, '0', -1198483167);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483165, -1457209789, 'u0a9bn', 'gtenyk', -170000972, 'scz', NULL, -1917209175, -964654260, 'lyh50', 1273410957);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483164, 1104272761, 'tubs3m', 's02ls', 1583918462, 'p3yhr', NULL, -1957746460, 2142780928, '4fcw8in85', 1051280570);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483163, 1996390451, 'mh8c', 'be3ij5bj', 859578821, '0x945', NULL, 615215009, 523030055, 'jss', 313115811);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483162, 323294843, 'yr6', 'r', 1221807540, 'kyg6deehgrq', NULL, 74615819, 370256629, 'nw7xuyzbxx9h', -1537642464);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483161, 17827384, '27tza45ge', 'z5d3kv6owc7', 777429996, '8t4ya2', NULL, 1993957396, 1695620062, '8dzlbd9tyga', -986962097);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483160, -283450841, '3e8i0pm', 'g8j8', 1302618921, 'cbfloou', NULL, 1047704893, -740528382, 'qwbaz', 412523898);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483159, 851238762, '4gqe93rjqu3', 'z88', 890879173, '5a5zc7', NULL, -1628631803, 1015397701, '6oe2sn54x', 1876787913);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483158, -1666328950, 'h6vil7e', 'mfy8vnr7', -1255812634, 'c9', NULL, 1299980854, -707815643, 'erogk1xx', 2008599184);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483157, 508934749, 'h4l5w553a', 'ov6j', -70579516, 'k7zxwe', NULL, -629887250, -1427485123, 'pkvaszg6lh1d', 1380184998);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483156, 372486354, '1w5b4glb', 'js0of7zrt', 1307762476, 'jotf8', NULL, 973528301, -240651021, 'ok6hdqp61n', -1523123940);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483155, 1855058401, 'd94108ya9', '7y0998sh9hnc', 181569645, '7moaq2ujmyec', NULL, -1764915293, -1589634056, 'r4k', 1791639337);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483154, -96547070, '1g', '9f', 124148958, 'ux0st', NULL, 389156694, 2043797354, 'ysrbtzv89', 1970483936);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483153, -33109983, '0u6f', '6gu', 1049956393, 'y', NULL, 1426185647, -1462630987, 'spunusdalba', -1284425281);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483152, -1027550083, '4n6pv6', 'y', 820086373, 'fp3r1j', NULL, 2001383317, -1458898058, 'l3', -626159165);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483151, 1465965708, 'uno2mx9', '6s69x', -1930441282, 'xiihv0', NULL, 1606683792, -1082587215, 'c2j0fju', 204533464);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483150, -448725950, 'rlo', 'hss', 1833301674, 'i8eq4e1xmweh', NULL, 797793528, -237753613, 'w', -1497507203);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483149, 2007160374, '2s', '28lk0uqi7l', -1368989250, 'xzttd5', NULL, 1570931729, -10966045, 'j', -107135487);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483148, 1507488475, 'p3k067pnl', 's6r2n2pvkuo', 379949816, 'hk7jf3tztvpf', NULL, 1606443405, -360465624, 'p81u5', 1162876775);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483147, -2110730643, '3k12b8r', 'hseeo9st', 1476739121, '0p2ewl16', NULL, -1572293776, -821897909, 'wml4n1y', 1565538503);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483146, -1092381700, 'apgnsdr', 'bg4dy', 2134881245, '22xldyvqzixl', NULL, 684361106, -1985113074, 'j2l44y7syfa', 470099759);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483145, 1405750874, '5ksa0smciuv', 'm3b8uxuy41', -1774853038, '592it0ecwj9o', NULL, 205296146, -812322943, '9i2vj9b', -1734324001);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483144, -1929268936, 'je', 'daal', 148376893, 'l0gc9', NULL, -840201372, 707645713, 'zz', 366622932);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483143, -1654498482, 'dyt', 'baa3okf', 2121551261, 'qw6yxjfvdu8f', NULL, 778366230, -1126423008, 'i0nhopb8jl9k', 974962229);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483142, -1136345837, 'b9', 'b1ujev9', 824064422, 'u0gnq7faqubb', NULL, -173060048, -772068622, 'c', 36649650);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483141, -2094588576, '3h3063mavy6', 'u32pj', 74732314, 'm4yd', NULL, 46573703, 227631902, '4wl2bk', 1586135039);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483140, -747963641, 'qhl66wos', '9', -296476304, 'l53z', 'tri_361e50', -1296472412, -1370135979, 'egew6uetts', -995397538);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483139, 1658788778, '961v6', 'r30ve46pcgkj', 13560857, 'kw5pfjgzf', 'tri_361e50', -1897517047, 536454778, 'a325qigvd529', 2091586986);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483138, -1589836255, 'klcna1', '955qq8rq', 726547398, '68u5l', 'tri_361e50', -1884714782, 694044247, 'wce5sv', -1385538082);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483137, -1365494108, 'o1azlacylc', 'cz3ye3t', 1488990174, 'na9bvka5zs', 'tri_361e50', 1976126440, -1535695509, 'tjo35c', -1477539076);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483136, -1393133512, 'yk', 'n', 1635041429, '0ahc0pbr', 'tri_361e50', -1194976242, -1086858479, '519iy1qgc2p5', 63913440);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483135, 1357642758, 'ookb4a8s', '0u', -1123524263, 'uzwsicw', 'tri_361e50', -1418543991, -916791833, 'e', -2057106556);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483134, -1613517309, 'p50p', 't8jn1z2bvo', 1665733087, 'h', 'tri_361e50', 543032261, 1242432048, 'i3q2cbynbha', -366237412);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483133, -436836750, 'v8k7', 'fj52jely', 1288974804, 'js7fkw', 'tri_361e50', -1159407096, 77208431, 'goenblb', 1973414324);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483132, -859808188, 'n', 'wohmvqi', 1801331249, '4z6e5g5h', 'tri_361e50', 2080604883, -362395437, 'vr4mlb', -450601708);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483131, 1860495416, 'zi2y', '1lhlo', -123272429, 'ab1x', 'tri_361e50', 1460073318, -961428176, 'pehbvgpopo', -1062425896);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483130, 1640707577, 'jb', '01l5sabf5', -35210264, 'ns9', 'tri_361e50', -1784445553, 864063042, 'ehtt3r2', -229899237);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483129, -1952281157, '1ef8t9va3pe3', 'uk5i', -1989358988, 'fbfs9v', 'tri_361e50', 1150018891, -2137563687, 'z9j4', -92623718);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483128, -1253877307, 'xq77nibh', 'n', 1477037827, 'xf', 'tri_361e50', 1536216338, 417639984, 'mdhnszwif', 755536831);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483127, -241283937, 'fvx12cegk9f', '2', -1137542173, 'f61o', 'tri_361e50', -836131850, 1201211441, 'l6xp3rig', 334947749);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483126, -900107957, '1vt', '0z7zhi', -576111648, 'rkpi8', 'tri_361e50', 873004336, -1465878149, 'lf2ey7m', -157376442);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483125, 1467182989, '4o2', 'sg4mci', 945137887, '6cmwfgd7', 'tri_361e50', -581057354, -1917424651, '5', -398718939);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483124, -1229501751, 'qfjm6j8rwp', 'pvv', -1234483634, 'wikzwye97152', 'tri_361e50', -1852336950, -1279249329, 'aagzu028b', 732017306);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483123, -2015204829, '8v', '9agl498zunlm', 1967018175, '5cbi6azs47', 'tri_361e50', 648596845, -274582175, 'v5057f9t', 232140033);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483122, 1900053126, 'jozxo2en6c6', 'jzyjpq', 1699746015, 'udfn', 'tri_361e50', 907269791, -269074773, 'lb', -700256849);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483121, 438750961, '5zho1e', 'dkdd88tpxi', -501033816, 'r6', 'tri_361e50', -708758663, 1381491825, '4qxg', 1787242830);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483120, -1307049795, 'vwmzju2', 'ar', -1506260566, 'v0', 'tri_361e50', -1867500965, -945668245, 'kcdcdo', -876641202);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483119, 1187662098, 't77', 'kgv7qls3fg', -997838283, 'h8', 'tri_361e50', 1219176356, 676805040, '5', -603627201);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483118, -2137923847, 'f33', '4e', 91050729, 'uuwpvhda5wlv', 'tri_361e50', -385274007, 488800752, '8qv0dfmlfa23', -1816862865);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483117, -823520909, 'o', '7', -402431404, 'vxo5e2', 'tri_361e50', 1483702805, 2068785469, 'silh', -1321172625);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483116, 622913967, 'ygeo7u', 'lt6g8b90cgu', -1895058205, 'pnbbxs1cioq4', 'tri_361e50', 1227662211, 398901123, '8g', -240682043);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483115, 1705765660, 'a', 'qe7pd8', -1070183045, 'e9', 'tri_361e50', 482463919, -896914317, '1u6emwedx', 916089477);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483114, -1267347554, '8muahms', 'v', -778917705, 'yj', 'tri_361e50', -1160289665, -428937041, '8q0n80hb', -1074803901);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483113, 1261780215, 'flkqftxh3nz', 'azts6yr', 138795676, 'slozm', 'tri_361e50', -1757862479, 1380477696, '3pt9o1z', 1213683888);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483112, 1636372649, '48y3gag1b', 'dv0g', -1890250082, 'z4g6k', 'tri_361e50', -599973649, -629589592, '9ehwe8f', -925170260);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483111, -616556661, '7mmco52hv102', '5rqxr57', 113389050, '28hkfsia', 'tri_361e50', -823421080, 1742296160, 'gwf2h6w584oi', -223027658);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483110, -1533694550, 'gebf3xyuf', 'u5fb7k5ahzx0', 953492702, 'tma58e326', 'tri_361e50', 1054044314, -1564361766, 'c', 1410611793);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483109, 316535477, 'w52v', '2liue', 1884103318, 'zmt', 'tri_361e50', -1517057179, -1165931914, 'j0hd7', -1306619877);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483108, 1478896065, 'xen', 'ahy73v8d7fe', -2093184523, 'pf5ra', 'tri_361e50', 1319754423, -1843929735, '2htwp1nnce', -1853747584);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483107, -1753211370, '14tl', 'qg98s', 1742892734, 'c809', 'tri_361e50', -2086252882, -2015859148, 'ndya435k6jip', -1998976547);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483106, 377358807, 'jqf19fk0', 'gjkbvxpd', 282042409, '8w8pe00g79dz', 'tri_361e50', -1169137673, 355223282, 'px6xczx', 1698664246);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483105, 158946959, '9vnhe4qj', '0a', 768641893, 'bu1zm9yzyqyk', 'tri_361e50', 28992886, 1808654928, 'r91g', -1267141529);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483104, -1185715971, 'lfwc539fxz', 'po0myvd4et6', 9716147, 'igfzmw0c', 'tri_361e50', -1221593880, 1419825140, 'rodok2ov2', -1865851350);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483103, -1791692160, 'u5o8ae3w2cq', '0a', 1020742685, '9zsw', 'tri_361e50', -823329107, 1625126041, '4ssx64uy', 1757142620);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483102, -2123768860, '9nmsjq6', 'rfy3id3z6hh', 1246563275, 't7cm', 'tri_361e50', 2017683003, -191655752, 'dxratthq9', -399570481);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483101, 1209238294, 'tn2f6', 'yn0tgwq', 345127596, 'mk043qr57', 'tri_361e50', 27897311, 310922237, 'fi0upydy', -971678016);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483100, 407118404, '76gy9p', 'qdrh9049m615', -1666884824, 'sdeed4e3', 'tri_361e50', 884936303, -1464646802, '5f3', 1952559407);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483099, 1128247945, '6l2rjli', 'mdswtv4e1jh', 142789209, 'ole9', 'tri_361e50', 46930363, -306380865, 'l3ngx4cr4vp', -2036113432);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483098, 1439923271, 'en8o', 'npdes9t', -237105901, 'rcdz', 'tri_361e50', 486411378, 367441360, 'aprbtxoem', 1223268254);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483097, -114478205, '7jzj3hj61j', 'kqtj164fx', 1094598888, '7x7', 'tri_361e50', 2140056662, -1178959624, 'f04i', -1331296752);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483096, 2077047483, 't6qj6jk55s3k', 'r8m4mokv6', -73608047, '3s', 'tri_361e50', 853128551, 1161434634, '1ygo2x4s', 1622545122);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483095, 1930638528, 'i80knjz2', 'rdg3', -1679484409, 'q0hiwwtl', 'tri_361e50', 1097957595, 1121199234, 'vyz5fpvkbw', -2071887101);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483094, -1060994621, 'npjqi7sqvd', 'dnbd09q1d', 687552601, '2awdphti', 'tri_361e50', 31968938, 1023749886, 'q9t6bc33', 182437661);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483093, 471024823, 'hn8fh9', 'tsf4', 1258164532, '6p9blz', 'tri_361e50', 1706337730, -1684967975, 'c9m', -774816715);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483092, 1417621442, 'we308retxnur', 'f5uh7', -1039613831, 'b3ub5xjda0', 'tri_361e50', 1615897464, -426558908, 'cc', 804806140);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483091, -363134039, 'z1y', 'ohsqnytmb', 267743675, '31ed8di5mmx', 'tri_361e50', -1085917936, 1898541836, '9vo2dafr2k', -857043977);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483090, -144900844, '27d7x9x', '4dcd', 2004102428, 'j', 'tri_361e50', 195637014, -317460560, 'xvs', -1134769122);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483089, -1380189880, '3mnj1ju', 'tsjbsco', -1687409617, 'n', 'tri_361e50', -143913267, -1073675772, 'kuqgn5iojw', -469546121);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483088, -1989113201, 'e', 'a8xaw6', 1002810581, 's9inakrx', 'tri_361e50', 461390428, -752872790, 'srbz9rw85ta', -166611456);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483087, -10481040, 'hx41vbxp', '28', 9646804, 'e20', 'tri_361e50', -524455210, 1648750491, '8eommyaxtof', -392965231);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483086, 395434239, 'zk05elxva', '2kcwhd', -1543143836, 'wt256t', 'tri_361e50', 590241152, 714317238, 's0gguzf41f1b', 90636644);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483085, -1374615517, 'i', 'lfng', -581838623, 'yancsk4q5dju', 'tri_361e50', 1573531195, 781170580, '20xeiwcmabon', 2109176069);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483084, -120923840, '1gmzwf272v', 'wfkctuqni6ei', 61038446, 'vtfg', 'tri_361e50', 2066097829, 1486118303, 'ztxltagxl0n', 2089769557);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483083, 2138607545, 'h', 'tzm', 1167957759, 'spkuzhb', 'tri_361e50', -2110165182, 12616735, '2y99wf7u9ue', -1429739819);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483082, -1403801263, 'j4', 'g', 1176921793, '6ju9i33t9tqq', 'tri_361e50', -1530538806, 767857365, 's6', -398615520);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483081, -145254093, '4nfnm1lgmq', 'cf', 1826333728, '3aj1', 'tri_361e50', 1707883761, 1614717895, '9q58xnn4', -1411118283);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483080, -1126751553, 'mu2', 'plhi', 962165369, '5', 'tri_361e50', 446481736, 2139330651, 'h7dykvhn043', 572092318);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483079, 1868010636, '52x85', '6pit531zn3m', -145985166, '0', 'tri_361e50', 952297160, 1280990263, 'kpfejp8xy', -1909130590);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483078, -996520761, '37', '8ryy', -2146584814, 'ikva0ni8wvgc', 'tri_361e50', -273466792, 143776378, '0gyrgmqq0', 643706137);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483077, 1870154608, 'zu48gcs', 'rxwn', 315718234, 'iq3l156', 'tri_361e50', -837010414, 660300879, 'icauolz1z', -593208502);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483076, -181945327, 'yg9', '67', -374544071, 't0vz1', 'tri_361e50', -490490593, 1366931987, 'l3c58c46fkx', -107227386);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483075, 788187141, 'c2et4bjfez', 'hjyy', -561525304, 'i', 'tri_361e50', 147883846, 1128094538, 'pxr4ekg7r6', -228241667);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483074, 1023785870, 'xykfs', '9uj84kudrtzd', 1568076211, 'go82g79e28dv', 'tri_361e50', 788062682, -1603081466, 'd5v46otezoz', 856126064);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483073, -1014348494, 't5bjwv9fsf1p', '59ao8rl', 1883330840, '439p1yz1x4d', 'tri_361e50', -1395005660, -1382860944, 'b0otrjfzpx5y', 1330073464);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483072, 1876064150, '3bokto68xpt', 'pxjl5trymaa8', -819669735, 'ozjddl9x3q0', 'tri_361e50', -1791268719, 244676163, 's', 230274533);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483071, 1097560539, 'dkc7', 'b', -824526216, 'wg99v3z', 'tri_361e50', 1579888734, 1256582642, 'nia', -1384543399);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483070, 228280722, 'fxlyl2', 'd0ysa775m', 415333454, 'pc56o1m33w', 'tri_361e50', 295169308, 2114013230, 'i0qj037p', -1691484659);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483069, -1437316777, '9st', '12pfxvthxylx', -726883264, 'wf4', 'tri_361e50', -184481533, -1319661879, '6lqbx5hu', 902566130);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483068, -1859482461, 'c18', '13zp2', -486881545, 'boea', 'tri_361e50', -1379664840, -1314312142, 'l84s886', 2031656672);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483067, 338610543, 'bgce5', 'iraxs', -440576911, 'fqxzqi', 'tri_361e50', 735559119, 1284169401, 'om8unp4o', 919215018);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483066, 376486240, 'x9dc1qrq', '1m', 276398194, 'ud95tm93y4', 'tri_361e50', -931589426, 1504985455, 'thxv', -1159643317);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483065, 1957589507, '2ji4d', 'v', 741211476, 'j', 'tri_361e50', 813127595, -1116955183, '7wmzary57', 667438147);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483064, 904105297, 'oxmbcod0n', 'orp', -2124600036, '9zrelmpp', 'tri_361e50', -2144101962, 1774231482, 'e4', 407573259);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483063, 1117929299, 'h5p7vg5', 'mt35f96f27n', 1834371875, '7ce1uc7plbd', 'tri_361e50', 2115594395, 1796439769, 'd5tf3bpm9i', 1753758028);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483062, 485914263, 'ifhzr', 'dljo9l1k', -318116721, 'yku', 'tri_361e50', 1048454411, -533404559, 'vlhqxtps', -1338810125);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483061, -351985668, 'lgug0rl9gz1m', 'ph8594y', -381267081, 'cro9gtkvj', 'tri_361e50', 1893362153, -1652955793, 'wxwi', 1669167122);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483060, 1055196048, 'g0xdirkz4rb9', '2ejd14338', 474562256, 'xt1br9oqksc', 'tri_361e50', 1334953453, -993046959, '67gpsgl5g', 838766003);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483059, -907187999, '9x1v5wtdvl', 'g26', 3398659, '759z', 'tri_361e50', -1567483540, 564752574, 'opdii15', 1650060614);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483058, 1228235911, 'lgc', 'a87q818wt68c', -490476664, 'b8c4p', 'tri_361e50', -1618332858, 782048117, 'h7g', -753184876);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483057, -99979185, '20bad', 'jman8', 1877692606, 'nke5rknb3qz', 'tri_361e50', -736048637, 1181394411, 'bs0n4yop67qr', 418186425);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483056, -662804560, 'b04t68', 'dy71cntt', 2099813493, 'y99pfl2', 'tri_361e50', 1957308327, 983378091, '3ld533', -512290898);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483055, -1738298622, 'ngvk', '8myss8uuk', -972363425, '5wz58', 'tri_361e50', 2088619478, -266378663, '85pwqf8r', 884684615);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483054, -779648091, 'yerad6ze7', 'ys', 442697583, 'tbs2g9tkh', 'tri_361e50', 1611911811, 366452997, 'tygk8843', -799269413);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483053, -1956907344, 'gari2uh5rz6y', 'ly6zh59ee', 35948462, '04', 'tri_361e50', -1853723775, -952435841, 'bmu34', 1780970246);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483052, -1383365119, 'e', 'd', 1388397956, 'dg5mhc5ksq', 'tri_361e50', 1863398624, 328692324, 'ue1af', -1245680999);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483051, -359002601, '9z', 'jy', 1944027293, 'f7o4xmqgbmxj', 'tri_361e50', -271266658, -809447639, 'vn21dvm', 1746844756);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483050, 975891238, 'fclzpw', 'gs6x13r3j', -1958612183, '1', 'tri_361e50', 1949892706, -999926120, 'qn2omqq', -1036153761);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483049, -1464454961, '8o5duoves', '57tcft0qm', 2144302350, 'ui2ldd8s2', 'tri_361e50', -1117374296, -1272954843, 'bo', -2005366757);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483048, -1351950641, '7h924', '3', -627614011, 'ybcwf1urkd', 'tri_361e50', -1916912863, 971247282, 'j', -446511134);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483047, -452867887, '8', 'zsq2nf', -968850320, 'pxs07h', 'tri_361e50', 52392315, 584924519, '5kopwc7oxqd', -1171586984);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483046, 956077352, 'l8ryv9g4jva', '6ud', 1516102643, '7', 'tri_361e50', 228034665, 900452906, 'a', -586286868);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483045, 1296588192, 'huvvtmbrrdwq', 'gj4', 106435046, '8', 'tri_361e50', 1778484286, 1373914791, 'b9yeb0t9lp', -1840513401);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483044, -1286129560, 'bgdg8qhen5z', 'lrv', -371280187, 'xos4gcqxmd', 'tri_361e50', 1236183438, 475803462, 'vq', -1258615699);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483043, -895095520, 'd', '1vbv7', -1541343992, 'dh257m8a', 'tri_361e50', 478573161, 1797914611, 'p8qjw0gz2k', -1221940242);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483042, -1859595112, 'zrbttqqgsj', 'ojdxk6d88', 602443784, 'jk', 'tri_361e50', -2059010707, -1155933714, '3an', 1381094153);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483041, 1726389139, '352', '0huc2o', 1506202551, 'hu', 'tri_361e50', 1473034292, -1100053176, 'qw5814', 797103125);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483040, 1322376591, 'afcdnvz5yh', 'b5k9qazzx', -733266011, 'mr5ueu01hq', 'tri_361e50', -1177010250, 184123336, 'szzth3', 1338127170);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483039, -816683614, 'n9qud1hag', 'cz', 43350550, 'vfqc3xfiu', 'tri_361e50', 908844196, -503906061, 'cl4lqg2td8', 1926384384);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483038, -1831347124, 'vdgah4fnkqx', '4', 742946635, 'fe', 'tri_361e50', -114442371, -613068427, 'huu0', 184375733);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483037, -1656217216, 'f9wut', 'pu0gfjzl4ytr', -1822376828, 'cdeuzth8d9', 'tri_361e50', -91349974, -1680684858, '7viqcg5d', -665119330);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483036, 1069405944, '5', '4', -1195945332, 'eefo9iero', 'tri_361e50', 758785075, 1739992818, 'd5bzvjn', -582652247);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483035, 1180448669, 'r9cfeygfj989', 'a3kjrl9', 1278856849, 'oa', 'tri_361e50', 1189709342, 1650068598, 'p15', 907472872);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483034, -834250613, 'ie4ftmumf3', 'v9', 1640575639, 'jhvael3', 'tri_361e50', 1842478245, 126777520, 'sstxritfa6', -1324280501);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483033, -1251962685, 'fic', 'lvu', -1521120423, '1galbyd71l', 'tri_361e50', -575827037, -442642866, 'h2m', 1139554087);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483032, -1220201725, 'i6k', 'ux', -791358594, 'l9fqr64lc', 'tri_361e50', -294168126, 1984892020, 'm0bjb0bxg5a', -1957091423);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483031, 1381110537, 'b7qcju', 'omirkqt5lgef', -487061607, 'jazcb6r8j', 'tri_361e50', -687478504, 887094895, 'xq502wx9', 938164537);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483030, 115654348, 'onncyx', '5hgvrzgd', -476281784, 'oc3b5', 'tri_361e50', 967129837, 416690943, '0c9u5i479r', -844378355);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483029, 1572879951, 'sk6kjf', 'qs', -1336894824, '64vm3', 'tri_361e50', -722374383, 537034766, '0nh1dd', -854248692);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483028, 202033262, '14pkaux', '0auc', 945274482, '3hfqstb6rmtb', 'tri_361e50', 363237098, 764167757, 'lydaj5', 956976163);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483027, -1190920610, 'he8bpx3f', 'qq', -2141546884, '9ze164k8p', 'tri_361e50', -1534811071, 436674742, 'bl2v0', -1783956145);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483026, -637727884, 'd9eom5wiejrr', 'bce5eif', -1906807302, 'ahaf6e4', 'tri_361e50', -878858757, 428033456, 'f33o', -1547906756);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483025, 295908492, 'n57li9', 'lb7c', 456640705, '793mtnkxi6z', 'tri_361e50', -2123363065, 1772897470, 'w360jnd', -1666178579);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483024, -35322962, 'yz', 'k3', 2133804215, 'uq0643c0ffr7', 'tri_361e50', 2032782189, -140908493, '3bz8gdiro', 937685213);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483023, -224394787, 'io06y2rfwf1q', 'jzc99', -1973150851, 'rxrfxt', 'tri_361e50', -360869160, -1586214232, 'decipzk', 1257497646);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483022, -1014850437, 'a4qs0q2sc', 'b4e2', -830278861, '4', 'tri_361e50', -2000611746, -2026386421, 'roxncee', -1725775097);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483021, -2081254350, 's1zpirgxbe8g', 'rwdh5w56p233', -1774001143, '78eslvldah', 'tri_361e50', 55404178, 617161419, 'oo2pgeeaoq91', 799268909);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483020, 2076411844, 'e0344', 'er', 1100761100, 'c0xpqsy', 'tri_361e50', 319144566, -1428903440, 's6k8s6', -893295429);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483019, -461956635, '4fkhrfm5', 'qd0', 67225343, 'pw78qvy9p', 'tri_361e50', -590778986, -1462393002, 'dvk75katk', -748121628);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483018, 375468714, '3n0e8h5vs2c', '31ew821hbu', 1752508681, 'x', 'tri_361e50', -1146364026, -63380677, '65g4', -1561478107);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483017, -1737026777, 'ypaq37tr', '8', -1992996795, '9kohihf2', 'tri_361e50', 1484796954, 2141104917, '7', -493118301);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483016, -240847730, 'qlwcpvkdta', 'ci', -1383147633, 'qr6fuo6', 'tri_361e50', 1569100915, 828662991, '6xc53ubgaj9', -2028802811);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483015, 987305111, 'pnap8026gjv', 'm62uax8s', -1350867633, '85h5', 'tri_361e50', -679998101, 118689872, 'i2t401', -1912126913);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483014, 245218432, '0di7zxv4j1wp', 'wovs0erb', -1900050049, 'piw', 'tri_361e50', 2057295408, -1743906498, 'xr85epz8to5', 1743470000);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483013, 1549915852, '2', 'vnrr', -456029376, 'r8f02p0bvb', 'tri_361e50', 811730244, 239283355, 'z6mci', 1418570116);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483012, 2056327724, 'u42f', 'd4hi', 1873024797, 'y0p', 'tri_361e50', 673422772, 344978805, 'bk1cf2q', 1031208630);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483011, -503049268, 'rmgg', '0blil32hnvrt', 2110372740, 'dby', 'tri_361e50', 1268154470, -2076374867, '99p', -685901713);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483010, -815399322, '9rgn27bvxe4', '54h4y', 222785688, '3kl1qjd', 'tri_361e50', 616331904, 103890273, '1dm1m', 1661356800);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483009, 792891618, 'rfm6i', '8x30heb1', -1122809780, 'mtwt', 'tri_361e50', -428887511, 1906860929, 'ffaasypkk4w', 948361454);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483008, -1887576609, 'zz0us27cplf', '0jo6qwu3srd', -1816798314, 'bjlc', 'tri_361e50', 1926417447, 439823852, '0s6', -1645470413);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483007, 987757714, 'm', '3f8wik6elhm2', 1099374219, 'ece4', 'tri_361e50', -664614204, 107160281, '3jeisw3', 764944199);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483006, -1359765555, 'a4m6ao09wz', 'q4u0nk4flsf', -1715794487, 'n', 'tri_361e50', -929401307, -486321906, 't55dk555p', 873159274);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483005, -616853845, 'gdas', '8crx9', -307076811, 's3vl72fp', 'tri_361e50', -967018822, -2138137817, 'uuaij6', -120683112);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483004, -676130543, '55fm1mzr3', 'cfni0kz2l', 88971573, 'y8biuxlpv', 'tri_361e50', 855421508, -358250019, 'i6', 591962270);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483003, 1058759754, 'h', 'j', 1371631737, 'j6u', 'tri_361e50', -1438324356, -699093679, '61jcr1u', 1533227721);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483002, 59915628, 'c1qfhfir8', 'n3aoti0r5m', 965621850, '3q4781j4c0', 'tri_361e50', 1855176689, 1798154807, '5hrn53q88', 1970173909);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483001, -1857066680, 'f8f5wsjck', '5', -337818871, '49wyph6', 'tri_361e50', -1565178933, 501705161, 'qrhtd4wtlkxg', 1456026741);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483000, 1089184061, 'c26g5', 'tn', 1107797847, 'zqge', 'tri_361e50', -915364332, 553210561, '8g2ui', -866056603);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482999, 1435768501, 'nva42gpot', 'x1zl3c92yj6', -937809599, '9k4yb5', 'tri_361e50', -819457951, 1177554908, '487zm', 1408542422);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482998, 220235506, '6jyjvev34', 'u44zs1q', -1135043636, 'r0ppc93k', 'tri_361e50', 1491133076, 951729736, 'nkoqjf', 1610402120);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482997, -555935136, 'ni1exiq4c', '0racoybfz', -1825111214, 'a1783s52', 'tri_361e50', 429041612, -1121090257, 'wd', -1780180915);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482996, -146799627, '1hnc', '7umnu', 535677496, 'rupudsck', 'tri_361e50', 773590085, 1366425050, '5asm2lxs', -226937308);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482995, 251060981, 'wsmeauxd5', '80w4uo4', 174122995, 'r4n1so3xxkm', 'tri_361e50', 1233779052, 1724226169, '5', -1676494167);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482994, 2039558793, 'wovw', 'cb6kyzrn2h1', 769217076, '6qjkd51odf9', 'tri_361e50', -203972162, 1279523015, 'zf9psmn', -1090581636);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482993, 1560718684, '2', 'x', -1882189918, 'v', 'tri_361e50', 1529014144, -1239163293, '385hd447m', 504143473);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482992, -500884979, 'guam6', 'd77mveeykxim', 265506178, '1xxgtvr4', 'tri_361e50', 9902029, 647224211, 'm5vsh4r4j3', 1151109430);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482991, 1339463420, 'vibvvta4d', 'r7l5898v', -1473701381, 'cjd6', 'tri_361e50', 2016015428, 1173713470, '3e', -840425179);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482990, -1678211019, '1miyx55', 'bahb', -2093809729, 'ftv28v', 'tri_361e50', -950264181, 251920396, 'rj9bvuo6', -154230235);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482989, -1304519731, 'x', 'dwckp9fh', 254272642, 'bscy6', 'tri_361e50', -1922002424, 2013612843, '7duzv', 564814508);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482988, 150793897, 'i', 'o7ct3llx0', 1481312890, 'yypf5fcd0v6r', 'tri_361e50', -1516680334, 1069169667, 'ifwm1xz2pd9', 1007808807);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482987, 2013019605, 'fgycbq', 'm3xcwd', -537891612, 'sho', 'tri_361e50', -541476101, 133183465, 'uyga17z', 527851476);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482986, -2095888130, 'bwiocx01z3h', 'srx0d7tg2eo', 1336767355, 'th4mqdbpr', 'tri_361e50', 994427107, -1594067812, 'ryl458njv', -334951903);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482985, -1030352465, 'c9xsv8wjy6uq', 'zwwmp', 283677137, 'n08sywy70i', 'tri_361e50', 838240246, -744000613, 'c71dy2lu4nr', -1891812570);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482984, -876072362, '8y0enl', 'zm', -1732936058, 'b3jp8c', 'tri_361e50', -1936163509, -1727842852, 'gf8i', 530954377);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482983, 1381855297, '1hmg', '1tz', 13750788, '1cic', 'tri_361e50', 54791180, 85482357, 'mw5ad', -1512483030);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482982, -654478109, 'uj', '96nl2an490', -868482153, 'g0v6zxair', 'tri_361e50', 456300777, -1190225102, '8ae6', 1684101024);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482981, 1834613202, 'cjv6koy1z', 'bhhv3', 1290946577, '348a7', 'tri_361e50', -535298991, -1602030908, 'tmo', -921576281);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482980, 1094505859, 'ryr', 'ywt', 1650742957, 'posfotv4pl', 'tri_361e50', -899345752, -1763579712, 'zq45zb3bcu9v', -898431019);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482979, -566819710, 'z4ymy', 'tpkk70w', -864210107, 'qg83tvs', 'tri_361e50', -1545876166, -572078907, 'ghtcfk', -992195360);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482978, -1769974705, 'yelmer', 'k10e3jb0chh', 514593505, 'sxugo3c', 'tri_361e50', -1093364246, 1376330232, 'tpxr13ae', -198316170);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482977, -695952750, '9', '92b4fylcugh', 2054561152, 'zkxs', 'tri_361e50', -192283104, -1621505047, 'jxckzhpj17', 730182331);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482976, -951329069, '8xb17g4ag8q', 'rlj0', 1111378914, 'uiy44k32o4', 'tri_361e50', 759140088, 1466112895, 's4gfa07853h', -1224737855);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482975, -1848797105, 'm7jiz', '3mj8cs931j', 1873765032, 'jubwh', 'tri_361e50', -1572794560, 2069729503, 'r', 976978318);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482974, 1904604927, 'k', 'gtdj', -1664623376, '4mik0opp', 'tri_361e50', 843827270, -1778778762, 'axfmw', 1323680976);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482973, 84440708, 'ywdkadfx8c', 'xywg4z5i', 560847824, 'nzvttz', 'tri_361e50', -685092617, 355717197, 'ftgrr9on2uqx', 1350550226);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482972, 1354092839, '0aiaa2d9q', '9ul2t8a0mus', 473592191, '6ymo2nz', 'tri_361e50', -1542951917, 356666148, 'rb', 1499911903);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482971, 657844164, 'm8v', 'tytp6cg4u7x', 1293158604, 'kfj', 'tri_361e50', -1872823397, -1682862469, '7dx289', 1112817434);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482970, -1616576511, 'z8yackemva', '5qaje', -157930187, 't6onz', 'tri_361e50', 1190203333, 1380229243, 'ydgcy4', 1475470365);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482969, 1577664539, 'x7jc6c1', '0s4ffg4ml2', 371743197, 'v', 'tri_361e50', 1303876870, 1764834627, 'sn7mdyau', -26931998);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482968, -1931154680, '126', 'dldv04x5nzr', -1683782886, 'y5', 'tri_361e50', -397285788, 86932932, '1ij7ar0ng70', 238986362);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482967, -2046095684, 'q3k', '2kzlyg', -377259959, '2xa3fgv1ji4', 'tri_361e50', 1188184224, 1567523366, 'i4tyueqj9t', -751080699);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482966, 1530707746, 'wk930nf', 'awcnoarjh79', -1591993682, 'ey8295', 'tri_361e50', -363892591, -1178469192, 'wx6veam', -1562514398);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482965, 351938512, 'wmwb', 'w2', 1967917813, '9zuyx8zj', 'tri_361e50', -815997931, 1503916224, '6c', 1961839882);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482964, -714115529, '8nm1', 'y', 407770590, 'thsk1czgb', 'tri_361e50', 2006415459, 1462712344, 'g1g9fqb7rv', 1918109964);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482963, 1073721924, '64h3k56qi5', 'k1se3a', -366822733, '5sms9wotqp', 'tri_361e50', -1809814173, 1142767379, '305wtf2snoiu', -1440921523);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482962, 1739944509, '6nvvn8e7s1', 'szkd', 1699888722, 'l7ljtfwybysh', 'tri_361e50', 783729282, -893984805, 'qbv', 846103799);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482961, 352187429, 'i8xie', 'vaen', -1869416508, 'rgv5qckbme5l', 'tri_361e50', 2002546552, -1015705669, 'wwrjcun47twr', -1363015606);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482960, 1632379938, '6xoiy', 'eqatzky6he', -1794080371, 'dtmf', 'tri_361e50', -778362250, 1984203892, 'v3nn', -1504516865);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482959, -57863900, 'r9', 'uy0oks', 1701301715, 's9obbmg', 'tri_361e50', -1317499221, -922020143, 'l0zq6794nch1', -1949873507);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482958, -1950863340, 't', 'hamw8', -1912341430, '5kxn8bs', 'tri_361e50', -80573557, 1670549252, 'n298pr', 1616858336);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482957, -1718719300, 'va6wf', 'tzsjzzq', -2052717377, 'i2v0', 'tri_361e50', 90793009, 918179952, 'lrpi36jjw', -494401630);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482956, -1307617268, '8z46f7iugo', '0', -1913000979, 'i8snvh9n', 'tri_361e50', -584543486, 1332626931, '2rc6dq8', 776831149);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482955, -82834804, '8x', 'm1xxyx', 2081028151, 'hweodabx', 'tri_361e50', -1043776806, 1186756072, '3p', 1469534537);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482954, 1648588115, 'xtb1', 'e', -687284341, 'bgsrk', 'tri_361e50', -1780684421, -994628985, 'oftyjkv8r6', 505763175);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482953, 786031529, 'mmtttffqv46r', 'khf7t', -755863424, 'aqc2vfb', 'tri_361e50', -1325597234, -1843791082, 'ad', 1201628782);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482952, 35741938, 'zivcick', 'lz4g95hrprmf', 1547385157, 'a6bjy6u0ge', 'tri_361e50', -760693859, 1117205142, 'b13d6wo', -1421019948);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482951, 1623206852, '82zrji9hb9jj', 'i1ehvk4gik', 439404567, 'zh0oz', 'tri_361e50', 173207378, 525258076, 'fh', -1652889059);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482950, 546222991, 'wjunnsk4z', 'ass8hffee', -1379883938, 'ugmuqan', 'tri_361e50', -1654731520, -535997112, '1wck', 128245633);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482949, 797205361, 'gepqnzl1w', '77y10', -1723629585, 'qg0sq9a0s', 'tri_361e50', 1522623219, 293986582, 'ql8', -1710731581);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482948, -62759606, 'pgep', 'mknr7', -303277420, 's2q', 'tri_361e50', 98566693, -1646149406, '601bfrqdz9o', -126198623);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482947, 989673172, 'hwr', '3a', -867749277, '4v9yg8', 'tri_361e50', 910542107, -919913335, 'h', -2138617384);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482946, -1878791910, 'eu7fg', '1a390khzmf', 2024819932, '270', 'tri_361e50', -1090036100, -313909104, '3gzo3wbuim', 207060113);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482945, 961306706, '6321uk167e', 'myaeg', 1776677682, 'swwj', 'tri_361e50', -1967104388, 1167178586, '7sn0m73', 1661083231);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482944, -1139389605, '6y0mci', 'slwah4vs', 727960956, 'vlnwrz89ebk', 'tri_361e50', 1582679195, 1743535852, 'kbcvp1g', 58566796);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482943, 1455921136, 'cgtkwch', '3ibk2hd3', -1892227016, 'uqb4y5', 'tri_361e50', -715138531, -274836800, 'vc35q', -1939090233);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482942, 1756568536, 'vrw9ajr2amti', 'ik6rnoh', -1536082503, '6cpaceukbkx', 'tri_361e50', 793851993, -1357266133, 'jh5by3', -1498306493);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482941, -721036140, '5gak0', 'pygqdxrb4kme', 298647531, 'uj40s7er32qz', 'tri_361e50', 614038136, -275788966, 'p8hv', -1710114245);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482940, 583809051, '11ng', 'o', 35257661, 'lk', 'tri_361e50', -1123006885, -1716133396, 'fhj1s', 2051165707);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147482939, 207973688, '4dl8derobkr4', '1lawu4', 13268824, 'tcmmp4dzo', 'tri_361e50', -1961358031, 1327000387, 'b9x', -1757208847);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."lat" AS "lat", "LHS"."long" AS "long", "LHS"."dock_count" AS "dock_count", "LHS"."city" AS "city", "LHS"."installation_date" AS "installation_date", "RHS"."bike_id" AS "bike_id", "RHS"."end_station_id" AS "end_station_id", "RHS"."n" AS "n" FROM "station" AS "LHS" CROSS JOIN (SELECT "bike_id", "end_station_id", COUNT(*) AS "n" FROM "trip" GROUP BY "bike_id", "end_station_id") AS "RHS") WHERE ("city" = 'Palo Alto' OR n = 100) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('sta_5e117e',)
('sta_ff4126',)
*/

-- Prediction Query
SELECT name FROM station WHERE city = 'Palo Alto' EXCEPT SELECT end_station_name FROM trip GROUP BY end_station_name HAVING COUNT(*) > 100;

/*
Prediction Result:
('sta_5e117e',)
('sta_ff4126',)
*/