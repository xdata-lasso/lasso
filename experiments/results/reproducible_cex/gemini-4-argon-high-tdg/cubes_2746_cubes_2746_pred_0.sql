-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Taylor', 'Tom', 'Professor', NULL, NULL, NULL, NULL);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Miller', 'Max', 'Professor', 'M', 1234, '10A', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (3, NULL, NULL, 'Professor', 'M', NULL, NULL, NULL);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (4, 'Wilson', 'Wendy', 'Professor', 'F', 2345, '10B', 'Main');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (5, 'Moore', 'Mia', NULL, NULL, NULL, NULL, NULL);
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (6, 'White', 'Will', NULL, 'M', 3456, '20A', 'West');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (7, 'Harris', 'Helen', NULL, 'F', 4567, '20B', 'West');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (8, NULL, NULL, NULL, 'F', NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rank, sex, n AS count___ FROM (SELECT rank, sex, COUNT(*) AS n FROM faculty GROUP BY rank, sex) ORDER BY rank, sex NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, 'F', 2)
(None, 'M', 1)
(None, None, 1)
('Professor', 'F', 1)
('Professor', 'M', 2)
('Professor', None, 1)
*/

-- Prediction Query
SELECT rank, sex, COUNT(*) FROM Faculty GROUP BY rank, sex;

/*
Prediction Result:
(None, None, 1)
(None, 'F', 2)
(None, 'M', 1)
('Professor', None, 1)
('Professor', 'F', 1)
('Professor', 'M', 2)
*/