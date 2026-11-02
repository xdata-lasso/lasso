-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("actid", "activity_name") VALUES (1071, 'Thomas Harrell');
INSERT INTO "activity" ("actid", "activity_name") VALUES (1077, 'Linda Burns');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1072, 'Giuliano', 'Mark', 'fire', 'thought', 1073, 'purpose', 'movement');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1078, 'Giuliano', 'Mark', 'brother', 'woman', 1079, 'him', 'unit');
INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1071, 1072);
INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1071, 1072);
INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1077, 1078);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "activity_name" FROM (SELECT "LHS"."actid" AS "actid", "LHS"."activity_name" AS "activity_name", "LHS"."facid" AS "facid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."rank" AS "rank", "RHS"."sex" AS "sex", "RHS"."phone" AS "phone", "RHS"."room" AS "room", "RHS"."building" AS "building" FROM (SELECT "LHS"."actid" AS "actid", "LHS"."activity_name" AS "activity_name", "RHS"."facid" AS "facid" FROM "activity" AS "LHS" INNER JOIN "faculty_participates_in" AS "RHS" ON ("LHS"."actid" = "RHS"."actid")) AS "LHS" INNER JOIN (SELECT * FROM "faculty" WHERE ("fname" = 'Mark' AND "lname" = 'Giuliano')) AS RHS ON (LHS.facid = RHS.facid)) ORDER BY activity_name, "activity_name" NULLS LAST;

/*
Gold Result:
('Linda Burns',)
('Thomas Harrell',)
('Thomas Harrell',)
*/

-- Prediction Query
SELECT T3.activity_name FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID JOIN Activity AS T3 ON T3.actid = T2.actid WHERE T1.fname = 'Mark' AND T1.lname = 'Giuliano';

/*
Prediction Result:
('Thomas Harrell',)
('Thomas Harrell',)
('Linda Burns',)
*/