-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY clubdesc ASC, duplicate elimination (SELECT vs SELECT DISTINCT), NULLS in ClubDesc, and tie-breaking with clubid
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (10, 'Pen and Paper Gaming', 'Zebra gaming description', 'Hall A');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (20, 'Pen and Paper Gaming', 'Alpha gaming description', 'Hall B');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (15, 'Pen and Paper Gaming', 'Alpha gaming description', 'Hall C');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (30, 'Pen and Paper Gaming', NULL, 'Hall D');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (5, 'Other Club', 'Beta description', 'Hall E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubdesc" FROM "club" WHERE ("clubname" = 'Pen and Paper Gaming') ORDER BY clubdesc, club.clubid NULLS LAST;

/*
Gold Result:
(None,)
('Alpha gaming description',)
('Alpha gaming description',)
('Zebra gaming description',)
*/

-- Prediction Query
SELECT clubdesc FROM club WHERE clubname = 'Pen and Paper Gaming';

/*
Prediction Result:
('Zebra gaming description',)
('Alpha gaming description',)
('Alpha gaming description',)
(None,)
*/