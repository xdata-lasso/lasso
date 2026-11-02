-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'lhs_cc3fd5', 'lhs_c3b28a', 1, 'lhs_45463d', 1, 1, 'lhs_8128ed');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'lhs_7466d5', 'lhs_89d2d1', 1, 'lhs_06fc61', 1, 1, 'lhs_0f102d');

-- Inserting into table: club --
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1, 'Tennis Club', 'clu_a1ee41', 'clu_719164');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (-2147483647, 'Tennis Club', 'clu_4beb2d', 'clu_9bb12d');

-- Inserting into table: member_of_club --
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_fa24be');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, 1, NULL);

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483647, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483647, -2147483647, 'rhs_a02c02');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_a02c02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanage" AS "avg_t3_age_" FROM (SELECT "clublocation", "position", AVG("age") AS "meanage" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "LHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."clubid" AS "clubid", "RHS"."clubname" AS "clubname", "RHS"."clubdesc" AS "clubdesc", "RHS"."clublocation" AS "clublocation" FROM "student" AS "LHS" CROSS JOIN "club" AS "RHS") AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."clubid" = "RHS"."clubid")) AS "LHS" INNER JOIN (SELECT * FROM "club" WHERE ("clubname" = 'Tennis Club')) AS RHS ON (LHS.clubid = RHS.clubid AND LHS.clubname = RHS.clubname AND LHS.clubdesc = RHS.clubdesc AND LHS.clublocation = RHS.clublocation)) GROUP BY clublocation, POSITION) ORDER BY avg_t3_age_;

/*
Gold Result:
(1.0,)
(1.0,)
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT AVG(t3.age) FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t1.clubname = 'Tennis Club';

/*
Prediction Result:
(1.0,)
*/