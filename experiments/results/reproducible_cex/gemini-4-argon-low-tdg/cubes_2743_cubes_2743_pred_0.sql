-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Tennis');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (2, 'Chess');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (3, 'Swimming');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (4, 'Debate');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (5, 'Archery');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (10, 'Giuliano', 'Mark', 'Prof', 'M', 1111, '101', 'BldgA');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (20, 'Smith', 'Mark', 'Prof', 'M', 2222, '102', 'BldgB');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (30, 'Giuliano', 'John', 'Assoc', 'M', 3333, '103', 'BldgC');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (40, 'Doe', 'Jane', 'Asst', 'F', 4444, '104', 'BldgD');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 10);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (2, 10);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (3, 20);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (4, 30);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (5, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "activity_name" FROM (SELECT "LHS"."actid" AS "actid", "LHS"."activity_name" AS "activity_name", "LHS"."facid" AS "facid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."rank" AS "rank", "RHS"."sex" AS "sex", "RHS"."phone" AS "phone", "RHS"."room" AS "room", "RHS"."building" AS "building" FROM (SELECT "LHS"."actid" AS "actid", "LHS"."activity_name" AS "activity_name", "RHS"."facid" AS "facid" FROM "activity" AS "LHS" INNER JOIN "faculty_participates_in" AS "RHS" ON ("LHS"."actid" = "RHS"."actid")) AS "LHS" INNER JOIN (SELECT * FROM "faculty" WHERE ("fname" = 'Mark' AND "lname" = 'Giuliano')) AS RHS ON (LHS.facid = RHS.facid)) ORDER BY activity_name, "activity_name" NULLS LAST;

/*
Gold Result:
('Chess',)
('Tennis',)
*/

-- Prediction Query
SELECT T3.activity_name FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID JOIN Activity AS T3 ON T3.actid = T2.actid WHERE T1.fname = 'Mark' AND T1.lname = 'Giuliano';

/*
Prediction Result:
('Tennis',)
('Chess',)
*/