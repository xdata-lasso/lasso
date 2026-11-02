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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Bulldog');
INSERT INTO Sizes (size_code, size_description) VALUES ('S1', 'Small');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('TT1', 'Vaccine');
INSERT INTO Owners (owner_id, first_name, last_name) VALUES (1, 'John', 'Doe');
INSERT INTO Professionals (professional_id, role_code, first_name, last_name) VALUES (1, 'VET', 'Jane', 'Smith');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, date_arrived, date_adopted, date_departed, date_of_birth) VALUES (1, 1, 'S1', 'B1', '1', 'Rex', '2023-01-10', '2023-01-15', '2023-01-20', '2020-01-01');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, date_arrived, date_adopted, date_departed, date_of_birth) VALUES (2, 1, 'S1', 'B1', '0', 'Max', '2023-01-05', '2023-01-12', '2023-01-15', '2021-01-01');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, date_arrived, date_adopted, date_departed, date_of_birth) VALUES (3, 1, 'S1', 'B1', '1', 'UntreatedDog', '2023-01-01', '2023-01-02', '2023-01-03', '2019-01-01');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 1, 1, 'TT1', '2023-01-12', 50.0);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (2, 1, 1, 'TT1', '2023-01-14', 75.0);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (3, 2, 1, 'TT1', '2023-01-06', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT date_arrived, date_departed FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.owner_id AS owner_id, RHS.abandoned_yn AS abandoned_yn, RHS.breed_code AS breed_code, RHS.size_code AS size_code, RHS.name AS name, RHS.age AS age, RHS.date_of_birth AS date_of_birth, RHS.gender AS gender, RHS.weight AS weight, RHS.date_arrived AS date_arrived, RHS.date_adopted AS date_adopted, RHS.date_departed AS date_departed FROM treatments AS LHS INNER JOIN dogs AS RHS ON (LHS.dog_id = RHS.dog_id)) ORDER BY date_arrived, date_departed NULLS LAST;

/*
Gold Result:
('2023-01-05', '2023-01-15')
('2023-01-10', '2023-01-20')
*/

-- Prediction Query
SELECT DISTINCT T1.date_arrived, T1.date_departed FROM Dogs AS T1 JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id;

/*
Prediction Result:
('2023-01-10', '2023-01-20')
('2023-01-05', '2023-01-15')
*/