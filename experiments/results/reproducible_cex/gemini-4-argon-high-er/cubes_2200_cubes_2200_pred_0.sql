-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Allergy_Type" ("Allergy", "AllergyType") VALUES ('Peanuts', 'Food');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (1, 'Smith', 'John', 20, 'M', 100, 200, 'NYC');
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES (NULL, 1);
INSERT INTO "Has_Allergy" ("Allergy", "StuID") VALUES ('Peanuts', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT allergy FROM (SELECT * FROM (SELECT * FROM (SELECT allergy, COUNT(*) AS n FROM has_allergy GROUP BY allergy) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Allergy FROM Has_allergy GROUP BY Allergy ORDER BY COUNT(*) DESC, Allergy NULLS LAST LIMIT 1;

/*
Prediction Result:
('Peanuts',)
*/