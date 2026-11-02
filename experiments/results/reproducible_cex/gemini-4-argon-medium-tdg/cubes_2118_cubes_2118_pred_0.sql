-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1001, 'Smith', 'John', 20, 'M', 10, 100, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1002, 'Doe', 'Jane', 22, 'F', 20, 200, 'LAX');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (10, 'Pen and Paper Gaming', 'Zeta campaigns.', 'Building A');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (20, 'Pen and Paper Gaming', 'Alpha campaigns.', 'Building B');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (30, 'Pen and Paper Gaming', 'Alpha campaigns.', 'Building C');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (40, 'Pen and Paper Gaming', NULL, 'Building D');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (20, 1001, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (20, 1002, 'Treasurer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clubdesc" FROM "club" WHERE ("clubname" = 'Pen and Paper Gaming') ORDER BY clubdesc, club.clubid NULLS LAST;

/*
Gold Result:
(None,)
('Alpha campaigns.',)
('Alpha campaigns.',)
('Zeta campaigns.',)
*/

-- Prediction Query
SELECT clubdesc FROM club WHERE clubname = 'Pen and Paper Gaming';

/*
Prediction Result:
('Zeta campaigns.',)
('Alpha campaigns.',)
('Alpha campaigns.',)
(None,)
*/