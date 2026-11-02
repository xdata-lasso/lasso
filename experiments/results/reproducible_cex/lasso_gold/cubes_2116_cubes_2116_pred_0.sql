-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1004, 'Kimberly Dudley', 'human', '327 Nelson Route
Lake Mark, WI 07832');
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1005, 'Andrew Stewart', 'result', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clubname FROM club ORDER BY clubname, club.clubid NULLS LAST;

/*
Gold Result:
('Andrew Stewart',)
('Kimberly Dudley',)
*/

-- Prediction Query
SELECT clubname FROM club;

/*
Prediction Result:
('Kimberly Dudley',)
('Andrew Stewart',)
*/