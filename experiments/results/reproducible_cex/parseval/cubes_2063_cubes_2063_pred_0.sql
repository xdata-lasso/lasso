-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1, 'lhs_b589b9', 1, 1, 'lhs_d052fe');

-- Inserting into table: roller_coaster --
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483648, 1, '5sw', 'rol_1aa2a1', 357.862717, 792.996259, 'g', 'k9n8c', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483647, 1, 'gu7v', 'rol_1aa2a1', 86.520366, 65.761562, 'hria2ypuzhs', 'rwbbp6luhvd', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483646, 1, 'tilbn', 'rol_1aa2a1', 240.969194, 267.815776, 'dpos', 'ie5', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483645, 1, 'w6kl', 'rol_1aa2a1', 83.204633, 5.585347, '000t5c4ec', 'gce', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483644, 1, '6nium52zb', 'rol_1aa2a1', 676.357279, 225.300904, 'rqro', 'fqyp5s5bbp0', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483643, 1, 'eutliqa11r', 'rol_1aa2a1', 997.73177, 881.232072, 'too3o9h', '72k', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483642, 1, 'x1', 'rol_1aa2a1', 482.572691, 133.223471, 'zwau2dwyr', '13pyu', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483641, 1, '9rljsl0b4', 'rol_1aa2a1', 884.000446, 598.741024, '5qi2', 'kf9vq', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483640, 1, '8pz0f8je', 'rol_1aa2a1', 755.698226, 778.537349, 'd21vy9uxj4hw', 'd', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483639, 1, 'ph2', 'rol_1aa2a1', 109.083092, 802.414724, 'q', 'nqcx5h', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483638, 1, 'p', 'rol_1aa2a1', 269.734861, 304.188492, 'dz79fjg', '8n2f3', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483637, 1, 'qv0gcb98ozk', 'rol_1aa2a1', 463.845085, 892.659478, 'lyr', 'kn6vck6ah0f8', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483636, 1, 'wwlq7', 'rol_1aa2a1', 786.074668, 748.513304, 'b72fxa', '7ryfdrz16n', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483635, 1, 'jai', 'rol_1aa2a1', 906.609226, 62.386264, '5o', 'rg', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483634, 1, '8', 'rol_1aa2a1', 740.059813, 388.212083, 't1afgog', 'itsj3', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483633, 1, 'xp1q430', 'rol_1aa2a1', 947.945777, 571.595144, 'jh3den8c68', '8vacx7', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483632, 1, 'u5', 'rol_1aa2a1', 354.593207, 432.405958, 'f77pzo72ctd', 't', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483631, 1, 'g6', 'rol_1aa2a1', 443.518915, 415.494881, '5q8qdj', 'e1io', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483630, 1, '78507cvt', NULL, 145.3181, 789.724834, 'ttg6bnou5zi3', 'c4bfkfoac', '0');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483629, 1, 'zezjo7wg', NULL, 790.772456, 50.798088, 'ysxcmr0o', 'ztdgj5i3lq5l', 'pim5');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483628, 1, '8qs27p2r', NULL, 555.274052, 477.692813, 'h2mna', 'jla', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483627, 1, 'okv8uttmu2', NULL, 208.49371, 497.427028, '8lfvyz7zz', 'be8yvkv42q7', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483626, 1, '58b4pm', NULL, 959.473065, 930.69464, 'us3auvmkrpdj', 'wzw5chn9mo70', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483625, 1, 'a9n0jxfofws', 'do2zobb', 407.368744, 983.253685, '0k32odwcl5a', 'msorlwyngc', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483624, 1, 'j', '9erhizgk1yoe', 845.392744, 619.529525, 'l0hdt6fuq', 'xuzkb52', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483623, 1, 'wn', 'rol_1aa2a1', 176.569118, 1.63343, 'elboeowii', 'z5nxih6', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483622, 1, '2xlyo', 'rol_1aa2a1', 749.652116, 746.02004, 'ow9oa', 'awg96aqb0tbi', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483621, 1, 'z', 'rol_1aa2a1', 466.613431, 985.521662, 'j', '9td8n5w', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483620, 1, 'um', 'rol_1aa2a1', 30.758515, 34.96555, '3tdu6bd0w960', 'vzxw1rxe', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483619, 1, 'k7', 'rol_1aa2a1', 256.291309, 931.189708, '162nh55y3d', 'ohvu06dza3', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483618, 1, 'rmkio18ri2', 'rol_1aa2a1', 890.677915, 590.734291, '08ftp6ewtqxx', 'jaby', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483617, 1, 'n2mfx7h', 'rol_1aa2a1', 463.637542, 753.382585, '6sto', 'cj8sh5k', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483616, 1, 'zys7dyyd1jmg', 'rol_1aa2a1', 669.860178, 8.996465, '8q', 'ta8y3a17v4', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483615, 1, 'ma', 'rol_1aa2a1', 383.770043, 851.486083, 'dpuap', '6rntdqrhm', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483614, 1, 'wlic7dn2np', 'rol_1aa2a1', 480.228838, 898.682383, 'xdmsqtg', 'lc', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483613, 1, 'qb9i9f2ccu', 'rol_1aa2a1', 170.693019, 253.547988, '1quik1yhb08h', 'st1', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483612, 1, 'qomiztvb6m', 'rol_1aa2a1', 482.609422, 398.641235, '78aqqlud8ft', '8', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483611, 1, '9114qbre6bj', 'rol_1aa2a1', 71.721662, 312.71205, 'wsj8kj', '85', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483610, 1, 'xlvr', 'rol_1aa2a1', 128.618112, 289.561925, 'urz0kaqtncg', 'c8s3b7v88k', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483609, 1, 'm', 'rol_1aa2a1', 880.348467, 889.074497, 'h', '6j47n', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483608, 1, 'r', 'rol_1aa2a1', 491.36959, 419.924811, 'sjhanzxdpu', 'mwfw', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483607, 1, 'rlawk', 'rol_1aa2a1', 417.346356, 930.12583, '14r5dqtsmg9', 'aqz2o20pj', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483606, 1, 'dlysu6iphd', 'rol_1aa2a1', 168.487055, 320.257221, 'gir31vwq', '1oa2sb3u', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483605, 1, '1pa', 'rol_1aa2a1', 908.397506, 781.008765, 'wnyqro', 'uirlrpouit', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483604, 1, 'xyfvmjwpp26', 'rol_1aa2a1', 945.48391, 20.124208, 'j', '0ju0h3r133ir', 'rol_e232af');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483603, 1, 'x', 'rol_1aa2a1', 387.054953, 606.332644, 'pl', 'i9esap8p', 'rol_e232af');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count___ FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.park AS park, RHS.status AS status, RHS.n_distinct AS n_distinct FROM country AS LHS CROSS JOIN (SELECT park, status, COUNT(DISTINCT country_id) AS n_distinct FROM roller_coaster GROUP BY park, status) AS RHS) WHERE (n_distinct >= 3000 OR n_distinct <> country_id) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM country WHERE NOT country_id IN (SELECT country_id FROM roller_coaster WHERE LENGTH > 3000);

/*
Prediction Result:
(1,)
*/