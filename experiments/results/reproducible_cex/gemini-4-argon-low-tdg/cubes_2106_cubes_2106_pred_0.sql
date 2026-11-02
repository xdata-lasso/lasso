-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 100, 1121, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 100, 1121, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Bob', 22, 'M', 200, 1120, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Green', 'Alice', 19, 'F', 300, 1122, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'White', 'Tom', 23, 'M', 400, NULL, 'SEA');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (10, 'Zeta Club', 'Desc Z', 'Loc 1');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (20, 'Alpha Club', 'Desc A', 'Loc 2');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (30, 'Beta Club', 'Desc B', 'Loc 3');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 1, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (20, 1, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (20, 2, 'Secretary');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (30, 3, 'Treasurer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clubname FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, LHS.clubid AS clubid, LHS.clubname AS clubname, LHS.clubdesc AS clubdesc, LHS.clublocation AS clublocation, RHS.position AS POSITION FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.clubid AS clubid, RHS.clubname AS clubname, RHS.clubdesc AS clubdesc, RHS.clublocation AS clublocation FROM student AS LHS CROSS JOIN club AS RHS) AS LHS INNER JOIN member_of_club AS RHS ON (LHS.stuid = RHS.stuid AND LHS.clubid = RHS.clubid)) WHERE (advisor = 1121) ORDER BY clubname;

/*
Gold Result:
('Alpha Club',)
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