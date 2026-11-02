-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Debate Club');
INSERT INTO "Activity" ("actid", "activity_name") VALUES (2, 'Chess Team');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (10, 'Adams', 'Zack', 'Professor', 'M', 1001, '101', 'NEB');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (20, 'Baker', 'Yara', 'Instructor', 'F', 2002, '202', 'Carnegie');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (30, 'Clark', 'Xena', 'Assoc Prof', 'F', 3003, '303', 'Barton');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (40, 'Davis', 'Will', 'Asst Prof', 'M', 4004, '404', 'Carnegie');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (50, 'Evans', 'Vera', 'Professor', 'F', 5005, '505', 'Barton');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (60, 'Frank', 'Uma', 'Instructor', 'M', 6006, '606', 'Carnegie');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Smith', 'Tom', 20, 'M', 600, 20, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Jones', 'Sam', 21, 'F', 600, 40, 'BOS');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (103, 'Brown', 'Pam', 19, 'F', 520, 60, 'CHI');
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (1, 101);
INSERT INTO "Participates_in" ("actid", "stuid") VALUES (2, 102);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 10);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 20);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (2, 40);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (2, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT building FROM faculty ORDER BY building;

/*
Gold Result:
('Barton',)
('Carnegie',)
('NEB',)
*/

-- Prediction Query
SELECT DISTINCT building FROM Faculty;

/*
Prediction Result:
('NEB',)
('Carnegie',)
('Barton',)
*/