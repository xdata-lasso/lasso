-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1006, 'Henderson', 'Anthony', 'discussion', 'early', 1007, 'mouth', 'kind');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1008, 'Johnson', 'James', 'discover', 'science', 1008, 'offer', 'play');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rank, fname, lname FROM faculty ORDER BY rank, faculty.facid NULLS LAST;

/*
Gold Result:
('discover', 'James', 'Johnson')
('discussion', 'Anthony', 'Henderson')
*/

-- Prediction Query
SELECT rank, Fname, Lname FROM Faculty;

/*
Prediction Result:
('discussion', 'Anthony', 'Henderson')
('discover', 'James', 'Johnson')
*/