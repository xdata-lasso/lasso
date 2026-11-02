-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (actid, activity_name) VALUES (1, 'Chess');
INSERT INTO Activity (actid, activity_name) VALUES (2, 'Debate');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Smith', 'Clara', 'Professor', 'F', 1111, '101A', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Jones', 'Alice', 'Assoc Prof', 'F', 2222, '202B', 'Arts');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (3, 'Brown', 'Brenda', 'Asst Prof', 'F', 3333, '303C', 'Engineering');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (4, 'Davis', 'David', 'Professor', 'M', 4444, '404D', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (5, 'Evans', 'Eve', 'Instructor', 'f', 5555, '505E', 'Arts');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (6, 'Frank', 'Fiona', 'Instructor', NULL, 6666, '606F', 'Arts');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Green', 'Grace', 20, 'F', 10, 1, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Hall', 'Henry', 21, 'M', 20, 1, 'LAX');
INSERT INTO Participates_in (actid, stuid) VALUES (1, 101);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (1, 1);
INSERT INTO Faculty_Participates_in (actid, FacID) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname", "phone" FROM "faculty" WHERE ("sex" = 'F') ORDER BY fname, faculty.facid NULLS LAST;

/*
Gold Result:
('Alice', 'Jones', 2222)
('Brenda', 'Brown', 3333)
('Clara', 'Smith', 1111)
*/

-- Prediction Query
SELECT Fname, Lname, phone FROM Faculty WHERE Sex = 'F';

/*
Prediction Result:
('Clara', 'Smith', 1111)
('Alice', 'Jones', 2222)
('Brenda', 'Brown', 3333)
*/