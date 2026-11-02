-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (1, 'Smith', 'Zack', 22, 'M', 101, 1001, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (2, 'Jones', 'Alice', 19, 'F', 102, 1002, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (3, 'Brown', 'Charlie', 25, 'M', 103, 1003, 'CHI');
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (3, 'Dog', 4, 25.5);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (4, 'Cat', 2, 8.0);
INSERT INTO Has_Pet (StuID, PetID) VALUES (1, 3);
INSERT INTO Has_Pet (StuID, PetID) VALUES (1, 4);
INSERT INTO Has_Pet (StuID, PetID) VALUES (2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT fname, age FROM (SELECT LHS.stuid AS stuid, LHS.petid AS petid, RHS.lname AS lname, RHS.fname AS fname, RHS.age AS age, RHS.sex AS sex, RHS.major AS major, RHS.advisor AS advisor, RHS.city_code AS city_code FROM has_pet AS LHS INNER JOIN student AS RHS ON (LHS.stuid = RHS.stuid)) ORDER BY fname, age NULLS LAST;

/*
Gold Result:
('Alice', 19)
('Zack', 22)
*/

-- Prediction Query
SELECT DISTINCT T1.fname, T1.age FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid;

/*
Prediction Result:
('Zack', 22)
('Alice', 19)
*/