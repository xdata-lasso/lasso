-- Schema DDL
CREATE TABLE "Allergy_Type" ("Allergy" TEXT(20) PRIMARY KEY, "AllergyType" TEXT(20));

CREATE TABLE "Has_Allergy" ("Allergy" TEXT(20), "StuID" INTEGER, FOREIGN KEY ("Allergy") REFERENCES "Allergy_Type" ("Allergy"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Peanuts', 'Food');
INSERT INTO Allergy_Type (Allergy, AllergyType) VALUES ('Pollen', 'Environmental');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Adams', 'Zach', 20, 'M', 601, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Adams', 'Yuri', 21, 'M', 601, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Baker', 'Mary', 19, 'F', 602, 1003, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (4, 'Baker', 'Nina', 22, 'F', 602, 1003, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (5, 'Baker', 'Omar', 20, 'M', 602, 1004, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (6, 'Clark', 'Paul', 18, 'M', 603, 1005, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (7, 'Zeta', 'Aaron', 23, 'F', 604, 1006, 'MIA');
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Peanuts', 3);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Pollen', 4);
INSERT INTO Has_Allergy (Allergy, StuID) VALUES ('Peanuts', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM (SELECT * FROM (SELECT * FROM (SELECT lname, major, MAX(n) AS n FROM (SELECT lname, major, COUNT(*) AS n FROM student GROUP BY lname, major) GROUP BY lname, major) ORDER BY lname) LIMIT 1);

/*
Gold Result:
(601,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major ORDER BY COUNT(*) DESC, major NULLS LAST LIMIT 1;

/*
Prediction Result:
(602,)
*/