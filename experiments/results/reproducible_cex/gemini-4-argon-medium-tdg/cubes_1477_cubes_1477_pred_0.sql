-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

CREATE TABLE "Department" ("DNO" INTEGER PRIMARY KEY, "Division" TEXT(2), "DName" TEXT(25), "Room" TEXT(5), "Building" TEXT(13), "DPhone" INTEGER);

CREATE TABLE "Member_of" ("DNO" INTEGER, "FacID" INTEGER, "Appt_Type" TEXT(15), FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Course" ("CID" TEXT(7) PRIMARY KEY, "DNO" INTEGER, "Instructor" INTEGER, "CName" TEXT(40), "Credits" INTEGER, "Days" TEXT(5), "Hours" TEXT(11), FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("Instructor") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Minor_in" ("DNO" INTEGER, "StuID" INTEGER, FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Enrolled_in" ("Grade" TEXT(2), "CID" TEXT(7), "StuID" INTEGER, FOREIGN KEY ("Grade") REFERENCES "Gradeconversion" ("lettergrade"), FOREIGN KEY ("CID") REFERENCES "Course" ("CID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Gradeconversion" ("lettergrade" TEXT(2) PRIMARY KEY, "gradepoint" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (1, 'EN', 'Computer Science', '101', 'Tech', 1111);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (2, 'AS', 'Mathematics', '202', 'Sci', 2222);
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (10, 'Zeta', 'Alice', 'Prof', 'F', 1234, '10A', 'Tech');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (20, 'Alpha', 'Bob', 'Assoc', 'M', 5678, '20B', 'Sci');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (30, 'Beta', 'Charlie', 'Asst', 'M', 9012, '30C', 'Tech');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (40, 'Omega', 'David', 'Inst', 'M', 3456, '40D', 'Eng');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (1, 10, 'Primary');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (1, 20, 'Secondary');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (2, 30, 'Primary');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS101', 1, 30, 'Intro to CS', 4, 'MWF', '10:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('MA101', 2, 10, 'Calculus', 4, 'TTH', '11:00');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (100, 'StudentCS', 'John', 20, 'M', 1, 30, 'NYC');
INSERT INTO "Minor_in" ("DNO", "StuID") VALUES (1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM (SELECT "LHS"."facid" AS "facid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."rank" AS "rank", "LHS"."sex" AS "sex", "LHS"."phone" AS "phone", "LHS"."room" AS "room", "LHS"."building" AS "building", "RHS"."dno" AS "dno", "RHS"."division" AS "division", "RHS"."dname" AS "dname", "RHS"."room" AS "room_other", "RHS"."building" AS "building_other", "RHS"."dphone" AS "dphone", "RHS"."appt_type" AS "appt_type" FROM "faculty" AS "LHS" INNER JOIN (SELECT "LHS"."dno" AS "dno", "LHS"."division" AS "division", "LHS"."dname" AS "dname", "LHS"."room" AS "room", "LHS"."building" AS "building", "LHS"."dphone" AS "dphone", "LHS"."facid" AS "facid", "LHS"."appt_type" AS "appt_type" FROM (SELECT "LHS"."dno" AS "dno", "LHS"."division" AS "division", "LHS"."dname" AS "dname", "LHS"."room" AS "room", "LHS"."building" AS "building", "LHS"."dphone" AS "dphone", "RHS"."facid" AS "facid", "RHS"."appt_type" AS "appt_type" FROM "department" AS "LHS" INNER JOIN "member_of" AS "RHS" ON ("LHS"."dno" = "RHS"."dno")) AS "LHS" INNER JOIN (SELECT * FROM "department" WHERE ("dname" = 'Computer Science')) AS RHS ON (LHS.dno = RHS.dno AND LHS.division = RHS.division AND LHS.dname = RHS.dname AND LHS.room = RHS.room AND LHS.building = RHS.building AND LHS.dphone = RHS.dphone)) AS RHS ON (LHS.facid = RHS.facid)) ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.Lname FROM DEPARTMENT AS T1 JOIN FACULTY AS T2 ON T1.DNO = T3.DNO JOIN MEMBER_OF AS T3 ON T2.FacID = T3.FacID WHERE T1.DName = 'Computer Science';

/*
Prediction Result:
('Zeta',)
('Alpha',)
*/