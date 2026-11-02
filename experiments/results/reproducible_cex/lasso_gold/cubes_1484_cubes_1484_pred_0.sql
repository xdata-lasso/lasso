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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1011, 'husband', 'Ryan Munoz', 'surface', 'animal', 1012);
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1016, 'sea', 'Matthew Mejia', 'base', 'top', 1017);
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1013, 'Blair', 'Amanda', 'win', 'human', 1014, 'bar', 'old');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1018, 'Hall', 'Craig', 'fall', 'long', 1019, 'prove', 'they');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('finally', 1011, 1013, 'Lisa Hensley', 1015, 'participant', 'dark');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('his', 1016, 1018, 'Andrea Reid', 1016, 'science', 'write');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname FROM course ORDER BY cname, course.cid NULLS LAST;

/*
Gold Result:
('Andrea Reid',)
('Lisa Hensley',)
*/

-- Prediction Query
SELECT CName FROM COURSE ORDER BY Credits, COURSE.cid NULLS LAST;

/*
Prediction Result:
('Lisa Hensley',)
('Andrea Reid',)
*/