-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic maximum count with a tie between two activities ("Art" and "Zumba" both have count 2), an activity with a lower count ("Chess" with count 1), an activity with 0 participants ("Swim"), and a decoy dominant activity in Participates_in ("Chess" has 3 students) to catch wrong table joins, missing DISTINCT, or LIMIT 1 instead of MAX.
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Zumba');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (2, 'Chess');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (3, 'Art');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (4, 'Swim');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (101, 'Smith', 'John', 'Prof', 'M', 1111, '101A', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (102, 'Doe', 'Jane', 'Assoc', 'F', 2222, '102B', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (103, 'Brown', 'Bob', 'Asst', 'M', 3333, '103C', 'Sci');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (201, 'Green', 'Alice', 20, 'F', 10, 101, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (202, 'White', 'Tom', 21, 'M', 10, 101, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (203, 'Black', 'Sam', 22, 'M', 20, 102, 'CHI');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 101);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 102);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (2, 101);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (3, 102);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (3, 103);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 201);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 202);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 203);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT activity_name FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, LHS.facid AS facid, LHS.n AS n FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, LHS.facid AS facid, RHS.n AS n FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, RHS.facid AS facid FROM activity AS LHS INNER JOIN faculty_participates_in AS RHS ON (LHS.actid = RHS.actid)) AS LHS INNER JOIN (SELECT actid, COUNT(*) AS n FROM faculty_participates_in GROUP BY actid) AS RHS ON (LHS.actid = RHS.actid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT actid, COUNT(*) AS n FROM faculty_participates_in GROUP BY actid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY activity_name;

/*
Gold Result:
('Art',)
('Zumba',)
*/

-- Prediction Query
SELECT T1.activity_name FROM Activity AS T1 JOIN Faculty_participates_in AS T2 ON T1.actID = T2.actID GROUP BY T1.actID ORDER BY COUNT(*) DESC, T1.activity_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Art',)
*/