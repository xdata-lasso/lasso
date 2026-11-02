-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Anchovies', 'Food');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Wheat', 'Food');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Bee', 'Insect');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Cat', 'Animal');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Dog', 'Animal');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Ragweed', 'Environmental');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Penicillin', 'Drug');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1001, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1002, 'Doe', 'Jane', 19, 'F', 520, 1148, 'NYC');
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Anchovies', 1001);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Anchovies', 1002);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Cat', 1001);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Dog', 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT allergytype FROM allergy_type ORDER BY allergytype;

/*
Gold Result:
('Animal',)
('Drug',)
('Environmental',)
('Food',)
('Insect',)
*/

-- Prediction Query
SELECT DISTINCT allergytype FROM Allergy_type;

/*
Prediction Result:
('Food',)
('Insect',)
('Animal',)
('Environmental',)
('Drug',)
*/