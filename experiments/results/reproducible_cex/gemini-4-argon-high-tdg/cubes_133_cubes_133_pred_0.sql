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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Labrador');
INSERT INTO Sizes (size_code, size_description) VALUES ('S1', 'Medium');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Alice', 'Smith', '123 Maple St', 'Springfield', 'IL', '62701', 'alice@example.com', '555-0100', '555-0101');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (1, 1, 'S1', 'B1', '0', 'Buddy', '3', '2020-01-15', 'M', '45', '2021-01-01', '2021-02-01', '2021-02-02');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (1, 'VET', 'John', '456 Oak Ave', 'Springfield', 'IL', '62702', 'Doe', 'john@example.com', '555-0200', '555-0201');
INSERT INTO Charges (charge_id, charge_type, charge_amount) VALUES (1, 'T1', 999.99);
INSERT INTO Charges (charge_id, charge_type, charge_amount) VALUES (2, 'T2', 888.88);
INSERT INTO Charges (charge_id, charge_type, charge_amount) VALUES (3, 'T3', 777.77);
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T1', 'Vaccination');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T2', 'Checkup');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T3', 'Grooming');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T4', 'Surgery');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 1, 1, 'T1', '2023-03-10', 250.0);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (2, 1, 1, 'T1', '2023-03-11', 100.0);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (3, 1, 1, 'T2', '2023-03-12', 100.0);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (4, 1, 1, 'T3', '2023-03-13', 45.5);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (5, 1, 1, 'T3', '2023-03-14', 45.5);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (6, 1, 1, 'T2', '2023-03-15', 9.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cost_of_treatment, treatment_type_description FROM (SELECT LHS.treatment_type_code AS treatment_type_code, LHS.treatment_type_description AS treatment_type_description, RHS.treatment_id AS treatment_id, RHS.dog_id AS dog_id, RHS.professional_id AS professional_id, RHS.date_of_treatment AS date_of_treatment, RHS.cost_of_treatment AS cost_of_treatment FROM treatment_types AS LHS INNER JOIN treatments AS RHS ON (LHS.treatment_type_code = RHS.treatment_type_code)) ORDER BY cost_of_treatment, treatment_type_description NULLS LAST;

/*
Gold Result:
(9.99, 'Checkup')
(45.5, 'Grooming')
(45.5, 'Grooming')
(100.0, 'Checkup')
(100.0, 'Vaccination')
(250.0, 'Vaccination')
*/

-- Prediction Query
SELECT T1.cost_of_treatment, T2.treatment_type_description FROM Treatments AS T1 JOIN treatment_types AS T2 ON T1.treatment_type_code = T2.treatment_type_code;

/*
Prediction Result:
(250.0, 'Vaccination')
(100.0, 'Vaccination')
(100.0, 'Checkup')
(45.5, 'Grooming')
(45.5, 'Grooming')
(9.99, 'Checkup')
*/