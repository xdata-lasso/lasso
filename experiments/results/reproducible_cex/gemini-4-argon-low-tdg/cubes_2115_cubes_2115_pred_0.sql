-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT vs ALL, ORDER BY ClubLocation direction (ASC vs DESC), and NULLS FIRST/LAST handling
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (10, 'Tennis Club', 'Desc 1', 'Zone Z');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (20, 'Tennis Club', 'Desc 2', 'Zone A');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (30, 'Tennis Club', 'Desc 3', 'Zone A');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (40, 'Tennis Club', 'Desc 4', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clublocation" FROM "club" WHERE ("clubname" = 'Tennis Club') ORDER BY clublocation, club.clubid NULLS LAST;

/*
Gold Result:
(None,)
('Zone A',)
('Zone A',)
('Zone Z',)
*/

-- Prediction Query
SELECT clublocation FROM club WHERE clubname = 'Tennis Club';

/*
Prediction Result:
('Zone Z',)
('Zone A',)
('Zone A',)
(None,)
*/