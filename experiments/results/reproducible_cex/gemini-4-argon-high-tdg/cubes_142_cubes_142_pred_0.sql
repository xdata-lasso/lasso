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
-- DATASET 3
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Poodle');
INSERT INTO Sizes (size_code, size_description) VALUES ('S1', 'Large');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Paul', 'Atreides', '1 Dune Way', 'Arrakis', 'AZ', '85001', 'paul@example.com', '555-2000', '555-2001');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (1, 1, 'S1', 'B1', '0', 'Rex', '4', '2019-03-15 00:00:00', 'M', '60', '2020-01-01 00:00:00', '2020-03-01 00:00:00', '2020-03-02 00:00:00');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T1', 'Zoonosis Test');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T2', 'Allergy Shot');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T3', 'Blood Work');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T4', 'Dental Cleaning');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T5', 'Acupuncture');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (1, 'VET', 'Zoe', '99 West St', 'Phoenix', 'AZ', '85002', 'Alpha', 'zoe@vet.com', '555-3001', '555-3002');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (2, 'VET', 'Adam', '12 East St', 'Phoenix', 'AZ', '85003', 'Zulu', 'adam@vet.com', '555-3003', '555-3004');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (3, 'NURSE', 'Mia', '45 North St', 'Phoenix', 'AZ', '85004', 'Middle', 'mia@vet.com', '555-3005', '555-3006');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 1, 1, 'T3', '2023-05-01 10:00:00', 75.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (2, 1, 2, 'T1', '2023-05-02 10:00:00', 110.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (3, 1, 2, 'T2', '2023-05-03 10:00:00', 60.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (4, 1, 2, 'T3', '2023-05-04 10:00:00', 75.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (5, 1, 3, 'T4', '2023-05-05 10:00:00', 90.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (6, 1, 3, 'T5', '2023-05-06 10:00:00', 85.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT first_name, treatment_type_description FROM (SELECT LHS.treatment_type_code AS treatment_type_code, LHS.treatment_type_description AS treatment_type_description, LHS.professional_id AS professional_id, LHS.role_code AS role_code, LHS.first_name AS first_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.last_name AS last_name, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number, RHS.treatment_id AS treatment_id, RHS.dog_id AS dog_id, RHS.date_of_treatment AS date_of_treatment, RHS.cost_of_treatment AS cost_of_treatment FROM (SELECT LHS.treatment_type_code AS treatment_type_code, LHS.treatment_type_description AS treatment_type_description, RHS.professional_id AS professional_id, RHS.role_code AS role_code, RHS.first_name AS first_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.last_name AS last_name, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM treatment_types AS LHS CROSS JOIN professionals AS RHS) AS LHS INNER JOIN treatments AS RHS ON (LHS.treatment_type_code = RHS.treatment_type_code AND LHS.professional_id = RHS.professional_id)) ORDER BY first_name, treatment_type_description NULLS LAST;

/*
Gold Result:
('Adam', 'Allergy Shot')
('Adam', 'Blood Work')
('Adam', 'Zoonosis Test')
('Mia', 'Acupuncture')
('Mia', 'Dental Cleaning')
('Zoe', 'Blood Work')
*/

-- Prediction Query
SELECT DISTINCT T1.first_name, T3.treatment_type_description FROM professionals AS T1 JOIN Treatments AS T2 ON T1.professional_id = T2.professional_id JOIN Treatment_types AS T3 ON T2.treatment_type_code = T3.treatment_type_code;

/*
Prediction Result:
('Zoe', 'Blood Work')
('Adam', 'Zoonosis Test')
('Adam', 'Allergy Shot')
('Adam', 'Blood Work')
('Mia', 'Dental Cleaning')
('Mia', 'Acupuncture')
*/