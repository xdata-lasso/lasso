-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Zimmer', 'Charlie', 20, 'M', 600, 101, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Zebra', 'Alice', 19, 'F', 600, 101, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Apple', 'Alice', 21, 'F', 520, 102, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Baker', 'Bob', 22, 'M', 520, 102, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Baker', 'Bob', 20, 'M', 600, 103, 'SFO');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Peanuts', 'Food');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Pollen', 'Environmental');
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Peanuts', 1);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Pollen', 1);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Peanuts', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM student ORDER BY fname, student.stuid NULLS LAST;

/*
Gold Result:
('Alice', 'Zebra')
('Alice', 'Apple')
('Bob', 'Baker')
('Bob', 'Baker')
('Charlie', 'Zimmer')
*/

-- Prediction Query
SELECT Fname, Lname FROM Student;

/*
Prediction Result:
('Charlie', 'Zimmer')
('Alice', 'Zebra')
('Alice', 'Apple')
('Bob', 'Baker')
('Bob', 'Baker')
*/