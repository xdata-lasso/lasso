-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'John', 'Smith', 'Professor', 'M', 1001, '101', 'Bldg_Z');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (2, 'Doe', 'John', 'AssocProf', 'F', 1002, '101', 'Bldg_A');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (3, 'Alice', 'Bob', 'Lecturer', 'M', 1003, '102', 'Bldg_Z');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (4, 'Carol', 'Alice', 'Instructor', 'F', 1004, '102', 'Bldg_B');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (5, 'David', 'Eve', 'Professor', 'M', 1005, '103', 'Bldg_A');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (6, 'Frank', 'David', 'Professor', 'M', 1006, '103', 'Bldg_C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT building FROM (SELECT LHS.facid AS facid, LHS.lname AS lname, LHS.fname AS fname, LHS.rank AS rank, LHS.sex AS sex, LHS.phone AS phone, LHS.room AS room, LHS.building AS building, RHS.n AS n FROM faculty AS LHS INNER JOIN (SELECT fname, room, COUNT(*) AS n FROM faculty GROUP BY fname, room) AS RHS ON (LHS.lname = RHS.fname AND LHS.room = RHS.room)) ORDER BY building;

/*
Gold Result:
('Bldg_A',)
('Bldg_Z',)
*/

-- Prediction Query
SELECT building FROM Faculty GROUP BY building ORDER BY COUNT(*) DESC, building NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bldg_A',)
*/