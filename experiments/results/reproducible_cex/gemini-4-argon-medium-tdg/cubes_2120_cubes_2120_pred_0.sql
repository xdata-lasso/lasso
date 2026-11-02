-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filter (exact match vs partial match, case sensitivity, NULLs, other values)
-- and ORDER BY clublocation ASC (inserted out of order, with duplicates to test DISTINCT vs ALL).
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (1, 'Hopkins Student Enterprises', 'Main branch', 'Zeta Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (2, 'Hopkins Student Enterprises', 'Branch 2', 'Alpha Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (3, 'Hopkins Student Enterprises', 'Branch 3', 'Alpha Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (4, 'hopkins student enterprises', 'Lowercase name', 'Beta Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (5, 'Hopkins Student Enterprises ', 'Trailing space', 'Gamma Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (6, 'Hopkins Student', 'Prefix match', 'Delta Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (7, 'Other Club', 'Hopkins Student Enterprises', 'Epsilon Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (8, NULL, 'Null name', 'Theta Hall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clublocation" FROM "club" WHERE ("clubname" = 'Hopkins Student Enterprises') ORDER BY clublocation, club.clubid NULLS LAST;

/*
Gold Result:
('Alpha Hall',)
('Alpha Hall',)
('Zeta Hall',)
*/

-- Prediction Query
SELECT clublocation FROM club WHERE clubname = 'Hopkins Student Enterprises';

/*
Prediction Result:
('Zeta Hall',)
('Alpha Hall',)
('Alpha Hall',)
*/