-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. WHERE condition: OR vs AND, Fname='Mark' only, Lname='Giuliano' only, both, and neither.
-- 2. Swapped column checks (e.g., Fname='Giuliano' or Lname='Mark').
-- 3. INNER JOIN vs LEFT/RIGHT JOIN (unmatched Faculty, unmatched Activity).
-- 4. COUNT(*) vs COUNT(DISTINCT facid) vs COUNT(DISTINCT actid).
-- 5. GROUP BY sex with multiple groups ('F' -> count 3, 'M' -> count 2) where natural group order ('F', 'M') has descending counts (3, 2) to strictly test ORDER BY count___ ASC (2, 3).
-- 6. Confounding rows in Student and Participates_in to catch queries using the wrong tables.
INSERT INTO "Activity" ("actid", "activity_name") VALUES (101, 'Debate');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (102, 'Chess');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (103, 'Music');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'Smith', 'Mark', 'Prof', 'F', 1111, '10A', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (2, 'Giuliano', 'Anna', 'Assoc', 'F', 2222, '10B', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (3, 'Giuliano', 'Mark', 'Asst', 'M', 3333, '10C', 'Sci');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (4, 'Giuliano', 'Bob', 'Prof', 'M', 4444, '10D', 'Sci');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (5, 'Doe', 'Jane', 'Inst', 'F', 5555, '10E', 'Art');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (6, 'Mark', 'Giuliano', 'Prof', 'M', 6666, '10F', 'Art');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (7, 'Brown', 'Mark', 'Prof', 'M', 7777, '10G', 'Main');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (101, 1);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (102, 1);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (101, 2);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (101, 3);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (102, 4);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (101, 5);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (102, 6);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Giuliano', 'Mark', 20, 'M', 10, 1, 'NYC');
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (101, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "sex", COUNT(*) AS "n" FROM (SELECT "LHS"."facid" AS "facid", "LHS"."actid" AS "actid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."rank" AS "rank", "RHS"."sex" AS "sex", "RHS"."phone" AS "phone", "RHS"."room" AS "room", "RHS"."building" AS "building" FROM "faculty_participates_in" AS "LHS" INNER JOIN (SELECT * FROM "faculty" WHERE ("fname" = 'Mark' OR "lname" = 'Giuliano')) AS RHS ON (LHS.facid = RHS.facid)) GROUP BY sex) ORDER BY count___;

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID WHERE T1.fname = 'Mark' AND T1.lname = 'Giuliano';

/*
Prediction Result:
(1,)
*/