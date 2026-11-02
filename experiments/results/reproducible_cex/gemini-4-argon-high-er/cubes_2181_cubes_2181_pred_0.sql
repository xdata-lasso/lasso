-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'John', 20, 'M', 100, 200, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Doe', 'Jane', 20, 'F', 100, 200, 'LAX');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT stuid FROM (SELECT * FROM (SELECT * FROM (SELECT sex, stuid, MAX(age) AS maxage FROM student GROUP BY sex, stuid) ORDER BY maxage DESC) LIMIT 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT StuID FROM Student WHERE age = (SELECT MAX(age) FROM Student);

/*
Prediction Result:
(1,)
(2,)
*/