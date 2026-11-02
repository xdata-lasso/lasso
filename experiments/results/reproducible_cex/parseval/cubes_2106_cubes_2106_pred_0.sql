-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'lhs_70ad88', 'lhs_e30bbb', 1, 'lhs_7a1da0', 1, 1121, 'lhs_6dfc80');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'lhs_0554b0', 'lhs_0f1d7e', 1, 'lhs_23151d', 1, 1121, 'lhs_f41863');

-- Inserting into table: club --
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1, 'rhs_9282b4', 'rhs_448150', 'rhs_f4af0b');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (-2147483647, 'rhs_c990f8', 'rhs_db8c6f', 'rhs_39f2ef');

-- Inserting into table: member_of_club --
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_f504fb');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, NULL);

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_e8735d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_e8735d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clubname FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, LHS.clubid AS clubid, LHS.clubname AS clubname, LHS.clubdesc AS clubdesc, LHS.clublocation AS clublocation, RHS.position AS POSITION FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.clubid AS clubid, RHS.clubname AS clubname, RHS.clubdesc AS clubdesc, RHS.clublocation AS clublocation FROM student AS LHS CROSS JOIN club AS RHS) AS LHS INNER JOIN member_of_club AS RHS ON (LHS.stuid = RHS.stuid AND LHS.clubid = RHS.clubid)) WHERE (advisor = 1121) ORDER BY clubname;

/*
Gold Result:
('rhs_9282b4',)
('rhs_9282b4',)
('rhs_9282b4',)
('rhs_9282b4',)
('rhs_9282b4',)
('rhs_9282b4',)
('rhs_9282b4',)
('rhs_c990f8',)
('rhs_c990f8',)
('rhs_c990f8',)
('rhs_c990f8',)
('rhs_c990f8',)
('rhs_c990f8',)
('rhs_c990f8',)
('rhs_c990f8',)
*/

-- Prediction Query
SELECT DISTINCT t1.clubname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t3.advisor = 1121;

/*
Prediction Result:
('rhs_9282b4',)
('rhs_c990f8',)
*/