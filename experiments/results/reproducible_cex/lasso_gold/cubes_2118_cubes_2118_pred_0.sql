-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1014, 'Pen and Paper Gaming', 'treatment', '6670 Bruce Stream Suite 133
New Shane, NE 24551');
INSERT INTO "club" ("clubid", "clubname", "clubdesc", "clublocation") VALUES (1015, 'Pen and Paper Gaming', 'customer', '8108 Tanya Terrace
East Richard, NJ 28517');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubdesc" FROM "club" WHERE ("clubname" = 'Pen and Paper Gaming') ORDER BY clubdesc, club.clubid NULLS LAST;

/*
Gold Result:
('customer',)
('treatment',)
*/

-- Prediction Query
SELECT clubdesc FROM club WHERE clubname = 'Pen and Paper Gaming';

/*
Prediction Result:
('treatment',)
('customer',)
*/