-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1014, 'Heidi Osborn', 'size', 'AKW');
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1015, 'Brenda Taylor', 'water', 'AKW');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubname" FROM "club" WHERE ("clublocation" = 'AKW') ORDER BY clubname, club.clubid NULLS LAST;

/*
Gold Result:
('Brenda Taylor',)
('Heidi Osborn',)
*/

-- Prediction Query
SELECT clubname FROM club WHERE clublocation = 'AKW';

/*
Prediction Result:
('Heidi Osborn',)
('Brenda Taylor',)
*/