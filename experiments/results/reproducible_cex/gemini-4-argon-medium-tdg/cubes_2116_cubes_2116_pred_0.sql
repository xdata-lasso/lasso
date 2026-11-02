-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Club" ("ClubID" INTEGER PRIMARY KEY, "ClubName" TEXT(40), "ClubDesc" TEXT(1024), "ClubLocation" TEXT(40));

CREATE TABLE "Member_of_club" ("ClubID" INTEGER, "StuID" INTEGER, "Position" TEXT(40), FOREIGN KEY ("ClubID") REFERENCES "Club" ("ClubID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT), and JOIN mistakes (clubs with 0 vs multiple members).
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'John', 20, 'M', 1, 10, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Doe', 'Jane', 22, 'F', 2, 11, 'LAX');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (1, 'Chess Club', 'Board games', 'Room 101');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (2, 'Archery Club', 'Target practice', 'Field A');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (3, 'Chess Club', 'Advanced Chess', 'Room 102');
INSERT INTO "Club" ("ClubID", "ClubName", "ClubDesc", "ClubLocation") VALUES (4, 'Debate Club', 'Public speaking', 'Auditorium');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 101, 'President');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (1, 102, 'Member');
INSERT INTO "Member_of_club" ("ClubID", "StuID", "Position") VALUES (3, 101, 'Treasurer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT clubname FROM club ORDER BY clubname, club.clubid NULLS LAST;

/*
Gold Result:
('Archery Club',)
('Chess Club',)
('Chess Club',)
('Debate Club',)
*/

-- Prediction Query
SELECT clubname FROM club;

/*
Prediction Result:
('Chess Club',)
('Archery Club',)
('Chess Club',)
('Debate Club',)
*/