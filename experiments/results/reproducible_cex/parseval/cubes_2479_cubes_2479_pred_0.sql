-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'lhs_b02b71', 'lhs_bd7218', 1, 'lhs_6c8ed3', 600, 1, 'lhs_859a20');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'lhs_947221', 'lhs_75d189', 1, 'lhs_f16fea', 600, 1, 'lhs_a2d0e8');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (3, 'lhs_b02b71', 'lhs_bd7218', 1, 'lhs_6c8ed3', 600, 1, 'lhs_859a20');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (2, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

-- Inserting into table: sportsinfo --
INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_f504c9', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (2, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (2, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (2, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (2, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (2, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_f504c9', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_f504c9', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_f504c9', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_f504c9', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_f504c9', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'rhs_c59f03');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', NULL, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, NULL, 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, NULL, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');

INSERT INTO "sportsinfo" ("stuid", "sportname", "hoursperweek", "gamesplayed", "onscholarship") VALUES (1, 'rhs_52e0f4', 1, 1, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "stuid" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."sportname" AS "sportname", "RHS"."hoursperweek" AS "hoursperweek", "RHS"."gamesplayed" AS "gamesplayed", "RHS"."onscholarship" AS "onscholarship" FROM "student" AS "LHS" INNER JOIN "sportsinfo" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid")) WHERE ("onscholarship" = 'Y' AND major = 600) ORDER BY stuid, "stuid" NULLS LAST;

/*
Gold Result:
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
SELECT StuID FROM Student WHERE major = 600 INTERSECT SELECT StuID FROM Sportsinfo WHERE onscholarship = 'Y';

/*
Prediction Result:
(1,)
*/