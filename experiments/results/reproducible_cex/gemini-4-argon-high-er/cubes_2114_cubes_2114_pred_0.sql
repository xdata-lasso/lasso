-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (1, 'Chess', 'Chess Club', 'ABC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "clubid", "clublocation", COUNT(*) AS "n" FROM "club" GROUP BY "clubid", "clublocation") WHERE ("clublocation" <> 'HHH') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM club WHERE clublocation = 'HHH';

/*
Prediction Result:
(0,)
*/