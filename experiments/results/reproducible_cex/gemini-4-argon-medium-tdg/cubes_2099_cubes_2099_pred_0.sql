-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 100, 10, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 100, 10, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Lee', 'Bob', 22, 'M', 200, 20, 'NYC');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (10, 'Bootup Baltimore', 'Branch 1', 'North');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (20, 'Bootup Baltimore', 'Branch 2', 'South');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (30, 'Bootup Baltimore', 'Branch 3', 'East');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 1, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 2, 'Treasurer');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 3, 'Secretary');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (20, 1, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (30, 1, 'Secretary');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (30, 2, 'Member');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count_distinct_t2_position_" FROM (SELECT * FROM (SELECT "clubid", COUNT(DISTINCT "position") AS "n_distinct" FROM "member_of_club" GROUP BY "clubid") AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "club" WHERE ("clubname" = 'Bootup Baltimore')) AS RHS WHERE (LHS.clubid = RHS.clubid))) ORDER BY count_distinct_t2_position_;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT t2.position) FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid WHERE t1.clubname = 'Bootup Baltimore';

/*
Prediction Result:
(4,)
*/