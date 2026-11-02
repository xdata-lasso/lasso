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
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (10, 'EN', 'Computer Science', '101', 'Gates', 1111);
INSERT INTO "Department" ("DNO", "Division", "DName", "Room", "Building", "DPhone") VALUES (20, 'AS', 'Mathematics', '202', 'Hilbert', 2222);
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (101, 'Smith', 'Alan', 'Professor', 'M', 5551, '301', 'Gates');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (102, 'Jones', 'Ada', 'Associate', 'F', 5552, '205', 'Hilbert');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Brown', 'Charlie', 20, 'M', 10, 101, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1002, 'Davis', 'Diana', 21, 'F', 20, 102, 'BOS');
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('A', 4.0);
INSERT INTO "Gradeconversion" ("lettergrade", "gradepoint") VALUES ('B', 3.0);
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (10, 101, 'Primary');
INSERT INTO "Member_of" ("DNO", "FacID", "Appt_Type") VALUES (20, 102, 'Primary');
INSERT INTO "Minor_in" ("DNO", "StuID") VALUES (20, 1001);
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS101', 10, 101, 'Physics', 4, 'MTW', '09:00-10:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS102', 10, 101, 'Algorithms', 3, 'MTW', '10:00-11:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('MA201', 20, 102, 'Zoology', 3, 'MTW', '11:00-12:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('MA202', 20, 102, 'Calculus', 4, 'MTW', '13:00-14:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS103', 10, 101, 'Algorithms', 3, 'MTW', '14:00-15:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS104', 10, 101, 'Databases', 3, 'MWF', '09:00-10:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('CS105', 10, 101, 'Networks', 3, 'MTWF', '10:00-11:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('MA203', 20, 102, 'Geometry', 3, 'mtw', '15:00-16:00');
INSERT INTO "Course" ("CID", "DNO", "Instructor", "CName", "Credits", "Days", "Hours") VALUES ('MA204', 20, 102, 'Topology', 3, NULL, '16:00-17:00');
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS101', 1001);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('B', 'CS101', 1002);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS102', 1001);
INSERT INTO "Enrolled_in" ("Grade", "CID", "StuID") VALUES ('A', 'CS104', 1002);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM "course" WHERE ("days" = 'MTW') ORDER BY cname, course.cid NULLS LAST;

/*
Gold Result:
('Algorithms',)
('Algorithms',)
('Calculus',)
('Physics',)
('Zoology',)
*/

-- Prediction Query
SELECT CName FROM COURSE WHERE Days = 'MTW';

/*
Prediction Result:
('Physics',)
('Algorithms',)
('Zoology',)
('Calculus',)
('Algorithms',)
*/