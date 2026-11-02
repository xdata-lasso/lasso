-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'Kim', 'Tracy', 1, 'stu_1b7687', 1, 1, 'stu_c9bd1b');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'Kim', 'Tracy', 1, 'stu_02e990', 1, 1, 'stu_78ba95');

-- Inserting into table: club --
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1, 'rhs_28cb71', 'rhs_b4d7bb', 'rhs_69435f');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (-2147483647, 'rhs_26e67a', 'rhs_047fd1', 'rhs_e3172e');

-- Inserting into table: member_of_club --
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_447b8d');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, NULL);

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_fbe2e2');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_fbe2e2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT COUNT(DISTINCT "fname") AS "n_distinct" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "LHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."clubid" AS "clubid", "RHS"."clubname" AS "clubname", "RHS"."clubdesc" AS "clubdesc", "RHS"."clublocation" AS "clublocation" FROM "student" AS "LHS" CROSS JOIN "club" AS "RHS") AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."clubid" = "RHS"."clubid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("fname" = 'Tracy' AND "lname" = 'Kim')) AS RHS ON (LHS.stuid = RHS.stuid AND LHS.lname = RHS.lname AND LHS.fname = RHS.fname AND LHS.age = RHS.age AND LHS.sex = RHS.sex AND LHS.major = RHS.major AND LHS.advisor = RHS.advisor AND LHS.city_code = RHS.city_code))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t3.fname = 'Tracy' AND t3.lname = 'Kim';

/*
Prediction Result:
(17,)
*/