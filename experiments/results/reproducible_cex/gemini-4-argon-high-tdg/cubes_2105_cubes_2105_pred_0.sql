-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Adams', 'Zoe', 22, 'F', 100, 10, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Baker', 'Alice', 19, 'F', 200, 20, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Clark', 'Bob', 25, 'M', 300, 30, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Davis', 'Alice', 20, 'M', 400, 40, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Adams', 'Charlie', 22, 'F', 100, 10, 'NYC');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (10, 'Chess Club', 'Strategy board games', 'Room 101');
INSERT INTO Member_of_club (ClubID, StuID, Position) VALUES (10, 3, 'President');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT fname FROM student ORDER BY fname;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
('Zoe',)
*/

-- Prediction Query
SELECT DISTINCT fname FROM student;

/*
Prediction Result:
('Zoe',)
('Alice',)
('Bob',)
('Charlie',)
*/