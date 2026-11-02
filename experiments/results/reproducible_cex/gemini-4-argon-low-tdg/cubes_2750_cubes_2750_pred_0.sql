-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate ranks "Prof" and "Instructor")
-- 2. Missing ORDER BY or DESC ordering (inserted in unsorted order: Prof, AsstProf, Instructor, AssocProf)
-- 3. Unnecessary INNER JOIN with Faculty_Participates_in ("AsstProf" does not participate in any activity)
-- 4. Unnecessary INNER JOIN with Student via Advisor ("AssocProf" is not an advisor to any student)
-- 5. Hardcoded WHERE filters (e.g., Sex = 'M' or Sex = 'F')
INSERT INTO "Activity" ("actid", "activity_name") VALUES (1, 'Debate');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (1, 'Smith', 'John', 'Prof', 'M', 1111, '101', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (2, 'Doe', 'Jane', 'AsstProf', 'F', 2222, '102', 'Science');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (3, 'Brown', 'Bob', 'Prof', 'M', 3333, '103', 'Main');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (4, 'White', 'Alice', 'Instructor', 'F', 4444, '104', 'Arts');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (5, 'Green', 'Charlie', 'AssocProf', 'M', 5555, '105', 'Engineering');
INSERT INTO "Faculty" ("FacID", "Lname", "Fname", "Rank", "Sex", "Phone", "Room", "Building") VALUES (6, 'Black', 'Eve', 'Instructor', 'F', 6666, '106', 'Arts');
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 1);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 4);
INSERT INTO "Faculty_Participates_in" ("actid", "FacID") VALUES (1, 5);
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (101, 'Adams', 'Tom', 20, 'M', 600, 1, 'NYC');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (102, 'Baker', 'Sue', 21, 'F', 600, 2, 'LAX');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (103, 'Clark', 'Dan', 22, 'M', 600, 4, 'CHI');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT rank FROM faculty ORDER BY rank;

/*
Gold Result:
('AssocProf',)
('AsstProf',)
('Instructor',)
('Prof',)
*/

-- Prediction Query
SELECT DISTINCT rank FROM Faculty;

/*
Prediction Result:
('Prof',)
('AsstProf',)
('Instructor',)
('AssocProf',)
*/