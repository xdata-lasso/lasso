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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('ESK', 'Eskimo');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('HUS', 'Husky');
INSERT INTO Sizes (size_code, size_description) VALUES ('SML', 'Small');
INSERT INTO Sizes (size_code, size_description) VALUES ('LGE', 'Large');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Alice', 'Smith', '10 Main St', 'Austin', 'TX', '78701', 'alice@example.com', '512-111-2222', '512-333-4444');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (2, 'Bob', 'Jones', '20 Oak Ave', 'Dallas', 'TX', '75201', 'bob@example.com', '214-111-2222', '214-333-4444');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (1, 'VET', 'Carol', '30 Pine Rd', 'Austin', 'TX', '78702', 'White', 'carol@vet.com', '512-555-6666', '512-777-8888');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('VAC', 'Vaccination');
INSERT INTO Charges (charge_id, charge_type, charge_amount) VALUES (1, 'DAILY', 25.0000);
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (1, 1, 'SML', 'ESK', '0', 'Rex', '3', '2019-01-01', 'M', '15', '2022-05-10', '2022-06-01', '2022-06-05');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (2, 1, 'LGE', 'HUS', '1', 'Luna', '4', '2018-02-01', 'F', '45', '2021-01-15', '2021-08-01', '2021-09-20');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (3, 2, 'SML', 'ESK', '0', 'Max', '2', '2020-03-01', 'M', '18', '2021-01-15', '2021-02-10', '2021-03-01');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 1, 1, 'VAC', '2022-05-12', 50.0000);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (2, 1, 1, 'VAC', '2022-05-20', 75.0000);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (3, 2, 1, 'VAC', '2021-02-01', 60.0000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_arrived, date_departed FROM dogs ORDER BY date_arrived, dogs.dog_id NULLS LAST;

/*
Gold Result:
('2021-01-15', '2021-09-20')
('2021-01-15', '2021-03-01')
('2022-05-10', '2022-06-05')
*/

-- Prediction Query
SELECT date_arrived, date_departed FROM Dogs;

/*
Prediction Result:
('2022-05-10', '2022-06-05')
('2021-01-15', '2021-09-20')
('2021-01-15', '2021-03-01')
*/