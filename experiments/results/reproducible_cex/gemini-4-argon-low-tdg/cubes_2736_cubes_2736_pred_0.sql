-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in activity_name, NULL in Participates_in.actid, NULL in Participates_in.stuid, and NULLS LAST ordering.
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Canoeing');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (2, 'Kayaking');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (3, NULL);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (10, 'Adams', 'Amy', 20, 'F', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (20, 'Baker', 'Ben', 21, 'M', 100, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (30, 'Clark', 'Dan', 22, 'M', 100, 1, 'NYC');
-- Student 30 in Kayaking (Inserted first to test ORDER BY ASC)
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 30);
-- Student 10 in Kayaking
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 10);
-- NULL stuid in Kayaking (Tests NULLS LAST in ORDER BY; kills standard ASC ordering where NULLs come first in SQLite)
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, NULL);
-- Student 20 in Activity with NULL activity_name (Should be excluded because NULL <> 'Canoeing' is UNKNOWN; kills IS NOT 'Canoeing' or unjoined table mutants)
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (3, 20);
-- Student 20 with NULL actid (Left join yields NULL activity_name, should be excluded)
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (NULL, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "stuid" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."actid" AS "actid", "RHS"."activity_name" AS "activity_name" FROM "participates_in" AS "LHS" LEFT JOIN "activity" AS "RHS" ON ("LHS"."actid" = "RHS"."actid")) WHERE ("activity_name" <> 'Canoeing' OR "activity_name" = 'Kayaking') ORDER BY stuid, "stuid" NULLS LAST;

/*
Gold Result:
(None,)
(10,)
(30,)
*/

-- Prediction Query
SELECT T1.stuid FROM participates_in AS T1 JOIN activity AS T2 ON T2.actid = T2.actid WHERE T2.activity_name = 'Canoeing' INTERSECT SELECT T1.stuid FROM participates_in AS T1 JOIN activity AS T2 ON T2.actid = T2.actid WHERE T2.activity_name = 'Kayaking';

/*
Prediction Result:
(None,)
(10,)
(20,)
(30,)
*/