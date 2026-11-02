-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (27, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (26, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (57, NULL, 'Tennis Club56', NULL);
INSERT INTO "Club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (48, 'Tennis Club49', NULL, NULL);
INSERT INTO "Member_of_club" ("clubid", "stuid", "position") VALUES (57, 26, NULL);
INSERT INTO "Member_of_club" ("clubid", "stuid", "position") VALUES (57, 27, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n_distinct" AS "count___" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "LHS"."position" AS "position", "RHS"."n_distinct" AS "n_distinct" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."clubid" AS "clubid", "RHS"."clubname" AS "clubname", "RHS"."clubdesc" AS "clubdesc", "RHS"."clublocation" AS "clublocation" FROM "student" AS "LHS" CROSS JOIN "club" AS "RHS") AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."clubid" = "RHS"."clubid")) AS "LHS" INNER JOIN (SELECT "clubdesc", "clubid", COUNT(DISTINCT "clubname") AS "n_distinct" FROM "club" GROUP BY "clubdesc", "clubid") AS "RHS" ON ("LHS"."clubid" = "RHS"."clubid" AND "LHS"."clubdesc" = "RHS"."clubdesc")) WHERE ("clubname" <> 'Tennis Club') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t1.clubname = 'Tennis Club';

/*
Prediction Result:
(0,)
*/