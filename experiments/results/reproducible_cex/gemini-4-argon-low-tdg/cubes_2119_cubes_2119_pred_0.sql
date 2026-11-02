-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests WHERE clause filtering (exact match vs LIKE/case-sensitivity/NULL),
-- ORDER BY ASC vs DESC, and DISTINCT vs ALL (duplicate ClubNames with different ClubIDs).
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (1, 'Chess Club', 'AKW', 'AKW');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (2, 'Archery Club', 'Archery Desc', 'AKW');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (3, 'Chess Club', 'Second Chess Club', 'AKW');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (4, 'Debate Club', 'AKW', 'BKW');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (5, ' Drama Club', 'Drama Desc', 'akw');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (6, 'Music Club', 'Music Desc', 'AKW ');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (7, 'Art Club', 'Art Desc', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubname" FROM "club" WHERE ("clublocation" = 'AKW') ORDER BY clubname, club.clubid NULLS LAST;

/*
Gold Result:
('Archery Club',)
('Chess Club',)
('Chess Club',)
*/

-- Prediction Query
SELECT clubname FROM club WHERE clublocation = 'AKW';

/*
Prediction Result:
('Chess Club',)
('Archery Club',)
('Chess Club',)
*/