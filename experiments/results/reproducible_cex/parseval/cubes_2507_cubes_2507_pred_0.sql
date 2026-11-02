-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'stu_07bfc0', 'stu_5d9208', 1, 'M', 1, 1, 'stu_ef1760');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'stu_24e65f', 'stu_9490d5', 1, 'M', 1, 1, 'stu_a9596e');

-- Inserting into table: sportsinfo --
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_7164ef');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, NULL, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', NULL, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'Football', 1, 1, 'spo_35cbbf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "stuid" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."sportname" AS "sportname", "RHS"."hoursperweek" AS "hoursperweek", "RHS"."gamesplayed" AS "gamesplayed", "RHS"."onscholarship" AS "onscholarship" FROM (SELECT * FROM "student" WHERE ("sex" = 'M')) AS "LHS" LEFT JOIN (SELECT * FROM "sportsinfo" WHERE ("sportname" = 'Football')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY stuid, "stuid" NULLS LAST;

/*
Gold Result:
(-2147483647,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT StuID FROM Student WHERE sex = 'M' EXCEPT SELECT StuID FROM Sportsinfo WHERE sportname = 'Football';

/*
Prediction Result:
(-2147483647,)
*/