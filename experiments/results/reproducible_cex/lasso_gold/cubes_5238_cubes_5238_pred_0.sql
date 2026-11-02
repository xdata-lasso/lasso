-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("actid", "activity_name") VALUES (1025, 'Kimberly Sanchez');
INSERT INTO "activity" ("actid", "activity_name") VALUES (1028, 'Frederick Tate');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1026, 'Ford', 'Joseph', 'wish', 'push', 1027, 'rise', 'onto');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1029, 'Ford', 'Brian', 'term', 'almost', 1030, 'support', 'four');
INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1025, 1026);
INSERT INTO "faculty_participates_in" ("actid", "facid") VALUES (1028, 1029);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname, n AS count___, facid FROM (SELECT LHS.facid AS facid, LHS.lname AS lname, LHS.fname AS fname, LHS.rank AS rank, LHS.sex AS sex, LHS.phone AS phone, LHS.room AS room, LHS.building AS building, RHS.n AS n FROM faculty AS LHS INNER JOIN (SELECT facid, COUNT(*) AS n FROM faculty_participates_in GROUP BY facid) AS RHS ON (LHS.facid = RHS.facid)) ORDER BY fname, lname NULLS LAST, count___ NULLS LAST, facid NULLS LAST;

/*
Gold Result:
('Brian', 'Ford', 1, 1029)
('Joseph', 'Ford', 1, 1026)
*/

-- Prediction Query
SELECT T1.fname, T1.lname, COUNT(*), T1.FacID FROM Faculty AS T1 JOIN Faculty_participates_in AS T2 ON T1.facID = T2.facID GROUP BY T1.FacID;

/*
Prediction Result:
('Joseph', 'Ford', 1, 1026)
('Brian', 'Ford', 1, 1029)
*/