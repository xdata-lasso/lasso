-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Student (StuID, Advisor) VALUES (1, NULL);
INSERT INTO Student (StuID, Advisor) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT advisor FROM (SELECT * FROM (SELECT * FROM (SELECT advisor, MAX(n) AS n FROM (SELECT advisor, COUNT(*) AS n FROM student GROUP BY advisor) GROUP BY advisor) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT advisor FROM Student GROUP BY advisor ORDER BY COUNT(*) DESC, advisor NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/