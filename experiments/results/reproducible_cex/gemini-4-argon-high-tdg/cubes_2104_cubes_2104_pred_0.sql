-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Doe', 'Jane', 21, 'F', 600, 1121, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (103, 'Brown', 'Bob', 22, 'M', 550, 1148, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (104, 'Taylor', 'Ann', 19, 'F', 520, 1148, 'BAL');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (1, 'Zeta Chess', 'Chess enthusiasts', 'Room 101');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (2, 'Alpha Robotics', 'Robotics team', 'Lab 3');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (3, 'Beta Drama', 'Theater group', 'Hall B');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (4, 'Omega Music', 'Band club', 'Studio 1');
INSERT INTO Member_of_club (ClubID, StuID, Position) VALUES (1, 101, 'President');
INSERT INTO Member_of_club (ClubID, StuID, Position) VALUES (2, 101, 'Member');
INSERT INTO Member_of_club (ClubID, StuID, Position) VALUES (2, 102, 'Treasurer');
INSERT INTO Member_of_club (ClubID, StuID, Position) VALUES (3, 103, 'President');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubname" FROM (SELECT "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "LHS"."stuid" AS "stuid", "LHS"."position" AS "position", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."stuid" AS "stuid", "RHS"."position" AS "position" FROM "club" AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."clubid" = "RHS"."clubid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("city_code" = 'BAL')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY clubname, "clubname" NULLS LAST;

/*
Gold Result:
('Alpha Robotics',)
('Alpha Robotics',)
('Zeta Chess',)
*/

-- Prediction Query
SELECT DISTINCT t1.clubname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t3.city_code = 'BAL';

/*
Prediction Result:
('Zeta Chess',)
('Alpha Robotics',)
*/