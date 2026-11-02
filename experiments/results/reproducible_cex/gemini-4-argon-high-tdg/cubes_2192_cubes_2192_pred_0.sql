-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Peanuts', 'Food');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Pollen', 'Environmental');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Penicillin', 'Drug');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'John', 18, 'M', 600, 1121, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Adams', 'Mary', 22, 'F', 600, 1121, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1003, 'Baker', 'Paul', 20, 'M', 520, 1148, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1004, 'Clark', 'Anna', 19, 'F', 520, 1148, 'CHI');
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Peanuts', 1001);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Pollen', 1001);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Penicillin', 1003);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Pollen', 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT city_code FROM student ORDER BY city_code;

/*
Gold Result:
('BOS',)
('CHI',)
('NYC',)
*/

-- Prediction Query
SELECT DISTINCT city_code FROM Student;

/*
Prediction Result:
('NYC',)
('BOS',)
('CHI',)
*/