-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1032, 'Danielle Lee', 'list', '7317 Brent Plains
North Sarabury, GA 53770');
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1036, 'Danielle Lee', 'list', '7317 Brent Plains
North Sarabury, GA 53770');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1033, 'Tucker', 'Jason', 1034, 'institution', 1035, 1121, 'East Nicholasfurt');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1037, 'Tucker', 'Jason', 1034, 'institution', 1035, 1121, 'East Nicholasfurt');
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1032, 1033, 'evidence');
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1036, 1037, 'evidence');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clubname FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, LHS.clubid AS clubid, LHS.clubname AS clubname, LHS.clubdesc AS clubdesc, LHS.clublocation AS clublocation, RHS.position AS POSITION FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.clubid AS clubid, RHS.clubname AS clubname, RHS.clubdesc AS clubdesc, RHS.clublocation AS clublocation FROM student AS LHS CROSS JOIN club AS RHS) AS LHS INNER JOIN member_of_club AS RHS ON (LHS.stuid = RHS.stuid AND LHS.clubid = RHS.clubid)) WHERE (advisor = 1121) ORDER BY clubname;

/*
Gold Result:
('Danielle Lee',)
('Danielle Lee',)
*/

-- Prediction Query
SELECT DISTINCT t1.clubname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t3.advisor = 1121;

/*
Prediction Result:
('Danielle Lee',)
*/