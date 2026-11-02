-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(DISTINCT Position) vs COUNT(Position) or COUNT(*) by having duplicate positions within the same club.
-- 2. Handling of NULL positions (COUNT(DISTINCT) should ignore NULLs).
-- 3. Filtering on ClubName = 'Bootup Baltimore' vs other clubs or NULL club names.
-- 4. Multiple clubs named 'Bootup Baltimore' with different distinct position counts to test GROUP BY ClubID, ORDER BY, and SELECT DISTINCT vs SELECT.
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 101, 201, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (2, 'Doe', 'Jane', 21, 'F', 102, 202, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (3, 'Brown', 'Bob', 22, 'M', 101, 201, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (4, 'White', 'Alice', 19, 'F', 103, 203, 'BAL');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (10, 'Bootup Baltimore', 'Tech club 1', 'Room 101');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (20, 'Chess Club', 'Board games', 'Room 102');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (30, 'Bootup Baltimore', 'Tech club 2', 'Room 103');
-- Club 10 ('Bootup Baltimore'): 4 members, 2 distinct non-null positions ('President', 'Member'), 1 duplicate, 1 NULL. Expected count: 2.
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 1, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 2, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 3, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (10, 4, NULL);
-- Club 30 ('Bootup Baltimore'): 1 member, 1 distinct position ('Treasurer'). Expected count: 1.
-- Inserted after Club 10 to ensure ORDER BY sorts [1, 2] instead of [2, 1].
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (30, 1, 'Treasurer');
-- Club 20 ('Chess Club'): Should be filtered out. Shares 'President' with Club 10 to catch mutants that omit GROUP BY ClubID.
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (20, 1, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (20, 2, 'Vice President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (20, 3, 'Secretary');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count_distinct_t2_position_" FROM (SELECT * FROM (SELECT "clubid", COUNT(DISTINCT "position") AS "n_distinct" FROM "member_of_club" GROUP BY "clubid") AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "club" WHERE ("clubname" = 'Bootup Baltimore')) AS RHS WHERE (LHS.clubid = RHS.clubid))) ORDER BY count_distinct_t2_position_;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT t2.position) FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid = t2.clubid WHERE t1.clubname = 'Bootup Baltimore';

/*
Prediction Result:
(3,)
*/