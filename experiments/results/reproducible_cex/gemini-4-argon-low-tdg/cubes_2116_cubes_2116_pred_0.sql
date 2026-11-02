-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (10, 'Debate Club', 'First chapter', 'Building A');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (20, 'Debate Club', 'Second chapter', 'Building B');
INSERT INTO Club (ClubID, ClubName, ClubDesc, ClubLocation) VALUES (30, 'Astronomy Club', 'Stargazing', 'Roof');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clubname FROM club ORDER BY clubname, club.clubid NULLS LAST;

/*
Gold Result:
('Astronomy Club',)
('Debate Club',)
('Debate Club',)
*/

-- Prediction Query
SELECT clubname FROM club;

/*
Prediction Result:
('Debate Club',)
('Debate Club',)
('Astronomy Club',)
*/