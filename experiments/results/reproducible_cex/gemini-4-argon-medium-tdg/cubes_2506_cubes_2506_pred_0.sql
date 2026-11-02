-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic counting, boundary conditions (n=1, n=2, n=3), OnScholarship filter ('Y', 'N', NULL, 'y'), and ordering.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 101, 1001, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 102, 1002, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Bob', 22, 'M', 101, 1001, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'White', 'Alice', 19, 'F', 103, 1003, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Green', 'Charlie', 20, 'M', 104, 1004, 'SEA');
-- Soccer: 2 with 'Y' (Matches), 1 with 'N'
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (1, 'Soccer', 10, 5, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (2, 'Soccer', 12, 6, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (3, 'Soccer', 8, 4, 'N');
-- Basketball: 1 with 'Y', 2 with 'N' (Should NOT match; kills mutants missing 'Y' filter or grouping only by SportName)
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (1, 'Basketball', 15, 10, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (2, 'Basketball', 15, 10, 'N');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (3, 'Basketball', 15, 10, 'N');
-- Tennis: 1 with 'Y' (Boundary n=1; kills n >= 1)
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (4, 'Tennis', 5, 2, 'Y');
-- Baseball: 3 with 'Y' (Matches; kills n = 2 and tests ASC vs DESC ordering against 'Soccer')
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (1, 'Baseball', 20, 15, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (2, 'Baseball', 20, 15, 'Y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (3, 'Baseball', 20, 15, 'Y');
-- Swimming: 2 with NULL OnScholarship (Should NOT match)
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (4, 'Swimming', 10, 5, NULL);
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (5, 'Swimming', 10, 5, NULL);
-- Golf: 2 with lowercase 'y' (Tests case sensitivity)
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (4, 'Golf', 6, 3, 'y');
INSERT INTO "SportsInfo" ("StuID", "SportName", "HoursPerWeek", "GamesPlayed", "OnScholarship") VALUES (5, 'Golf', 6, 3, 'y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sportname" FROM (SELECT "onscholarship", "sportname", COUNT(*) AS "n" FROM "sportsinfo" GROUP BY "onscholarship", "sportname") WHERE ("onscholarship" = 'Y' AND n > 1) ORDER BY sportname, "sportname" NULLS LAST;

/*
Gold Result:
('Baseball',)
('Soccer',)
*/

-- Prediction Query
SELECT sportname FROM Sportsinfo WHERE onscholarship = 'Y' GROUP BY sportname ORDER BY COUNT(*) DESC, sportname NULLS LAST LIMIT 1;

/*
Prediction Result:
('Baseball',)
*/