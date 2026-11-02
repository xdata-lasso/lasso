-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("actid", "activity_name") VALUES (1001, 'Kayaking');
INSERT INTO "activity" ("actid", "activity_name") VALUES (1007, 'Kayaking');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1002, 'Fowler', 'Angel', 1003, 'face', 1004, 1005, 'East Donald');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1008, 'Fowler', 'Angel', 1003, 'face', 1004, 1005, 'East Donald');
INSERT INTO "participates_in" ("actid", "stuid") VALUES (1001, 1002);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "stuid" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."actid" AS "actid", "RHS"."activity_name" AS "activity_name" FROM "participates_in" AS "LHS" LEFT JOIN "activity" AS "RHS" ON ("LHS"."actid" = "RHS"."actid")) WHERE ("activity_name" <> 'Canoeing' OR "activity_name" = 'Kayaking') ORDER BY stuid, "stuid" NULLS LAST;

/*
Gold Result:
(1002,)
*/

-- Prediction Query
SELECT T1.stuid FROM participates_in AS T1 JOIN activity AS T2 ON T2.actid = T2.actid WHERE T2.activity_name = 'Canoeing' INTERSECT SELECT T1.stuid FROM participates_in AS T1 JOIN activity AS T2 ON T2.actid = T2.actid WHERE T2.activity_name = 'Kayaking';

/*
Prediction Result:
*/