-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('a1', NULL);
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('a2', 'Food');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergytype FROM (SELECT * FROM (SELECT * FROM (SELECT allergytype, COUNT(*) AS n FROM allergy_type GROUP BY allergytype) ORDER BY n) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT allergytype FROM Allergy_type GROUP BY allergytype ORDER BY COUNT(*) ASC, allergytype NULLS LAST LIMIT 1;

/*
Prediction Result:
('Food',)
*/