-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (-2147483648, '5k5swwqcgs', 247012447, -1980249628, 'gu7v');

-- Inserting into table: roller_coaster --
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483648, -2147483648, 'e4', 'hria2ypuzhs', 663.049759, 1.0, 'wbbp6luhvdlt', 'ilbnp', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483647, -2147483648, 'dpos', 'ie5', 327.753528, 1.0, 'w6kl', 'a9', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483646, -2147483648, '00t5c4ecigc', 'e376nium52', 816.814398, 1.0, 'buo4nrq', 'rofqyp5s5b', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483645, -2147483648, '02eu', 'liqa1', 982.938576, 1.0, 'yytoo', 'o9hl72kl', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483644, -2147483648, 'x14ji7zwau2d', 'yrq13p', 375.832821, 1.0, '8d99rljsl', 'b4yp5qi', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483643, -2147483648, 'kf9vq', 'x58pz0f8je', 755.698226, 1.0, 'd2', 'vy9uxj4', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483642, -2147483648, 'bdvlph', 'gndqwnqc', 629.317167, NULL, '5hncprjtu0d', '79fjgq8', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483641, -2147483648, 'f3dqv0gc', '9', 540.154414, NULL, 'k3zbily', 'kn6vc', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483640, -2147483648, 'ah0f8jsww', 'q7x', 21.129657, NULL, '2fxa7ryfd', 'z16ni', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483639, -2147483648, 'ai5', 'h', 488.601669, 1.0, 'grgj', '8', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483638, -2147483648, 't1afgog', 'itsj3', 15.432127, 1.0, 'xp1q430', 'jh3den8', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483637, -2147483648, '68x8vacx7a', 'u5', 354.593207, 1.0, 'of77pzo', '72ctdctmfg62', NULL);

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483636, -2147483648, 'v5q8qdj', 'e1io', 443.690199, 1.0, '8507cvtjp', 'ttg6bnou5zi3', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483635, -2147483648, 'bfkfoacd', '7z2zezj', 837.309049, 1.0, 'wgxd5ysxc', 'r0oz', 'rol_37b039');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483634, -2147483648, 'g', '5i3', 172.799686, 1.0, '5lnpim5k58qs', '7p2r94gt', 'rol_37b039');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM (SELECT height, status, COUNT(*) AS n FROM roller_coaster GROUP BY height, status) WHERE (n <= 2) ORDER BY status;

/*
Gold Result:
*/

-- Prediction Query
SELECT Status FROM roller_coaster GROUP BY Status HAVING COUNT(*) > 2;

/*
Prediction Result:
(None,)
('rol_37b039',)
*/