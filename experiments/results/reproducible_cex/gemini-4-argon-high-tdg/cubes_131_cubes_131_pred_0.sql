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
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Alice', 'Smith', '10 Oak St', 'Austin', 'TX', '73301', 'alice.owner@mail.com', '512-111-1111', '512-999-1111');
INSERT INTO Sizes (size_code, size_description) VALUES ('S', 'Small');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('BEAG', 'Beagle');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('VACC', 'Vaccination');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (1, 1, 'S', 'BEAG', '0', 'Buddy', '3', '2020-01-01 00:00:00', 'M', '20', '2021-01-01 00:00:00', '2021-02-01 00:00:00', '2021-02-05 00:00:00');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (1, 'VET', 'Aaron', '100 First Ave', 'Dallas', 'TX', '75001', 'Zimmer', 'zoe@vetclinic.com', '214-100-0001', '214-900-0003');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (2, 'NURS', 'charlie', '200 Second Ave', 'Houston', 'TX', '77001', 'Baker', 'mike@vetclinic.com', '713-300-0003', '713-800-0001');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (3, 'VET', 'Beth', '300 Third Ave', 'Austin', 'TX', '73301', 'Adams', 'anna@vetclinic.com', '512-200-0002', '512-700-0002');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 1, 1, 'VACC', '2022-03-10 10:00:00', 50.0);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (2, 1, 1, 'VACC', '2022-09-10 10:00:00', 55.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, cell_number, home_phone FROM professionals ORDER BY email_address, professionals.professional_id NULLS LAST;

/*
Gold Result:
('anna@vetclinic.com', '512-700-0002', '512-200-0002')
('mike@vetclinic.com', '713-800-0001', '713-300-0003')
('zoe@vetclinic.com', '214-900-0003', '214-100-0001')
*/

-- Prediction Query
SELECT email_address, cell_number, home_phone FROM professionals;

/*
Prediction Result:
('zoe@vetclinic.com', '214-900-0003', '214-100-0001')
('mike@vetclinic.com', '713-800-0001', '713-300-0003')
('anna@vetclinic.com', '512-700-0002', '512-200-0002')
*/