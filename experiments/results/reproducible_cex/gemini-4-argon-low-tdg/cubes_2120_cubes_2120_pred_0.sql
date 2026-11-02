-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (10, 'Hopkins Student Enterprises', 'Branch Z', 'Zeta Room');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (20, 'Hopkins Student Enterprises', 'Branch A1', 'Alpha Room');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (15, 'Hopkins Student Enterprises', 'Branch A2', 'Alpha Room');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (30, 'Hopkins Student Enterprises', 'Branch M', 'Beta Room');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clublocation" FROM "club" WHERE ("clubname" = 'Hopkins Student Enterprises') ORDER BY clublocation, club.clubid NULLS LAST;

/*
Gold Result:
('Alpha Room',)
('Alpha Room',)
('Beta Room',)
('Zeta Room',)
*/

-- Prediction Query
SELECT clublocation FROM club WHERE clubname = 'Hopkins Student Enterprises';

/*
Prediction Result:
('Zeta Room',)
('Alpha Room',)
('Alpha Room',)
('Beta Room',)
*/