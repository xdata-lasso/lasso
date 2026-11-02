-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests predicate boundary conditions ('Canoeing', 'Kayaking', other, and NULL), OR vs AND logic, and duplicate elimination via DISTINCT.
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Canoeing');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (2, 'Kayaking');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (3, 'Hiking');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (4, NULL);
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (101, 'Adams', 'John', 'Prof', 'M', 1111, '101', 'Sci');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (102, 'Baker', 'Jane', 'Assoc', 'F', 2222, '102', 'Arts');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (103, 'Clark', 'Bob', 'Asst', 'M', 3333, '103', 'Eng');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (104, 'Davis', 'Eve', 'Prof', 'F', 4444, '104', 'Sci');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (105, 'Adams', 'Sam', 'Inst', 'M', 5555, '105', 'Math');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 101);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (3, 101);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (2, 102);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (3, 103);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (4, 104);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 105);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "lname" FROM (SELECT "LHS"."actid" AS "actid", "LHS"."activity_name" AS "activity_name", "LHS"."facid" AS "facid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."rank" AS "rank", "RHS"."sex" AS "sex", "RHS"."phone" AS "phone", "RHS"."room" AS "room", "RHS"."building" AS "building" FROM (SELECT "LHS"."actid" AS "actid", "LHS"."activity_name" AS "activity_name", "RHS"."facid" AS "facid" FROM "activity" AS "LHS" INNER JOIN "faculty_participates_in" AS "RHS" ON ("LHS"."actid" = "RHS"."actid")) AS "LHS" INNER JOIN "faculty" AS "RHS" ON ("LHS"."facid" = "RHS"."facid")) WHERE ("activity_name" = 'Canoeing' OR "activity_name" <> 'Kayaking') ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('Adams',)
('Clark',)
*/

-- Prediction Query
SELECT T1.lname FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID JOIN activity AS T3 ON T2.actid = T2.actid WHERE T3.activity_name = 'Canoeing' INTERSECT SELECT T1.lname FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID JOIN activity AS T3 ON T2.actid = T2.actid WHERE T3.activity_name = 'Kayaking';

/*
Prediction Result:
('Adams',)
('Baker',)
('Clark',)
('Davis',)
*/