-- Schema DDL
CREATE TABLE "race" ("Race_ID" INTEGER PRIMARY KEY, "Track_ID" TEXT, "Name" TEXT, "Class" TEXT, "Date" TEXT, FOREIGN KEY ("Track_ID") REFERENCES "track" ("Track_ID"));

CREATE TABLE "track" ("Track_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Location" TEXT, "Seating" REAL, "Year_Opened" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: track --
INSERT INTO "track" ("track_id", "name", "location", "seating", "year_opened") VALUES (-2147483648, '5k5swwqcgs', '9n8', 874.871895, 475.173408);

-- Inserting into table: race --
INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483648, '-2147483648', 'u7', 'rac_94cb2f', 'fe4hri');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483647, '-2147483648', 'ypuzhsrw', 'rac_94cb2f', 'b');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483646, '-2147483648', 'luhvdltti', 'rac_94cb2f', 'bnp');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (2, '-2147483648', 'dpos', 'rac_94cb2f', 'ie5');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (3, '-2147483648', 'w6kl', 'rac_94cb2f', 'a9');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483645, '-2147483648', '00t5c4ecigc', 'rac_94cb2f', 'e376nium52');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483642, '-2147483648', 'u', 'G', '4nrq');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483641, '-2147483648', 'fqyp', 'G', 's5bbp02e');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483640, '-2147483648', 'liqa1', 'A', 'ryytoo3');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483639, '-2147483648', 'hl72klex1', 'O', 'ji7zwau2');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483638, '-2147483648', 'yrq13p', 'O', 'u78d99r');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483637, '-2147483648', 'sl0', 'A', '4');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483636, '-2147483648', 'p5qi2rkf9v', 'G', 'x58pz');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483635, '-2147483648', 'f8jegd21vy9u', 'G', 'j4hwbd');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483634, '-2147483648', 'ph2', 'A', 'nd');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483633, '-2147483648', 'nqcx5h', 'G', 'cprj');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483632, '-2147483648', '0dz79f', 'G', 'gq8');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483631, '-2147483648', 'f3dqv0gc', 'A', '9');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483630, '-2147483648', 'k3zbily', NULL, 'kn6vc');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483629, '-2147483648', 'ah0f8jsww', NULL, 'q7x');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483628, '-2147483648', '72fxa7ryfd', NULL, 'z16ni');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483627, '-2147483648', 'ai5', 'rac_94cb2f', 'h');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483626, '-2147483648', 'grgj', 'rac_94cb2f', '8');

INSERT INTO "race" ("race_id", "track_id", "name", "class", "date") VALUES (-2147483625, '-2147483648', 't1afgog', 'rac_94cb2f', 'itsj3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT CLASS FROM (SELECT LHS.class AS CLASS, LHS.track_id AS track_id, LHS.n AS n, RHS.class AS class_other, RHS.track_id AS track_id_other, RHS.n AS n_other FROM (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS LHS CROSS JOIN (SELECT CLASS, track_id, COUNT(*) AS n FROM race GROUP BY CLASS, track_id) AS RHS) WHERE (n > n_other) ORDER BY CLASS;

/*
Gold Result:
(None,)
('A',)
('G',)
('rac_94cb2f',)
*/

-- Prediction Query
SELECT CLASS FROM race GROUP BY CLASS ORDER BY COUNT(*) DESC, CLASS NULLS LAST LIMIT 1;

/*
Prediction Result:
('rac_94cb2f',)
*/