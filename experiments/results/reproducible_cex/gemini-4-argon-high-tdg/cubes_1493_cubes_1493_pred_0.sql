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
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Smith', 'John', 'Professor', 'M', 1111, '300', 'NEB');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Jones', 'Alice', 'Professor', 'F', 2222, '100', 'NEB');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (3, 'Adams', 'Bob', 'Professor', 'M', 3333, '100', 'NEB');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (4, 'Brown', 'Charlie', 'Professor', 'M', 4444, '200', 'Barton');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (5, 'Davis', 'Eve', 'Assoc Professor', 'F', 5555, '400', 'NEB');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (6, 'Wilson', 'Frank', 'Instructor', 'M', 6666, '500', 'Barton');
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (10, 'EN', 'Computer Science', '999', 'NEB', 9000);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (20, 'AS', 'History', '888', 'Barton', 8000);
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (10, 1, 'Primary');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (20, 1, 'Joint');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (10, 5, 'Primary');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('CS101', 10, 1, 'Intro to CS', 3, 'MWF', '10:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('CS102', 10, 1, 'Algorithms', 4, 'TR', '14:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "room" FROM "faculty" WHERE ("rank" = 'Professor' AND "building" = 'NEB') ORDER BY room, faculty.facid NULLS LAST;

/*
Gold Result:
('100',)
('100',)
('300',)
*/

-- Prediction Query
SELECT Room FROM FACULTY WHERE Rank = 'Professor' AND Building = 'NEB';

/*
Prediction Result:
('300',)
('100',)
('100',)
*/