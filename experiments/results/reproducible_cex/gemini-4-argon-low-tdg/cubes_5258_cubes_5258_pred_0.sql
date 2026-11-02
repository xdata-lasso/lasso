-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for the maximum count (kills LIMIT 1 mutants), ORDER BY activity_name vs ORDER BY actid, and Faculty_Participates_in confusion.
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Zulu');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (2, 'Alpha');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (3, 'Beta');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'John', 20, 'M', 1, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Doe', 'Jane', 21, 'F', 1, 1, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (103, 'Brown', 'Bob', 22, 'M', 2, 1, 'CHI');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (201, 'White', 'Walter', 'Prof', 'M', 111, '10A', 'Sci');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (202, 'Green', 'Rachel', 'Assoc', 'F', 222, '10B', 'Arts');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (203, 'Black', 'Sirius', 'Asst', 'M', 333, '10C', 'Magic');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (204, 'Gray', 'Dorian', 'Inst', 'M', 444, '10D', 'Lit');
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (1, 101);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (1, 102);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (1, 103);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 101);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 102);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 103);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (3, 101);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (3, 201);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (3, 202);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (3, 203);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (3, 204);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT activity_name FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, LHS.stuid AS stuid, LHS.n AS n FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, LHS.stuid AS stuid, RHS.n AS n FROM (SELECT LHS.actid AS actid, LHS.activity_name AS activity_name, RHS.stuid AS stuid FROM activity AS LHS INNER JOIN participates_in AS RHS ON (LHS.actid = RHS.actid)) AS LHS INNER JOIN (SELECT actid, COUNT(*) AS n FROM participates_in GROUP BY actid) AS RHS ON (LHS.actid = RHS.actid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT actid, COUNT(*) AS n FROM participates_in GROUP BY actid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY activity_name;

/*
Gold Result:
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT T1.activity_name FROM Activity AS T1 JOIN Participates_in AS T2 ON T1.actID = T2.actID GROUP BY T1.actID ORDER BY COUNT(*) DESC, T1.activity_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/