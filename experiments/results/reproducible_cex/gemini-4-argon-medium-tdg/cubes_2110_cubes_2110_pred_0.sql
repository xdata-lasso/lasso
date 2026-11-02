-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY direction (ASC vs DESC), NULL handling in ClubLocation, and secondary sort on ClubID when ClubLocation has ties.
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (10, 'Pen and Paper Gaming', 'Branch Z', 'Zeta Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (20, 'Pen and Paper Gaming', 'Branch A1', 'Alpha Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (5, 'Pen and Paper Gaming', 'Branch A2', 'Alpha Hall');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (15, 'Pen and Paper Gaming', 'Branch Null', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clublocation" FROM "club" WHERE ("clubname" = 'Pen and Paper Gaming') ORDER BY clublocation, club.clubid NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Hall',)
('Alpha Hall',)
('Zeta Hall',)
*/

-- Prediction Query
SELECT clublocation FROM club WHERE clubname = 'Pen and Paper Gaming';

/*
Prediction Result:
('Alpha Hall',)
('Zeta Hall',)
(None,)
('Alpha Hall',)
*/