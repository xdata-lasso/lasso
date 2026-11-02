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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1011, 'best', 'Ian Cooper', 'everything', 'surface', 1012);
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1016, 'dark', 'Amber Perez', 'figure', 'base', 1017);
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1013, 'Williams', 'Stephen', 'capital', 'win', 1014, 'human', 'bar');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1018, 'Wyatt', 'Michelle', 'husband', 'fall', 1019, 'long', 'prove');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('they', 1011, 1013, 'Jacob Clark', 1015, 'example', 'participant');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('old', 1016, 1018, 'Mark Mcclure', 1016, 'high', 'science');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cid, cname, credits, instructor, days, hours, dno FROM course ORDER BY cid;

/*
Gold Result:
('old', 'Mark Mcclure', 1016, 1018, 'high', 'science', 1016)
('they', 'Jacob Clark', 1015, 1013, 'example', 'participant', 1011)
*/

-- Prediction Query
SELECT * FROM COURSE ORDER BY Credits, COURSE.cid NULLS LAST;

/*
Prediction Result:
('they', 1011, 1013, 'Jacob Clark', 1015, 'example', 'participant')
('old', 1016, 1018, 'Mark Mcclure', 1016, 'high', 'science')
*/