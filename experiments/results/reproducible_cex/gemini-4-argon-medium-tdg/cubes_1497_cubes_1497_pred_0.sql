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
-- Tests basic filtering on DNO = 520, boundary values (519, 521), unreferenced Faculty rows (kills RIGHT/FULL JOIN on Faculty), and ordering by fname then lname.
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (519, 'EN', 'CS', '101', 'B1', 1111);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (520, 'EN', 'Math', '102', 'B1', 2222);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (521, 'EN', 'Physics', '103', 'B1', 3333);
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'Zeta', 'Alice', 'Prof', 'F', 1001, '10A', 'B1');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (2, 'Alpha', 'Alice', 'Assoc', 'F', 1002, '10B', 'B1');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (3, 'Beta', 'Bob', 'Asst', 'M', 1003, '10C', 'B1');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (4, 'Gamma', 'Charlie', 'Prof', 'M', 1004, '10D', 'B1');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (5, 'Delta', 'David', 'Prof', 'M', 1005, '10E', 'B1');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (520, 1, 'Primary');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (520, 2, 'Secondary');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (520, 3, 'Primary');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (519, 4, 'Primary');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (521, 1, 'Secondary');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM (SELECT LHS.facid AS facid, LHS.dno AS dno, LHS.appt_type AS appt_type, RHS.lname AS lname, RHS.fname AS fname, RHS.rank AS rank, RHS.sex AS sex, RHS.phone AS phone, RHS.room AS room, RHS.building AS building FROM (SELECT * FROM member_of WHERE (dno = 520)) AS LHS LEFT JOIN faculty AS RHS ON (LHS.facid = RHS.facid)) ORDER BY fname, lname NULLS LAST;

/*
Gold Result:
('Alice', 'Alpha')
('Alice', 'Zeta')
('Bob', 'Beta')
*/

-- Prediction Query
SELECT T1.Fname, T1.Lname FROM FACULTY AS T1 JOIN MEMBER_OF AS T2 ON T1.FacID = T2.FacID WHERE T2.DNO = 520;

/*
Prediction Result:
('Alice', 'Zeta')
('Alice', 'Alpha')
('Bob', 'Beta')
*/