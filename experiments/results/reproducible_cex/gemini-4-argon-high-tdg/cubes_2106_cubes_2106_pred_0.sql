-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (10, 'Smith', 'John', 20, 'M', 200, 1121, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (20, 'Doe', 'Jane', 21, 'F', 300, 1121, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1121, 'Brown', 'Bob', 22, 'M', 1121, 1120, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (40, 'White', 'Alice', 19, 'F', 400, 1122, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (50, 'Green', 'Tom', 23, 'M', 500, NULL, 'SEA');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (1, 'Zeta Club', 'Desc A', 'Room 101');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (2, 'Alpha Club', 'Desc Z', 'Room 202');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (3, 'Beta Club', 'Desc B', 'Room 303');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (1121, 'Omega Club', 'Desc O', 'Room 404');
INSERT INTO Member_of_club (ClubID, StuID, Position) VALUES (1, 10, 'Member');
INSERT INTO Member_of_club (ClubID, StuID, Position) VALUES (2, 20, 'President');
INSERT INTO Member_of_club (ClubID, StuID, Position) VALUES (3, 1121, 'Treasurer');
INSERT INTO Member_of_club (ClubID, StuID, Position) VALUES (1121, 40, 'Secretary');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clubname FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, LHS.clubid AS clubid, LHS.clubname AS clubname, LHS.clubdesc AS clubdesc, LHS.clublocation AS clublocation, RHS.position AS POSITION FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.clubid AS clubid, RHS.clubname AS clubname, RHS.clubdesc AS clubdesc, RHS.clublocation AS clublocation FROM student AS LHS CROSS JOIN club AS RHS) AS LHS INNER JOIN member_of_club AS RHS ON (LHS.stuid = RHS.stuid AND LHS.clubid = RHS.clubid)) WHERE (advisor = 1121) ORDER BY clubname;

/*
Gold Result:
('Alpha Club',)
('Zeta Club',)
*/

-- Prediction Query
SELECT DISTINCT t1.clubname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t3.advisor = 1121;

/*
Prediction Result:
('Zeta Club',)
('Alpha Club',)
*/