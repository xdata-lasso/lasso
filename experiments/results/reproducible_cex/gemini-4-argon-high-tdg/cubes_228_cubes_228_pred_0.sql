-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Has_Pet" ("StuID" INTEGER, "PetID" INTEGER, FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"), FOREIGN KEY ("PetID") REFERENCES "Pets" ("PetID"));

CREATE TABLE "Pets" ("PetID" INTEGER PRIMARY KEY, "PetType" TEXT(20), "pet_age" INTEGER, "weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (101, 'Smith', 'Anna', 20, 'F', 600, 1121, 'NYC');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (102, 'Kim', 'David', 20, 'M', 601, 1122, 'LAX');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (103, 'Lee', 'Sarah', 20, 'F', 602, 1123, 'CHI');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (104, 'Brown', 'Tom', 19, 'M', 20, 20, 'BOS');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (105, 'Davis', 'Emma', 21, 'F', 603, 1124, 'SEA');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (106, 'Wilson', 'Luke', 23, 'M', 604, 1125, 'DEN');
INSERT INTO Student (StuID, LName, Fname, Age, Sex, Major, Advisor, city_code) VALUES (20, 'Taylor', 'Mia', 22, 'F', 605, 1126, 'MIA');
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (501, 'dog', 3, 25.5);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (502, 'cat', 5, 9.2);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (503, 'bird', 2, 0.8);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (504, 'dog', 4, 30.0);
INSERT INTO Pets (PetID, PetType, pet_age, weight) VALUES (20, 'cat', 20, 20.0);
INSERT INTO Has_Pet (StuID, PetID) VALUES (101, 501);
INSERT INTO Has_Pet (StuID, PetID) VALUES (101, 502);
INSERT INTO Has_Pet (StuID, PetID) VALUES (102, 503);
INSERT INTO Has_Pet (StuID, PetID) VALUES (104, 20);
INSERT INTO Has_Pet (StuID, PetID) VALUES (105, 501);
INSERT INTO Has_Pet (StuID, PetID) VALUES (105, 504);
INSERT INTO Has_Pet (StuID, PetID) VALUES (106, 502);
INSERT INTO Has_Pet (StuID, PetID) VALUES (20, 503);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT stuid FROM student WHERE (age = 20) INTERSECT SELECT stuid FROM has_pet)) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM student AS T1 JOIN has_pet AS T2 ON T1.stuid = T2.stuid WHERE T1.age > 20;

/*
Prediction Result:
(4,)
*/