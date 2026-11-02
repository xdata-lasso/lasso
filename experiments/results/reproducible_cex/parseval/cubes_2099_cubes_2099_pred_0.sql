-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483648, 'stu_5554fd', 'stu_ebb0d7', -55602865, 'f', -59984348, -664303813, 'db6');

-- Inserting into table: club --
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1, 'Bootup Baltimore', 'clu_0761ec', 'clu_8ee55e');

INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (-2147483648, 'Bootup Baltimore', 'clu_5a82ef', 'clu_c4d4d6');

-- Inserting into table: member_of_club --
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483648, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (-2147483648, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');

INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1, -2147483648, 'mem_ed27ed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count_distinct_t2_position_" FROM (SELECT * FROM (SELECT "clubid", COUNT(DISTINCT "position") AS "n_distinct" FROM "member_of_club" GROUP BY "clubid") AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "club" WHERE ("clubname" = 'Bootup Baltimore')) AS RHS WHERE (LHS.clubid = RHS.clubid))) ORDER BY count_distinct_t2_position_;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT t2.position) FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid WHERE t1.clubname = 'Bootup Baltimore';

/*
Prediction Result:
(1,)
*/