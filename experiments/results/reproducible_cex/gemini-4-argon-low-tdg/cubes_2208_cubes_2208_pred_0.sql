-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY city_code ASC vs DESC, and DISTINCT vs ALL (duplicate city_codes for 'Kim')
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (203, 'Kim', 'David', 22, 'M', 600, 1121, 'SFO');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (201, 'Kim', 'Eva', 19, 'F', 500, 1122, 'ATL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (202, 'Kim', 'Frank', 20, 'M', 600, 1121, 'DEN');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (204, 'Kim', 'Grace', 21, 'F', 500, 1122, 'ATL');
INSERT INTO "Student" ("StuID", "LName", "Fname", "Age", "Sex", "Major", "Advisor", "city_code") VALUES (205, 'Lee', 'Henry', 23, 'M', 600, 1121, 'SEA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city_code" FROM "student" WHERE ("lname" = 'Kim') ORDER BY city_code, student.stuid NULLS LAST;

/*
Gold Result:
('ATL',)
('ATL',)
('DEN',)
('SFO',)
*/

-- Prediction Query
SELECT city_code FROM Student WHERE LName = 'Kim';

/*
Prediction Result:
('ATL',)
('DEN',)
('SFO',)
('ATL',)
*/