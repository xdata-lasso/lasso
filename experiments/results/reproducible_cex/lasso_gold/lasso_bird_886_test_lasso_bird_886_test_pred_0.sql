-- Schema DDL
CREATE TABLE seasons (year INTEGER PRIMARY KEY);

CREATE TABLE races (raceid INTEGER PRIMARY KEY, year INTEGER, round INTEGER, FOREIGN KEY (year) REFERENCES seasons (year));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "seasons" ("year") VALUES (1039);
INSERT INTO "seasons" ("year") VALUES (1040);
INSERT INTO "seasons" ("year") VALUES (1041);
INSERT INTO "seasons" ("year") VALUES (1042);
INSERT INTO "seasons" ("year") VALUES (1051);
INSERT INTO "seasons" ("year") VALUES (1052);
INSERT INTO "seasons" ("year") VALUES (1053);
INSERT INTO "seasons" ("year") VALUES (1054);
INSERT INTO "seasons" ("year") VALUES (1075);
INSERT INTO "seasons" ("year") VALUES (1063);
INSERT INTO "seasons" ("year") VALUES (1064);
INSERT INTO "seasons" ("year") VALUES (1065);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1043, 1039, 1047);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1044, 1039, 1054.0);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1045, 1039, 1061.0);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1046, 1039, 1068.0);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1055, 1051, NULL);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1056, 1051, NULL);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1057, 1051, NULL);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1058, 1051, NULL);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1066, 1051, 1070);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1067, 1051, 1077.0);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1068, 1051, 1084.0);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1069, 1051, 1091.0);
INSERT INTO "races" ("raceid", "year", "round") VALUES (1074, 1039, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(round) DESC, year NULLS LAST LIMIT 1;

/*
Gold Result:
(1039,)
*/

-- Prediction Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(*) DESC, year NULLS LAST LIMIT 1;

/*
Prediction Result:
(1051,)
*/