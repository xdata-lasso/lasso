-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Activity" ("actid", "activity_name") VALUES (101, 'Chess Club');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (102, 'Debate');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (103, 'Robotics');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'Smith', 'Mark', 'Professor', 'M', 1111, '10A', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (2, 'Giuliano', 'Anna', 'Assoc Prof', 'F', 2222, '20B', 'Science');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (3, 'Giuliano', 'Mark', 'Instructor', 'M', 3333, '30C', 'Arts');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (4, 'Doe', 'John', 'Professor', 'M', 4444, '40D', 'Eng');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (5, 'Giuliano', 'Sara', 'Asst Prof', 'F', 5555, '50E', 'Sci');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (101, 1);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (102, 1);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (101, 2);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (103, 3);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (101, 4);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (102, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "sex", COUNT(*) AS "n" FROM (SELECT "LHS"."facid" AS "facid", "LHS"."actid" AS "actid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."rank" AS "rank", "RHS"."sex" AS "sex", "RHS"."phone" AS "phone", "RHS"."room" AS "room", "RHS"."building" AS "building" FROM "faculty_participates_in" AS "LHS" INNER JOIN (SELECT * FROM "faculty" WHERE ("fname" = 'Mark' OR "lname" = 'Giuliano')) AS RHS ON (LHS.facid = RHS.facid)) GROUP BY sex) ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID WHERE T1.fname = 'Mark' AND T1.lname = 'Giuliano';

/*
Prediction Result:
(1,)
*/