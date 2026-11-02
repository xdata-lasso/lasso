-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Video_Games" ("GameID" INTEGER PRIMARY KEY, "GName" TEXT(40), "GType" TEXT(40));

CREATE TABLE "Plays_Games" ("StuID" INTEGER, "GameID" INTEGER, "Hours_Played" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("GameID") REFERENCES "Video_Games" ("GameID"));

CREATE TABLE "SportsInfo" ("StuID" INTEGER, "SportName" TEXT(32), "HoursPerWeek" INTEGER, "GamesPlayed" INTEGER, "OnScholarship" TEXT(1), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'Bob', 20, 'M', 600, 100, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Jones', 'Alice', 21, 'F', 600, 100, 'LAX');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname FROM student WHERE (major = 600) ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Fname FROM Student WHERE Major = 600;

/*
Prediction Result:
('Bob',)
('Alice',)
*/