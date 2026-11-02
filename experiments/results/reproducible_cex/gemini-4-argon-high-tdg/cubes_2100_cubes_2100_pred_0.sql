-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 30, 'M', 10, 100, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 30, 'F', 10, 100, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Bob', 33, 'M', 10, 101, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'White', 'Alice', 18, 'F', 20, 102, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (5, 'Green', 'Tom', 21, 'M', 20, 102, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (6, 'Black', 'Eve', 25, 'F', 30, 103, 'CHI');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (7, 'Hill', 'Sam', 40, 'M', 10, 100, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (8, 'Scott', 'Kim', 19, 'F', 40, 104, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (9, 'Adams', 'Ray', 50, 'M', 20, 102, 'DEN');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (1, 'Bootup Baltimore', 'Tech entrepreneurship club', 'Baltimore');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (2, 'Chess Club', 'Competitive board games', 'New York');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 1, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 2, 'Vice President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 3, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 4, 'Treasurer');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 5, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 6, 'Secretary');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (2, 4, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (2, 7, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (2, 8, 'Member');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanage" AS "avg_t3_age_" FROM (SELECT "clubid", "major", AVG("age") AS "meanage" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "LHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "LHS"."clubid" AS "clubid", "LHS"."clubname" AS "clubname", "LHS"."clubdesc" AS "clubdesc", "LHS"."clublocation" AS "clublocation", "RHS"."position" AS "position" FROM (SELECT "LHS"."stuid" AS "stuid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."age" AS "age", "LHS"."sex" AS "sex", "LHS"."major" AS "major", "LHS"."advisor" AS "advisor", "LHS"."city_code" AS "city_code", "RHS"."clubid" AS "clubid", "RHS"."clubname" AS "clubname", "RHS"."clubdesc" AS "clubdesc", "RHS"."clublocation" AS "clublocation" FROM "student" AS "LHS" CROSS JOIN "club" AS "RHS") AS "LHS" INNER JOIN "member_of_club" AS "RHS" ON ("LHS"."stuid" = "RHS"."stuid" AND "LHS"."clubid" = "RHS"."clubid")) AS "LHS" INNER JOIN (SELECT * FROM "club" WHERE ("clubname" = 'Bootup Baltimore')) AS RHS ON (LHS.clubid = RHS.clubid AND LHS.clubname = RHS.clubname AND LHS.clubdesc = RHS.clubdesc AND LHS.clublocation = RHS.clublocation)) GROUP BY clubid, major) ORDER BY avg_t3_age_;

/*
Gold Result:
(19.5,)
(25.0,)
(31.0,)
*/

-- Prediction Query
SELECT AVG(t3.age) FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid JOIN student AS t3 ON t2.stuid = t3.stuid WHERE t1.clubname = 'Bootup Baltimore';

/*
Prediction Result:
(26.166666666666668,)
*/