-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'lhs_e723bb', 'lhs_0e776f', 1, 'lhs_a7f963', 1, 1, 'lhs_56a564');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'lhs_625b31', 'lhs_165642', 1, 'lhs_6ae78d', 1, 1, 'lhs_67f2f7');

-- Inserting into table: club --
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1, 'AA', 'rhs_cce114', 'rhs_25f37c');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (-2147483647, 'AA', 'rhs_1eed4e', 'rhs_819d54');

-- Inserting into table: member_of_club --
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_05a3f8');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_51d7ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_05a3f8');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'CTO');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."clubid" AS "clubid", "RHS"."clubname" AS "clubname", "RHS"."clubdesc" AS "clubdesc", "RHS"."clublocation" AS "clublocation" FROM "student" AS "LHS" CROSS JOIN "club" AS "RHS") AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."clubid" = "RHS"."clubid")) WHERE ("clubname" = 'Hopkins Student Enterprises' OR "position" = 'CTO') ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('lhs_0e776f', 'lhs_e723bb')
('lhs_0e776f', 'lhs_e723bb')
('lhs_0e776f', 'lhs_e723bb')
('lhs_0e776f', 'lhs_e723bb')
('lhs_0e776f', 'lhs_e723bb')
('lhs_0e776f', 'lhs_e723bb')
('lhs_0e776f', 'lhs_e723bb')
('lhs_165642', 'lhs_625b31')
('lhs_165642', 'lhs_625b31')
('lhs_165642', 'lhs_625b31')
('lhs_165642', 'lhs_625b31')
*/

-- Prediction Query
SELECT t3.fname, t3.lname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t1.clubname = 'Hopkins Student Enterprises' AND t2.position = 'CTO';

/*
Prediction Result:
*/