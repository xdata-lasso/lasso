-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (1, 'Tennis Club', NULL, 'Court A');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (2, 'Tennis Club', 'Beginner friendly', 'Court B');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (3, 'Tennis Club', 'Advanced players', 'Court C');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (4, 'Swimming Club', 'Tennis Club', 'Pool');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (5, 'Rowing Club', 'Water sports', 'Tennis Club');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubdesc" FROM "club" WHERE ("clubname" = 'Tennis Club') ORDER BY clubdesc, club.clubid NULLS LAST;

/*
Gold Result:
(None,)
('Advanced players',)
('Beginner friendly',)
*/

-- Prediction Query
SELECT clubdesc FROM club WHERE clubname = 'Tennis Club';

/*
Prediction Result:
(None,)
('Beginner friendly',)
('Advanced players',)
*/