-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (1, 'Pen and Paper Gaming', 'Middle tier campaign group', 'Hall B');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (2, 'Pen and Paper Gaming', 'Zebra dungeon masters', 'Hall C');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (3, 'Pen and Paper Gaming', 'Alpha dice rollers', 'Hall A');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (4, 'Pen and Paper Gaming', 'Middle tier campaign group', 'Hall D');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (5, 'Robotics Club', 'Building autonomous robots', 'Eng Lab 1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubdesc" FROM "club" WHERE ("clubname" = 'Pen and Paper Gaming') ORDER BY clubdesc, club.clubid NULLS LAST;

/*
Gold Result:
('Alpha dice rollers',)
('Middle tier campaign group',)
('Middle tier campaign group',)
('Zebra dungeon masters',)
*/

-- Prediction Query
SELECT clubdesc FROM club WHERE clubname = 'Pen and Paper Gaming';

/*
Prediction Result:
('Middle tier campaign group',)
('Zebra dungeon masters',)
('Alpha dice rollers',)
('Middle tier campaign group',)
*/