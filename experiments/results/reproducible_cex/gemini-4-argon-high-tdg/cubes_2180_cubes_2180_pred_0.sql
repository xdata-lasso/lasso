-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Eggs', 'Animal');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Bees', 'Viral');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Cats', 'Viral');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Almonds', 'Food');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Milk', 'Food');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Z_Pollen', 'Viral');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Smith', 'John', 20, 'M', 600, 1121, 'BAL');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Doe', 'Jane', 22, 'F', 600, 1121, 'NYC');
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Eggs', 101);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Bees', 101);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Z_Pollen', 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergytype FROM (SELECT * FROM (SELECT * FROM (SELECT allergy, allergytype, COUNT(*) OVER () AS n FROM allergy_type) ORDER BY allergy) LIMIT 1);

/*
Gold Result:
('Food',)
*/

-- Prediction Query
SELECT allergytype FROM Allergy_type GROUP BY allergytype ORDER BY COUNT(*) DESC, allergytype NULLS LAST LIMIT 1;

/*
Prediction Result:
('Viral',)
*/