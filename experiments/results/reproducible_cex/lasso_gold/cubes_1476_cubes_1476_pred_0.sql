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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1028, 'hospital', 'Michael Miles', 'election', 'Mergenthaler', 1029);
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1030, 'raise', 'James Mayo', 'result', 'Mergenthaler', 1030);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dname" FROM "department" WHERE ("building" = 'Mergenthaler') ORDER BY dname, department.dno NULLS LAST;

/*
Gold Result:
('James Mayo',)
('Michael Miles',)
*/

-- Prediction Query
SELECT DName FROM DEPARTMENT WHERE Building = 'Mergenthaler';

/*
Prediction Result:
('Michael Miles',)
('James Mayo',)
*/