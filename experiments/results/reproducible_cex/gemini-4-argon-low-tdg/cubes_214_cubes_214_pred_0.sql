-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Taylor', 'David', 21, 'M', 201, 2001, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Wilson', 'David', 21, 'M', 202, 2002, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (103, 'Davis', 'David', 18, 'M', 201, 2001, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (104, 'Miller', 'Eva', 21, 'F', 203, 2003, 'MIA');
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (201, 'Dog', 21, 30.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (202, 'Cat', 2, 8.5);
INSERT INTO Has_Pet (StuID, PetID) VALUES (101, 201);
INSERT INTO Has_Pet (StuID, PetID) VALUES (102, 202);
INSERT INTO Has_Pet (StuID, PetID) VALUES (103, 201);
INSERT INTO Has_Pet (StuID, PetID) VALUES (104, 202);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT fname, age FROM (SELECT LHS.stuid AS stuid, LHS.petid AS petid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.advisor AS advisor, RHS.city_code AS city_code FROM has_pet AS LHS INNER JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY fname, age NULLS LAST;

/*
Gold Result:
('David', 18)
('David', 21)
('Eva', 21)
*/

-- Prediction Query
SELECT DISTINCT T1.fname, T1.age FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid;

/*
Prediction Result:
('David', 21)
('David', 18)
('Eva', 21)
*/