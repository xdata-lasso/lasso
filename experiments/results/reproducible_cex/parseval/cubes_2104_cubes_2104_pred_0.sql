-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'stu_472888', 'stu_b12b63', 1, 'stu_c53c00', 1, 1, 'BAL');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'stu_58f729', 'stu_5251f9', 1, 'stu_f099df', 1, 1, 'BAL');

-- Inserting into table: club --
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1, 'lhs_55bba1', 'lhs_ab7acf', 'lhs_628a41');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (-2147483647, 'lhs_f111fc', 'lhs_4809f1', 'lhs_fce1a0');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (3, 'lhs_55bba1', 'lhs_ab7acf', 'lhs_628a41');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (2, 'clu_6aecaf', 'clu_f631b3', 'clu_554842');

-- Inserting into table: member_of_club --
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_17f2bc');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (2, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (2, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (2, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (2, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_17f2bc');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_17f2bc');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_17f2bc');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_17f2bc');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, NULL);

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c30c03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubname" FROM (SELECT "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "LHS"."stuid" AS "stuid", "LHS"."position" AS "position", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."stuid" AS "stuid", "RHS"."position" AS "position" FROM "club" AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."clubid" = "RHS"."clubid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("city_code" = 'BAL')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY clubname, "clubname" NULLS LAST;

/*
Gold Result:
('clu_6aecaf',)
('clu_6aecaf',)
('clu_6aecaf',)
('clu_6aecaf',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
('lhs_55bba1',)
*/

-- Prediction Query
SELECT DISTINCT t1.clubname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t3.city_code = 'BAL';

/*
Prediction Result:
('lhs_55bba1',)
('clu_6aecaf',)
*/