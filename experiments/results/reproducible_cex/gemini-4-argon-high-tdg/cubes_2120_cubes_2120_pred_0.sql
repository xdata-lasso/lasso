-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (10, 'Hopkins Student Enterprises', 'South Campus Branch', 'Mudd Hall');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (20, 'Hopkins Student Enterprises', 'North Campus Branch A', 'Brody Atrium');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (30, 'Hopkins Student Enterprises', 'North Campus Branch B', 'Brody Atrium');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (40, 'Robotics Club', 'Engineering group', 'Brody Atrium');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clublocation" FROM "club" WHERE ("clubname" = 'Hopkins Student Enterprises') ORDER BY clublocation, club.clubid NULLS LAST;

/*
Gold Result:
('Brody Atrium',)
('Brody Atrium',)
('Mudd Hall',)
*/

-- Prediction Query
SELECT clublocation FROM club WHERE clubname = 'Hopkins Student Enterprises';

/*
Prediction Result:
('Mudd Hall',)
('Brody Atrium',)
('Brody Atrium',)
*/