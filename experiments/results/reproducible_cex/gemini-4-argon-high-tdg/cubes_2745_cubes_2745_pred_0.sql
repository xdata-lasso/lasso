-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Smith', 'Jerry', 'Professor', 'M', 3000, '101', 'Science');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Prince', 'Alice', 'Assoc Prof', 'F', 1000, '202', 'Arts');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (3, 'Prince', 'Jerry', 'Instructor', 'M', 2000, '303', 'Eng');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (4, 'Jerry', 'Prince', 'Professor', 'M', 1500, '404', 'Math');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (5, 'Jones', 'Bob', 'Asst Prof', 'M', 500, '505', 'History');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "phone", "room", "building" FROM "faculty" WHERE ("fname" = 'Jerry' OR "lname" = 'Prince') ORDER BY phone, faculty.facid NULLS LAST;

/*
Gold Result:
(1000, '202', 'Arts')
(2000, '303', 'Eng')
(3000, '101', 'Science')
*/

-- Prediction Query
SELECT phone, room, building FROM Faculty WHERE Fname = 'Jerry' AND Lname = 'Prince';

/*
Prediction Result:
(2000, '303', 'Eng')
*/