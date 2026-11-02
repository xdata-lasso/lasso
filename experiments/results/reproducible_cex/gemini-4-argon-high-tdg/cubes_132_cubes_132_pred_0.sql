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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B_ZEB', 'Zebra Hound');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B_ALP', 'Alpha Terrier');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B_MID', 'Middle Spaniel');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B_UNUSED', 'Unused Breed');
INSERT INTO Sizes (size_code, size_description) VALUES ('S_3', 'Large');
INSERT INTO Sizes (size_code, size_description) VALUES ('S_1', 'Small');
INSERT INTO Sizes (size_code, size_description) VALUES ('S_2', 'Medium');
INSERT INTO Sizes (size_code, size_description) VALUES ('S_UNUSED', 'Unused Size');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Alice', 'Smith', '123 Main St', 'Austin', 'TX', '78701', 'alice@example.com', '555-0101', '555-0102');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (2, 'Bob', 'Jones', '456 Oak Ave', 'Dallas', 'TX', '75201', 'bob@example.com', '555-0201', '555-0202');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (1, 1, 'S_2', 'B_ZEB', '1', 'Rex', '4', '2019-05-01', 'M', '45', '2020-01-10', '2020-02-15', '2020-02-16');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (2, 1, 'S_3', 'B_ALP', '0', 'Bella', '2', '2021-03-12', 'F', '60', '2021-06-01', '2021-07-01', '2021-07-02');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (3, 2, 'S_1', 'B_ALP', '1', 'Max', '5', '2018-11-20', 'M', '15', '2019-04-01', '2019-05-01', '2019-05-02');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (4, 2, 'S_3', 'B_ALP', '0', 'Lucy', '3', '2020-08-15', 'F', '62', '2021-01-10', '2021-03-10', '2021-03-11');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (5, 1, 'S_1', 'B_MID', '0', 'Charlie', '1', '2022-01-01', 'M', '12', '2022-03-01', '2022-04-01', '2022-04-02');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (1, 'VET', 'Sarah', '789 Pine Rd', 'Austin', 'TX', '78702', 'connor', 'sarah@vet.com', '555-0301', '555-0302');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('VAC', 'Vaccination');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 1, 1, 'VAC', '2020-01-15', 50.0000);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (2, 1, 1, 'VAC', '2020-02-01', 75.0000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT breed_code, size_code FROM dogs ORDER BY breed_code, size_code NULLS LAST;

/*
Gold Result:
('B_ALP', 'S_1')
('B_ALP', 'S_3')
('B_MID', 'S_1')
('B_ZEB', 'S_2')
*/

-- Prediction Query
SELECT DISTINCT breed_code, size_code FROM dogs;

/*
Prediction Result:
('B_ZEB', 'S_2')
('B_ALP', 'S_3')
('B_ALP', 'S_1')
('B_MID', 'S_1')
*/