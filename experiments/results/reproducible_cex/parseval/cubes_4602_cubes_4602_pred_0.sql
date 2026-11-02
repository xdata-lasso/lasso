-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (-2147483648, '5k5swwqcgs', 247012447, -1980249628, 'gu7v');

INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1, '76nium52', -443340271, 757448742, '4nrq');

-- Inserting into table: roller_coaster --
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483648, -2147483648, 'e4', 'hria2ypuzhs', 663.049759, 711.020062, 'rol_ab05fb', 'b', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483647, -2147483648, 'luhvdltti', 'bnp', 787.938887, 986.066566, 'rol_de6300', 'dposiie5unw', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483646, -2147483648, 'fa9', '00t5c4e', 950.466571, 796.740316, 'rol_158a0c', 'gce', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1, 1, 'lhs_d1c972', 'lhs_2622bd', 1.0, 1.0, 'lhs_2a5049', 'lhs_cb0862', 'lhs_01e1cd');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483644, 1, 'fqyp', 's5bbp02e', 325.080047, 186.190286, 'rol_ab05fb', 'a11ry', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483643, 1, 'oo3o9', 'l7', 443.457804, 774.422647, 'rol_de6300', 'ex1', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483642, 1, 'i7z', 'au2dwy', 278.010437, 433.533777, 'rol_158a0c', 'pyu78d99', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483641, 1, 'jsl', 'b4yp5qi', 447.109657, 164.583726, '9v', 'x58pz', 'f8jegd2');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483640, 1, 'y9uxj4', 'wb', 50.647649, 185.427628, 'rol_ab05fb', 'h2gn', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483639, -2147483648, 'wnqcx', '5hncprjtu0d', 395.809081, 552.472052, NULL, 'fjgq8n2f3d', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483638, 1, '0gcb98', 'zk3z', 892.659478, 138.057338, NULL, 'yrkn6vck6ah0', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483637, -2147483648, 'wwlq7', 'xb72fxa7ryfd', NULL, 276.61064, '16nijja', '5dh', 'ogrgjd8y');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483636, 1, '1afgo', 'ri', NULL, 630.468925, 'rol_ab05fb', 'sj3ay', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483635, 1, '1q43', '1jh3den', NULL, 544.095565, NULL, 'c68x8vacx7', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483634, -2147483648, 'u5', '1of77p', NULL, 398.637058, NULL, '72ctdctmfg62', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483633, -2147483648, NULL, 'v5q8qdj', 234.606624, 432.865904, '2278', '07cvtjpt', 'tg6bnou5zi');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483632, 1, NULL, 'c4bfkfoac', 60.937725, 413.382111, 'rol_ab05fb', 'z2zezjo7w', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483631, -2147483648, NULL, 'd5ysxc', 187.71278, 789.269201, NULL, '0oztd', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483630, -2147483648, NULL, '5i3', 172.799686, 913.609637, NULL, 'lnpim5k5', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483629, 1, 's27p2r94gth2', 'najj', 185.260952, 462.366429, 'kv8u', 'tmu2n', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483628, -2147483648, '78lfvyz7', 'zzbe8yvkv4', 445.606673, 574.707916, 'rol_ab05fb', 'sx58b4pma', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483627, 1, '3auvm', 'rpd', 144.157236, 677.090643, NULL, 'zw5chn', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483626, -2147483648, 'o705a9n0jxfo', 'ws', 900.422166, 55.294573, NULL, '2zob', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483625, -2147483648, 'q0k32od', 'cl5ams', 665.099697, 270.763563, NULL, 'yngc1d', 'j9erhizgk1');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483624, 1, 'eyo6', 'l0hdt6fuqyx', 789.60677, 323.811635, 'rol_ab05fb', 'kb521gw', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483623, -2147483648, 'as6', 'elboeowii1', 393.510383, 862.561101, NULL, 'xih662q2xly', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483622, -2147483648, 'tow9oaawg96a', 'qb0tbindz39t', 974.58376, 151.892832, NULL, '9td8n5w', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483621, -2147483648, 'um', NULL, 30.758515, 34.96555, '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483620, -2147483648, '55y3dohvu06d', NULL, 397.847489, 464.095805, 'rol_ab05fb', 'rmkio18ri2', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483619, -2147483648, 'y08ftp6ewt', NULL, 255.149792, 361.5356, NULL, 'jaby', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483618, -2147483648, 'n2mfx7h', NULL, 463.637542, 753.382585, NULL, '6sto', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483617, 1, 'j', 'sh5knzys7', 846.300006, 376.265501, 'd1jmgja', NULL, 'h');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483616, 1, 'ta8y3a17v4', 'ygmayq3qdpu', 871.372603, 237.529885, 'rol_ab05fb', NULL, 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483615, 1, 'tdqr', 'm5', 968.21585, 583.44162, NULL, NULL, 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483614, 1, 'ic7', 'dn2np490xdm', 840.039966, 964.892941, NULL, NULL, 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483613, 1, 'gelcu', 'qb9i9f2ccu', 170.693019, NULL, '1quik', 'yhb08hl', 't1pqo');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483612, -2147483648, 'ztv', '6', 196.268517, NULL, 'rol_ab05fb', 'z78', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483611, -2147483648, 'qlud8', 'tb', 544.766726, NULL, NULL, '9114qbre6bj', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483610, -2147483648, 'uuwsj8kjh8', 'wpxlvris', 637.018037, NULL, NULL, 'rz0kaq', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483609, 1, 'ncgc8s3b7v', '88kwdmdbdht6', 573.061557, 953.185987, 'rol_ab05fb', 'nxar50hsj', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483608, -2147483648, 'n', 'xdpunmw', 986.324533, 85.020008, NULL, 'qrlawk', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483607, 1, '14r5dqtsmg97', 'aqz2o20pj6d', 562.744101, 949.111842, NULL, 'ysu', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483606, -2147483648, 'phdku2gir31v', 'q51oa2', 706.295383, 944.164129, NULL, '3', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483605, 1, 'i1pa', 'cvwnyq', 265.913399, 973.214347, NULL, 'uirlrpouit63', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483604, 1, 'yfvmjwpp26m', '3', 940.97048, 145.282125, NULL, 'ju0h3r1', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483603, 1, 'ir1axyyh', 'l2i9', 72.185429, 13.527735, 'rol_ab05fb', '8pgc', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483602, -2147483648, 'wtsr5', '4o6qjektb1', 840.973378, 451.237024, NULL, 'zg3rjkwns47j', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483601, 1, 'a8d', 'c', 377.389472, 584.512314, NULL, 'jwq49y', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483600, 1, 'nxs6dvdxdo2v', '7t3gvplj9f', 146.155144, 711.025874, 'rol_ab05fb', 'n7k10z', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483599, 1, 'y1og', 'v1rgeza', 598.494048, 46.864581, NULL, 'clupgly', 'rol_8796be');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483598, -2147483648, 'txe', 'lpe', 421.254208, 770.869988, NULL, 'cy7od033d', 'rol_8796be');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT park FROM (SELECT LHS.roller_coaster_id AS roller_coaster_id, LHS.name AS name, LHS.park AS park, LHS.country_id AS country_id, LHS.length AS LENGTH, LHS.height AS height, LHS.speed AS speed, LHS.opened AS opened, LHS.status AS status, RHS.status AS status_other, RHS.speed AS speed_other FROM roller_coaster AS LHS CROSS JOIN (SELECT status, MAX(speed) AS speed FROM roller_coaster GROUP BY status) AS RHS) WHERE (speed = speed_other) ORDER BY park;

/*
Gold Result:
(None,)
(None,)
('6',)
('7t3gvplj9f',)
('88kwdmdbdht6',)
('b4yp5qi',)
('bnp',)
('c4bfkfoac',)
('hria2ypuzhs',)
('l0hdt6fuqyx',)
('l2i9',)
('l7',)
('lhs_2622bd',)
('qb9i9f2ccu',)
('ri',)
('s5bbp02e',)
('sh5knzys7',)
('v5q8qdj',)
('wb',)
('xb72fxa7ryfd',)
('ygmayq3qdpu',)
('zzbe8yvkv4',)
*/

-- Prediction Query
SELECT Park FROM roller_coaster ORDER BY Speed DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('bnp',)
*/