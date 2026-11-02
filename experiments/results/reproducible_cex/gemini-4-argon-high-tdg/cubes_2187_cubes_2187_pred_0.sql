-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Pollen', 'environmental');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Cat', 'animal');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Milk', 'food');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Dog', 'animal');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Eggs', 'food');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'Linda', 18, 'F', 600, 1121, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Kim', 'Tracy', 19, 'F', 600, 7712, 'HKG');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1003, 'Jones', 'Shiela', 21, 'F', 600, 7792, 'WAS');
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Cat', 1001);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Cat', 1002);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Milk', 1001);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Pollen', 1002);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergy, allergytype FROM allergy_type ORDER BY allergy;

/*
Gold Result:
('Cat', 'animal')
('Dog', 'animal')
('Eggs', 'food')
('Milk', 'food')
('Pollen', 'environmental')
*/

-- Prediction Query
SELECT allergy, allergytype FROM Allergy_type;

/*
Prediction Result:
('Pollen', 'environmental')
('Cat', 'animal')
('Milk', 'food')
('Dog', 'animal')
('Eggs', 'food')
*/