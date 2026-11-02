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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1109, 'discussion', 'Computer Science', 'account', 'avoid', NULL);
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1111, 'Zimmerman', 'Brian', 'author', 'western', 1112, 'almost', 'trade');
INSERT INTO "member_of" ("dno", "facid", "appt_type") VALUES (1109, 1111, 'give');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM (SELECT "LHS"."facid" AS "facid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."rank" AS "rank", "LHS"."sex" AS "sex", "LHS"."phone" AS "phone", "LHS"."room" AS "room", "LHS"."building" AS "building", "RHS"."dno" AS "dno", "RHS"."division" AS "division", "RHS"."dname" AS "dname", "RHS"."room" AS "room_other", "RHS"."building" AS "building_other", "RHS"."dphone" AS "dphone", "RHS"."appt_type" AS "appt_type" FROM "faculty" AS "LHS" INNER JOIN (SELECT "LHS"."dno" AS "dno", "LHS"."division" AS "division", "LHS"."dname" AS "dname", "LHS"."room" AS "room", "LHS"."building" AS "building", "LHS"."dphone" AS "dphone", "LHS"."facid" AS "facid", "LHS"."appt_type" AS "appt_type" FROM (SELECT "LHS"."dno" AS "dno", "LHS"."division" AS "division", "LHS"."dname" AS "dname", "LHS"."room" AS "room", "LHS"."building" AS "building", "LHS"."dphone" AS "dphone", "RHS"."facid" AS "facid", "RHS"."appt_type" AS "appt_type" FROM "department" AS "LHS" INNER JOIN "member_of" AS "RHS" ON ("LHS"."dno" = "RHS"."dno")) AS "LHS" INNER JOIN (SELECT * FROM "department" WHERE ("dname" = 'Computer Science')) AS RHS ON (LHS.dno = RHS.dno AND LHS.division = RHS.division AND LHS.dname = RHS.dname AND LHS.room = RHS.room AND LHS.building = RHS.building AND LHS.dphone = RHS.dphone)) AS RHS ON (LHS.facid = RHS.facid)) ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Lname FROM DEPARTMENT AS T1 JOIN FACULTY AS T2 ON T1.DNO = T3.DNO JOIN MEMBER_OF AS T3 ON T2.FacID = T3.FacID WHERE T1.DName = 'Computer Science';

/*
Prediction Result:
('Zimmerman',)
*/