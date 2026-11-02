-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (-2147483648, '5k5swwqcgs', 247012447, -1980249628, 'gu7v');

-- Inserting into table: roller_coaster --
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483648, -2147483648, 'e4', 'hria2ypuzhs', 663.049759, 711.020062, 'b', 'p6luhvdlttil', 'rol_32d828');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483647, -2147483648, 'nprmdposii', '5u', 933.422701, 345.718563, 'klfa9000t', 'c4ecigce', 'rol_32d828');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483646, -2147483648, '6nium52zb', 'uo4nrqrofqy', 242.260296, 938.694822, 'bbp02eut', 'iqa', 'rol_32d828');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (2, -2147483648, 'ryytoo3', '9hl7', 443.457804, 774.422647, 'ex1', 'ji7zwau2', 'rol_32d828');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (3, -2147483648, 'yrq13p', 'u78d99r', 182.777264, 943.791649, 'l0b4y', 'p5qi2rkf9v', 'rol_32d828');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483645, -2147483648, 'x58pz0f8je', 'd2', 890.091601, 339.69384, '9uxj4hwbdvl', 'h2gn', 'rol_32d828');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483642, -2147483648, 'wnqcx', '5hncprjtu0d', 395.809081, 552.472052, 'fjgq8n2f3d', 'qv0gcb98ozk', 'G');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483641, -2147483648, 'bilyrkn', '6vck6ah0f8js', 346.706184, 176.824244, 'xb72fxa7r', 'fdrz16n', 'G');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483640, -2147483648, 'jai', 'dh5ogrgj', 54.980195, 958.424773, 'yzt1afgogrit', 'sj3ayxp1q430', 'A');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483639, -2147483648, 'jh3den8c68', '8vacx7', 854.793228, 983.924121, '5w1of7', 'pzo72ctdc', 'Q');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483638, -2147483648, 'mfg62g0v5q8q', 'j', 234.606624, 432.865904, '2278', '07cvtjpt', 'Q');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483637, -2147483648, '6b', 'ou5z', 988.279797, 893.898414, '6c4bfkfo', 'c', 'A');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483636, -2147483648, '7z2zezj', '7wgx', 50.798088, 486.564401, 'xcmr0', 'ztdg', 'E');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483635, -2147483648, '5i3lq5lnpim5', '58q', 975.929586, 923.138524, '7p2r94gt', '2m', 'E');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483634, -2147483648, 'ajjla3okv8u', 'tmu2n', 76.823924, 572.833475, 'lfvyz7zzb', '8y', '!');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483633, -2147483648, 'v42', '7sx58', 682.232894, 476.006677, 'pmaus3auvmk', 'rpdjwzw5ch', 'O');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483632, -2147483648, 'mo705a9n0', 'xfo', 82.48091, 296.34381, 'do2zobb', 'q0k32od', 'O');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483631, -2147483648, 'l', '5amsorlwyngc', 424.71131, 605.551549, '9erhizgk1yoe', 'o6l0hdt', 'A');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483630, -2147483648, 'qyxuzk', '5', 451.913941, 107.446882, 'las6', 'elboeowii1', 'rol_32d828');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483629, -2147483648, 'nxih662q', 'xlyotow9', 232.87238, 669.409476, 'awg96aqb0tbi', 'ndz39tajz9', 'rol_32d828');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483628, -2147483648, '8', '5wcg', 314.953709, 30.758515, '3', 'tdu6bd0w96', 'rol_32d828');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483627, -2147483648, 'vzxw1rxe', '9yfk7qk162n', 111.965818, 490.363975, 'y3dohvu0', 'dza35rmki', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483626, -2147483648, '8ri2hy0', '8ftp6ewtqx', 361.5356, 210.679814, 'jabymzn2mfx7', '33', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483625, -2147483648, '6sto1cj8sh5k', 'zys7', 846.300006, 376.265501, 'd1jmgja', 'h', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM (SELECT LHS.roller_coaster_id AS roller_coaster_id, LHS.name AS name, LHS.park AS park, LHS.country_id AS country_id, LHS.length AS LENGTH, LHS.height AS height, LHS.speed AS speed, LHS.opened AS opened, LHS.status AS status, RHS.n AS n FROM roller_coaster AS LHS LEFT JOIN (SELECT roller_coaster_id, name, park, country_id, LENGTH, height, speed, opened, status, COUNT(*) OVER () AS n FROM roller_coaster) AS RHS ON (LHS.roller_coaster_id = RHS.roller_coaster_id AND LHS.name = RHS.name AND LHS.park = RHS.park AND LHS.country_id = RHS.country_id AND LHS.length = RHS.length AND LHS.height = RHS.height AND LHS.speed = RHS.speed AND LHS.opened = RHS.opened AND LHS.status = RHS.status)) ORDER BY status;

/*
Gold Result:
(None,)
('!',)
('A',)
('E',)
('G',)
('O',)
('Q',)
('rol_32d828',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster GROUP BY Status ORDER BY COUNT(*) DESC, Status NULLS LAST LIMIT 1;

/*
Prediction Result:
('rol_32d828',)
*/