-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1105, 'Bootup Baltimore', 'respond', 'Unit 8501 Box 4294
DPO AE 14709');
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1115, 'Bootup Baltimore', 'we', '656 Spencer Fields Suite 629
Richardtown, ME 38107');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1106, 'Carlson', 'Michael', 1107, 'F', 1108, 1109, 'Samuelhaven');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1116, 'Clark', 'Kristi', 1117, 'F', 1118, 1119, 'Stevenmouth');
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1105, 1106, 'business');
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1105, 1106, 'service');
INSERT INTO "member_of_club" ("clubid", "stuid", "position") VALUES (1115, 1116, 'Republican');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."clubid" AS "clubid", "RHS"."clubname" AS "clubname", "RHS"."clubdesc" AS "clubdesc", "RHS"."clublocation" AS "clublocation" FROM "student" AS "LHS" CROSS JOIN "club" AS "RHS") AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."clubid" = "RHS"."clubid")) WHERE ("clubname" = 'Bootup Baltimore' AND "sex" = 'F') ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('Kristi', 'Clark')
('Michael', 'Carlson')
('Michael', 'Carlson')
*/

-- Prediction Query
SELECT t3.fname, t3.lname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t1.clubname = 'Bootup Baltimore' AND t3.sex = 'F';

/*
Prediction Result:
('Michael', 'Carlson')
('Michael', 'Carlson')
('Kristi', 'Clark')
*/