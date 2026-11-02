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
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (1, 'AS', 'CS', '101', 'Main', 1234);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Smith', 'Zack', 'Prof', 'M', 1111, '101', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Jones', 'Alice', 'Prof', 'F', 2222, '102', 'Main');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C1', 1, 1, 'COMPUTER LITERACY', 3, 'MWF', '9:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C2', 1, 2, 'COMPUTER LITERACY', 3, 'MWF', '10:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."facid" AS "facid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."rank" AS "rank", "LHS"."sex" AS "sex", "LHS"."phone" AS "phone", "LHS"."room" AS "room", "LHS"."building" AS "building", "RHS"."cid" AS "cid", "RHS"."cname" AS "cname", "RHS"."credits" AS "credits", "RHS"."days" AS "days", "RHS"."hours" AS "hours", "RHS"."dno" AS "dno" FROM "faculty" AS "LHS" INNER JOIN (SELECT * FROM "course" WHERE ("cname" = 'COMPUTER LITERACY')) AS RHS ON (LHS.facid = RHS.instructor)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('Alice', 'Jones')
('Zack', 'Smith')
*/

-- Prediction Query
SELECT T2.Fname, T2.Lname FROM COURSE AS T1 JOIN FACULTY AS T2 ON T1.Instructor = T2.FacID WHERE T1.CName = 'COMPUTER LITERACY';

/*
Prediction Result:
('Zack', 'Smith')
('Alice', 'Jones')
*/