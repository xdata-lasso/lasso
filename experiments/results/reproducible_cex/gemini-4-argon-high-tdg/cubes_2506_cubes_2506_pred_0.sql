-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 20, 'M', 100, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Doe', 'Jane', 21, 'F', 100, 10, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Brown', 'Bob', 19, 'M', 200, 20, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Davis', 'Eve', 22, 'F', 200, 20, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Wilson', 'Tom', 20, 'M', 300, 30, 'SEA');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (1, 'Wrestling', 10, 5, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (2, 'Wrestling', 12, 6, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (3, 'Archery', 8, 4, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (4, 'Archery', 9, 3, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (5, 'Archery', 7, 2, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (1, 'Tennis', 15, 10, 'Y');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (2, 'Soccer', 10, 8, 'N');
INSERT INTO SportsInfo (StuID, SportName, HoursPerWeek, GamesPlayed, OnScholarship) VALUES (3, 'Soccer', 11, 9, 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sportname" FROM (SELECT "onscholarship", "sportname", COUNT(*) AS "n" FROM "sportsinfo" GROUP BY "onscholarship", "sportname") WHERE ("onscholarship" = 'Y' AND n > 1) ORDER BY sportname, "sportname" NULLS LAST;

/*
Gold Result:
('Archery',)
('Wrestling',)
*/

-- Prediction Query
SELECT sportname FROM Sportsinfo WHERE onscholarship = 'Y' GROUP BY sportname ORDER BY COUNT(*) DESC, sportname NULLS LAST LIMIT 1;

/*
Prediction Result:
('Archery',)
*/