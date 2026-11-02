-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("actid", "activity_name") VALUES (13, '20');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (12, '20');
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (12, 14);
INSERT INTO "Faculty_Participates_in" ("actid", "facid") VALUES (12, 16);
INSERT INTO "Faculty_Participates_in" ("actid", "facid") VALUES (13, NULL);
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (14, '20', '20', 20, '20', 20, 20, '20');
INSERT INTO "Student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (15, '20', '20', 20, '20', 20, 20, '20');
INSERT INTO "Faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (25, '20', '20', '26', '27', NULL, '22', NULL);
INSERT INTO "Faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (16, '29', '19', '20', '20', 20, '21', '30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT building FROM (SELECT LHS.facid AS facid, LHS.lname AS lname, LHS.fname AS fname, LHS.rank AS rank, LHS.sex AS sex, LHS.phone AS phone, LHS.room AS room, LHS.building AS building, RHS.n AS n FROM faculty AS LHS INNER JOIN (SELECT fname, room, COUNT(*) AS n FROM faculty GROUP BY fname, room) AS RHS ON (LHS.lname = RHS.fname AND LHS.room = RHS.room)) ORDER BY building;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT building FROM Faculty GROUP BY building ORDER BY COUNT(*) DESC, building NULLS LAST LIMIT 1;

/*
Prediction Result:
('30',)
*/