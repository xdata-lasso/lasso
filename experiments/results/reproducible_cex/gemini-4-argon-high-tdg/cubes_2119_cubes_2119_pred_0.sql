-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1002, 'Doe', 'Jane', 19, 'F', 600, 1121, 'NYC');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (1, 'Zeta Club', 'Last alphabetically but first ID', 'AKW');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (2, 'Beta Club', 'Middle alphabetically', 'AKW');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (3, 'Alpha Club', 'First alphabetically but last ID', 'AKW');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (4, 'Delta Club', 'Located elsewhere', 'WNE');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 1001, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 1002, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (4, 1001, 'Treasurer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubname" FROM "club" WHERE ("clublocation" = 'AKW') ORDER BY clubname, club.clubid NULLS LAST;

/*
Gold Result:
('Alpha Club',)
('Beta Club',)
('Zeta Club',)
*/

-- Prediction Query
SELECT clubname FROM club WHERE clublocation = 'AKW';

/*
Prediction Result:
('Zeta Club',)
('Beta Club',)
('Alpha Club',)
*/