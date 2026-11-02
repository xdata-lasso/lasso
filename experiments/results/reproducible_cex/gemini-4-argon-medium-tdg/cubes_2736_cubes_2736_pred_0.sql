-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, WHERE vs EXCEPT semantics, OR vs AND in WHERE clause, and ordering
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Canoeing');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (2, 'Kayaking');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (3, 'Soccer');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Smith', 'John', 20, 'M', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Doe', 'Jane', 21, 'F', 100, 1, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (30, 'Brown', 'Bob', 22, 'M', 200, 2, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (40, 'White', 'Alice', 19, 'F', 200, 2, 'BOS');
-- Student 30 only does Canoeing (should be excluded)
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (1, 30);
-- Student 20 does Kayaking (should be included)
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 20);
-- Student 40 does Soccer (should be included, kills mutants that only check activity_name = 'Kayaking')
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (3, 40);
-- Student 10 does BOTH Canoeing and Soccer (should be included, kills EXCEPT / NOT IN mutants)
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (1, 10);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (3, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "stuid" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."actid" AS "actid", "RHS"."activity_name" AS "activity_name" FROM "participates_in" AS "LHS" LEFT JOIN "activity" AS "RHS" ON ("LHS"."actid" = "RHS"."actid")) WHERE ("activity_name" <> 'Canoeing' OR "activity_name" = 'Kayaking') ORDER BY stuid, "stuid" NULLS LAST;

/*
Gold Result:
(10,)
(20,)
(40,)
*/

-- Prediction Query
SELECT T1.stuid FROM participates_in AS T1 JOIN activity AS T2 ON T2.actid = T2.actid WHERE T2.activity_name = 'Canoeing' INTERSECT SELECT T1.stuid FROM participates_in AS T1 JOIN activity AS T2 ON T2.actid = T2.actid WHERE T2.activity_name = 'Kayaking';

/*
Prediction Result:
(10,)
(20,)
(30,)
(40,)
*/