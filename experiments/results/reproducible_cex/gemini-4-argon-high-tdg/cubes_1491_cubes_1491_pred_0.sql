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
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (10, 'EN', 'Software Engineering', '301', 'Turing Hall', 1111);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (20, 'AS', 'Computer Science', '105', 'Gates Hall', 2222);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (30, 'AS', 'Mathematics', '210', 'Euler Bldg', 3333);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (40, 'EN', 'Robotics', '400', 'Babbage Hall', 4444);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (101, 'Smith', 'Alan', 'Professor', 'M', 5001, '999', 'Faculty Tower');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (102, 'Jones', 'Ada', 'Assoc Prof', 'F', 5002, '888', 'Admin Block');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (30, 101, 'Primary');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (40, 102, 'Primary');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('SE100', 10, 101, 'INTRODUCTION TO COMPUTER SCIENCE', 4, 'MWF', '10:00-11:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('CS100', 20, 102, 'INTRODUCTION TO COMPUTER SCIENCE', 3, 'TTH', '09:00-10:30');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('MA100', 30, 101, 'CALCULUS I', 4, 'MWF', '11:00-12:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dname", "room" FROM (SELECT "LHS"."dno" AS "dno", "LHS"."division" AS "division", "LHS"."dname" AS "dname", "LHS"."room" AS "room", "LHS"."building" AS "building", "LHS"."dphone" AS "dphone", "RHS"."cid" AS "cid", "RHS"."cname" AS "cname", "RHS"."credits" AS "credits", "RHS"."instructor" AS "instructor", "RHS"."days" AS "days", "RHS"."hours" AS "hours" FROM "department" AS "LHS" INNER JOIN "course" AS "RHS" ON ("LHS"."dno" = "RHS"."dno")) WHERE ("cname" = 'INTRODUCTION TO COMPUTER SCIENCE') ORDER BY dname, "dname" NULLS LAST, "room" NULLS LAST;

/*
Gold Result:
('Computer Science', '105')
('Software Engineering', '301')
*/

-- Prediction Query
SELECT T2.Dname, T2.Room FROM COURSE AS T1 JOIN DEPARTMENT AS T2 ON T1.DNO = T2.DNO WHERE T1.CName = 'INTRODUCTION TO COMPUTER SCIENCE';

/*
Prediction Result:
('Software Engineering', '301')
('Computer Science', '105')
*/