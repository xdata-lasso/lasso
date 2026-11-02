-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1164, 'Kennedy', 'James', 1167, 'land', 1170, 1173, 'Lake Deniseville');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1165, 'Mueller', 'Collin', 1176.0, 'item', 1183.0, 1188.0, 'South Jessicaville');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1166, 'Aguirre', 'Ryan', 1185.0, 'manage', 1196.0, 1203.0, 'East James');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1182, 'Wright', 'Michelle', 1185, 'now', 1188, 1191, 'Port Melindaburgh');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1183, 'Leblanc', 'Andrea', 1194.0, 'think', 1201.0, 1206.0, 'Tuckerborough');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1184, 'Ramos', 'Brent', 1203.0, 'administration', 1214.0, 1221.0, 'Barreraburgh');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1164, 'Javier Ramirez', 1176, 1179, 'Y');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1164, 'Javier Ramirez', 1183.0, 1188.0, 'Y');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1164, 'Javier Ramirez', 1190.0, 1197.0, 'Y');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1182, 'William Baker', 1194, 1197, 'Y');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1182, 'William Baker', 1201.0, 1206.0, 'Y');
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1182, 'William Baker', 1208.0, 1215.0, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sportname" FROM (SELECT "onscholarship", "sportname", COUNT(*) AS "n" FROM "sportsinfo" GROUP BY "onscholarship", "sportname") WHERE ("onscholarship" = 'Y' AND n > 1) ORDER BY sportname, "sportname" NULLS LAST;

/*
Gold Result:
('Javier Ramirez',)
('William Baker',)
*/

-- Prediction Query
SELECT sportname FROM Sportsinfo WHERE onscholarship = 'Y' GROUP BY sportname ORDER BY COUNT(*) DESC, sportname NULLS LAST LIMIT 1;

/*
Prediction Result:
('Javier Ramirez',)
*/