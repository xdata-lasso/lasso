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
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (10, 'EN', 'Computer Science', '101', 'Gates', 1111);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (20, 'AS', 'Mathematics', '202', 'Hilbert', 2222);
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (30, 'EN', 'Electrical Eng', '303', 'Maxwell', 3333);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (10, 'Smith', 'Alan', 'Professor', 'M', 5001, '10A', 'Gates');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (20, 'Jones', 'Grace', 'Assoc Prof', 'F', 5002, '20B', 'Hilbert');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (30, 'Lee', 'acob', 'Asst Prof', 'M', 5003, '30C', 'Maxwell');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (30, 10, 'Primary');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (10, 10, 'Joint');
INSERT INTO Member_of (DNO, FacID, Appt_Type) VALUES (10, 20, 'Primary');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Brown', 'Alice', 20, 'F', 10, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Green', 'Bob', 22, 'M', 20, 20, 'LAX');
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('A', 4.0);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('B', 3.0);
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('CS202', 30, 10, 'Networks', 4, 'MWF', '08:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('CS101', 20, 30, 'Algorithms', 3, 'TTH', '13:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('CS303', 10, 20, 'Databases', 1, 'F', '10:00');
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'CS101', 1001);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'CS101', 1002);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'CS202', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cid, cname, credits, instructor, days, hours, dno FROM course ORDER BY cid;

/*
Gold Result:
('CS101', 'Algorithms', 3, 30, 'TTH', '13:00', 20)
('CS202', 'Networks', 4, 10, 'MWF', '08:00', 30)
('CS303', 'Databases', 1, 20, 'F', '10:00', 10)
*/

-- Prediction Query
SELECT * FROM COURSE ORDER BY Credits, COURSE.cid NULLS LAST;

/*
Prediction Result:
('CS303', 10, 20, 'Databases', 1, 'F', '10:00')
('CS101', 20, 30, 'Algorithms', 3, 'TTH', '13:00')
('CS202', 30, 10, 'Networks', 4, 'MWF', '08:00')
*/