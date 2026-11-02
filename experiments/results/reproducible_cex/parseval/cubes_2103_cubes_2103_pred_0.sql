-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'stu_42e94c', 'stu_cbf871', 1, 'stu_7db14d', 1, 1, 'HOU');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'stu_766aa4', 'stu_7cf9fe', 1, 'stu_2ea484', 1, 1, 'HOU');

-- Inserting into table: club --
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1, 'lhs_cb8c76', 'lhs_2fa4ce', 'lhs_0f6987');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (-2147483647, 'lhs_bcaca4', 'lhs_e21d32', 'lhs_7cb901');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (3, 'lhs_cb8c76', 'lhs_2fa4ce', 'lhs_0f6987');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (2, 'clu_6aecaf', 'clu_f631b3', 'clu_554842');

-- Inserting into table: member_of_club --
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_43f033');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (2, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (2, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (2, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (2, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_43f033');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_43f033');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_43f033');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_43f033');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, NULL);

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, 1, 'rhs_c44b15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubname" FROM (SELECT "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "LHS"."stuid" AS "stuid", "LHS"."position" AS "position", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname", "RHS"."age" AS "age", "RHS"."sex" AS "sex", "RHS"."major" AS "major", "RHS"."advisor" AS "advisor", "RHS"."city_code" AS "city_code" FROM (SELECT "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."stuid" AS "stuid", "RHS"."position" AS "position" FROM "club" AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."clubid" = "RHS"."clubid")) AS "LHS" INNER JOIN (SELECT * FROM "student" WHERE ("city_code" = 'HOU')) AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY clubname, "clubname" NULLS LAST;

/*
Gold Result:
('clu_6aecaf',)
('clu_6aecaf',)
('clu_6aecaf',)
('clu_6aecaf',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
('lhs_cb8c76',)
*/

-- Prediction Query
SELECT DISTINCT t1.clubname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t3.city_code = 'HOU';

/*
Prediction Result:
('lhs_cb8c76',)
('clu_6aecaf',)
*/