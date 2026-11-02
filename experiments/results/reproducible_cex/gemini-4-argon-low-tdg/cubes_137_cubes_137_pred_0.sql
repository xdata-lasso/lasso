-- Schema DDL
CREATE TABLE "Breeds" ("breed_code" TEXT(10) PRIMARY KEY, "breed_name" TEXT(80));

CREATE TABLE "Charges" ("charge_id" INTEGER PRIMARY KEY, "charge_type" TEXT(10), "charge_amount" REAL(19, 4));

CREATE TABLE "Sizes" ("size_code" TEXT(10) PRIMARY KEY, "size_description" TEXT(80));

CREATE TABLE "Treatment_Types" ("treatment_type_code" TEXT(10) PRIMARY KEY, "treatment_type_description" TEXT(80));

CREATE TABLE "Owners" ("owner_id" INTEGER PRIMARY KEY, "first_name" TEXT(50), "last_name" TEXT(50), "street" TEXT(50), "city" TEXT(50), "state" TEXT(20), "zip_code" TEXT(20), "email_address" TEXT(50), "home_phone" TEXT(20), "cell_number" TEXT(20));

CREATE TABLE "Dogs" ("dog_id" INTEGER PRIMARY KEY, "owner_id" INTEGER, "size_code" TEXT(10), "breed_code" TEXT(10), "abandoned_yn" TEXT(1), "name" TEXT(50), "age" TEXT(20), "date_of_birth" DATETIME, "gender" TEXT(1), "weight" TEXT(20), "date_arrived" DATETIME, "date_adopted" DATETIME, "date_departed" DATETIME, FOREIGN KEY ("owner_id") REFERENCES "Owners" ("owner_id"), FOREIGN KEY ("size_code") REFERENCES "Sizes" ("size_code"), FOREIGN KEY ("breed_code") REFERENCES "Breeds" ("breed_code"));

CREATE TABLE "Professionals" ("professional_id" INTEGER PRIMARY KEY, "role_code" TEXT(10), "first_name" TEXT(50), "street" TEXT(50), "city" TEXT(50), "state" TEXT(20), "zip_code" TEXT(20), "last_name" TEXT(50), "email_address" TEXT(50), "home_phone" TEXT(20), "cell_number" TEXT(20));

CREATE TABLE "Treatments" ("treatment_id" INTEGER PRIMARY KEY, "dog_id" INTEGER, "professional_id" INTEGER, "treatment_type_code" TEXT(10), "date_of_treatment" DATETIME, "cost_of_treatment" REAL(19, 4), FOREIGN KEY ("dog_id") REFERENCES "Dogs" ("dog_id"), FOREIGN KEY ("professional_id") REFERENCES "Professionals" ("professional_id"), FOREIGN KEY ("treatment_type_code") REFERENCES "Treatment_Types" ("treatment_type_code"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- General case: Multiple breeds and dogs where the earliest date_adopted is distinct from the earliest date_arrived, date_departed, date_of_birth, dog_id, and breed_code.
-- Also includes an unreferenced breed to ensure INNER JOIN vs LEFT JOIN mutants on Breeds are caught.
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B01', 'Zebra Hound');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B02', 'Beagle');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B03', 'Pug');
INSERT INTO Sizes (size_code, size_description) VALUES ('S01', 'Medium');
INSERT INTO Owners (owner_id, first_name, last_name) VALUES (1, 'Alice', 'Smith');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed)
VALUES (10, 1, 'S01', 'B02', '0', 'Buddy', '5', '2018-01-01 00:00:00', 'M', '20', '2019-01-01 00:00:00', '2022-05-01 00:00:00', '2020-01-01 00:00:00');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed)
VALUES (20, 1, 'S01', 'B03', '1', 'Max', '3', '2020-01-01 00:00:00', 'F', '15', '2020-06-01 00:00:00', '2021-01-01 00:00:00', '2023-01-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT breed_name FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, LHS.breed_name AS breed_name, RHS.n AS n FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.breed_name AS breed_name FROM dogs AS LHS INNER JOIN breeds AS RHS ON (LHS.breed_code = RHS.breed_code)) AS LHS INNER JOIN (SELECT breed_code, breed_name, COUNT(*) OVER () AS n FROM breeds) AS RHS ON (LHS.breed_code = RHS.breed_code AND LHS.breed_name = RHS.breed_name)) ORDER BY date_adopted) LIMIT 1);

/*
Gold Result:
('Pug',)
*/

-- Prediction Query
SELECT T1.breed_name FROM Breeds AS T1 JOIN Dogs AS T2 ON T1.breed_code = T2.breed_code GROUP BY T1.breed_name ORDER BY COUNT(*) DESC, T1.breed_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beagle',)
*/