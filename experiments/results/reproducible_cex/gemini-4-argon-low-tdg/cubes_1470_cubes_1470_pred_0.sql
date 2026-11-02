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
-- Tests exact boundary conditions for n >= 5 (n=0, n=4, n=5, n=6) and ORDER BY cname vs CID order
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (10, 'EN', 'Computer Science', '101', 'Gates', 5550100);
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (100, 'Turing', 'Alan', 'Professor', 'M', 5550101, '102', 'Gates');
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('A', 4.0);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'S1', 'F1', 20, 'M', 10, 100, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'S2', 'F2', 20, 'F', 10, 100, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'S3', 'F3', 20, 'M', 10, 100, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'S4', 'F4', 20, 'F', 10, 100, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'S5', 'F5', 20, 'M', 10, 100, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'S6', 'F6', 20, 'F', 10, 100, 'NYC');
-- C1: 5 enrollments, CName 'Zoology' (tests n=5 boundary and reverse alphabetical order vs CID)
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C1', 10, 100, 'Zoology', 3, 'MWF', '10:00');
-- C2: 4 enrollments, CName 'Biology' (tests n=4 boundary)
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C2', 10, 100, 'Biology', 3, 'MWF', '11:00');
-- C3: 6 enrollments, CName 'Algorithms' (tests n=6 boundary and sorting before 'Zoology')
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C3', 10, 100, 'Algorithms', 4, 'TTh', '09:00');
-- C4: 0 enrollments, CName 'Calculus' (tests INNER JOIN vs RIGHT/OUTER JOIN)
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('C4', 10, 100, 'Calculus', 4, 'TTh', '14:00');
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C1', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C1', 2);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C1', 3);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C1', 4);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C1', 5);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C2', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C2', 2);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C2', 3);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C2', 4);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C3', 1);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C3', 2);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C3', 3);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C3', 4);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C3', 5);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'C3', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname FROM (SELECT LHS.cid AS cid, LHS.n AS n, RHS.cname AS cname, RHS.credits AS credits, RHS.instructor AS instructor, RHS.days AS days, RHS.hours AS hours, RHS.dno AS dno FROM (SELECT * FROM (SELECT cid, COUNT(*) AS n FROM enrolled_in GROUP BY cid) WHERE (n >= 5)) AS LHS INNER JOIN course AS RHS ON (LHS.cid = RHS.cid)) ORDER BY cname;

/*
Gold Result:
('Algorithms',)
('Zoology',)
*/

-- Prediction Query
SELECT T1.CName FROM COURSE AS T1 JOIN ENROLLED_IN AS T2 ON T1.CID = T2.CID GROUP BY T2.CID HAVING COUNT(*) >= 5;

/*
Prediction Result:
('Zoology',)
('Algorithms',)
*/