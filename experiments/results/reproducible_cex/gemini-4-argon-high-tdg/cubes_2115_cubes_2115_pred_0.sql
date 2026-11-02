-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Doe', 'Jane', 21, 'F', 600, 1121, 'NYC');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (1, 'Tennis Club', 'Outdoor tennis', 'West Court');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (2, 'Tennis Club', 'Indoor tennis', 'East Court');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (3, 'Archery Club', 'Bow and arrow', 'North Field');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (4, 'Yoga Club', 'Relaxation', 'South Room');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (2, 101, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (2, 102, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (3, 101, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (4, 102, 'Treasurer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "clublocation" FROM "club" WHERE ("clubname" = 'Tennis Club') ORDER BY clublocation, club.clubid NULLS LAST;

/*
Gold Result:
('East Court',)
('West Court',)
*/

-- Prediction Query
SELECT clublocation FROM club WHERE clubname = 'Tennis Club';

/*
Prediction Result:
('West Court',)
('East Court',)
*/