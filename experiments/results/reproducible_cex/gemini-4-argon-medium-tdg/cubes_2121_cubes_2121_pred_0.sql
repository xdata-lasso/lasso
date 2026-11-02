-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (1, 'Tennis Club', 'Varsity Tennis', 'Court 1');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (2, 'Chess Club', 'Strategy and Board Games', 'Room 101');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (3, 'Tennis Club', 'Amateur Tennis', 'Court 2');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (4, 'tennis club', 'Lowercase Tennis', 'Court 3');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (5, 'Tennis Club Extra', 'Substring Tennis', 'Court 4');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (6, NULL, 'Null Name Club', 'Nowhere');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubdesc" FROM "club" WHERE ("clubname" = 'Tennis Club') ORDER BY clubdesc, club.clubid NULLS LAST;

/*
Gold Result:
('Amateur Tennis',)
('Varsity Tennis',)
*/

-- Prediction Query
SELECT clubdesc FROM club WHERE clubname = 'Tennis Club';

/*
Prediction Result:
('Varsity Tennis',)
('Amateur Tennis',)
*/