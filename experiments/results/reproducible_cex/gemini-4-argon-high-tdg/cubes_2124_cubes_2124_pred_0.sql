-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Adams', 'Zoe', 20, 'F', 600, 1100, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Zimmer', 'Amy', 21, 'F', 600, 1100, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Baker', 'Amy', 19, 'F', 600, 1100, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'Clark', 'Beth', 22, 'F', 600, 1100, 'BAL');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (10, 'Bootup Baltimore', 'Startup incubator', 'Hall A');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 1, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 2, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 3, 'Leader');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 4, 'Member');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."clubid" AS "clubid", "RHS"."clubname" AS "clubname", "RHS"."clubdesc" AS "clubdesc", "RHS"."clublocation" AS "clublocation" FROM "student" AS "LHS" CROSS JOIN "club" AS "RHS") AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."clubid" = "RHS"."clubid")) WHERE ("clubname" = 'Bootup Baltimore' AND "sex" = 'F') ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('Amy', 'Baker')
('Amy', 'Zimmer')
('Beth', 'Clark')
('Zoe', 'Adams')
*/

-- Prediction Query
SELECT t3.fname, t3.lname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t1.clubname = 'Bootup Baltimore' AND t3.sex = 'F';

/*
Prediction Result:
('Zoe', 'Adams')
('Amy', 'Zimmer')
('Amy', 'Baker')
('Beth', 'Clark')
*/