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
INSERT INTO Department (DNO, Division, DName, Room, Building, DPhone) VALUES (10, 'EN', 'Computer Science', '101', 'Gates', 1234);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (101, 'Smith', 'Alan', 'Prof', 'M', 5551, '201', 'Gates');
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('A', 4.0);
INSERT INTO Gradeconversion (lettergrade, gradepoint) VALUES ('B', 3.0);
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Adams', 'Amy', 20, 'F', 10, 101, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Baker', 'Bob', 21, 'M', 10, 101, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Clark', 'Cara', 19, 'F', 10, 101, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Davis', 'Dan', 22, 'M', 10, 101, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Evans', 'Eva', 20, 'F', 10, 101, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Frank', 'Fred', 23, 'M', 10, 101, 'MIA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Green', 'Gina', 21, 'F', 10, 101, 'DEN');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C200', 10, 101, 'Databases', 2, 'MWF', '10:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C100', 10, 101, 'Compilers', 4, 'TTH', '11:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C300', 10, 101, 'Algorithms', 3, 'MWF', '09:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C400', 10, 101, 'Networks', 5, 'TTH', '14:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C500', 10, 101, 'Operating Systems', 6, 'MWF', '13:00');
INSERT INTO Course (CID, DNO, Instructor, CName, Credits, Days, Hours) VALUES ('C600', 10, 101, 'Robotics', 5, 'F', '15:00');
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C200', 1);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C200', 2);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C200', 3);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C200', 4);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C200', 5);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C100', 1);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C100', 2);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C100', 3);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C100', 4);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C100', 5);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C100', 6);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C100', 7);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C300', 1);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C300', 2);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C300', 3);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C300', 4);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C300', 5);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C300', 6);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C400', 1);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C400', 2);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C400', 3);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('B', 'C400', 4);
INSERT INTO Enrolled_in (Grade, CID, StuID) VALUES ('A', 'C500', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname FROM (SELECT LHS.cid AS cid, LHS.n AS n, RHS.cname AS cname, RHS.credits AS credits, RHS.instructor AS instructor, RHS.days AS days, RHS.hours AS hours, RHS.dno AS dno FROM (SELECT * FROM (SELECT cid, COUNT(*) AS n FROM enrolled_in GROUP BY cid) WHERE (n >= 5)) AS LHS INNER JOIN course AS RHS ON (LHS.cid = RHS.cid)) ORDER BY cname;

/*
Gold Result:
('Algorithms',)
('Compilers',)
('Databases',)
*/

-- Prediction Query
SELECT T1.CName FROM COURSE AS T1 JOIN ENROLLED_IN AS T2 ON T1.CID = T2.CID GROUP BY T2.CID HAVING COUNT(*) >= 5;

/*
Prediction Result:
('Compilers',)
('Databases',)
('Algorithms',)
*/