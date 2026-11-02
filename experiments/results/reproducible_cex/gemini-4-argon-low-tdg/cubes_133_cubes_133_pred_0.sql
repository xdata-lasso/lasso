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
INSERT INTO Sizes (size_code, size_description) VALUES ('S1', 'Medium');
INSERT INTO Owners (owner_id, first_name, last_name) VALUES (1, 'John', 'Doe');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, name) VALUES (1, 1, 'S1', 'B1', 'Buddy');
INSERT INTO Professionals (professional_id, role_code, first_name, last_name) VALUES (1, 'VET', 'Jane', 'Smith');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T1', 'Vaccination');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T2', 'Surgery');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T3', 'Dental');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T4', 'Unmatched Type');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 1, 1, 'T1', '2023-01-01', 50.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (2, 1, 1, 'T1', '2023-01-02', 50.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (3, 1, 1, 'T2', '2023-01-03', 50.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (4, 1, 1, 'T3', '2023-01-04', 200.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (5, 1, 1, NULL, '2023-01-05', 100.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cost_of_treatment, treatment_type_description FROM (SELECT LHS.treatment_type_code AS treatment_type_code, LHS.treatment_type_description AS treatment_type_description, RHS.treatment_id AS treatment_id, RHS.dog_id AS dog_id, RHS.professional_id AS professional_id, RHS.date_of_treatment AS date_of_treatment, RHS.cost_of_treatment AS cost_of_treatment FROM treatment_types AS LHS INNER JOIN treatments AS RHS ON (LHS.treatment_type_code = RHS.treatment_type_code)) ORDER BY cost_of_treatment, treatment_type_description NULLS LAST;

/*
Gold Result:
(50.0, 'Surgery')
(50.0, 'Vaccination')
(50.0, 'Vaccination')
(200.0, 'Dental')
*/

-- Prediction Query
SELECT T1.cost_of_treatment, T2.treatment_type_description FROM Treatments AS T1 JOIN treatment_types AS T2 ON T1.treatment_type_code = T2.treatment_type_code;

/*
Prediction Result:
(50.0, 'Vaccination')
(50.0, 'Vaccination')
(50.0, 'Surgery')
(200.0, 'Dental')
*/