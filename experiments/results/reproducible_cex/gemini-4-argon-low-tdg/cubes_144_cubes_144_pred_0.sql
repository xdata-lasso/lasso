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
-- DATASET 2
-- Tests duplicate rows in projection (DISTINCT vs ALL) and secondary sorting on dog_id when name is tied.
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Poodle');
INSERT INTO Sizes (size_code, size_description) VALUES ('M1', 'Medium');
INSERT INTO Owners (owner_id, first_name, last_name) VALUES (1, 'Jane', 'Smith');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, weight) VALUES (30, 1, 'M1', 'B1', '1', 'Bella', '4', '20');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, weight) VALUES (10, 1, 'M1', 'B1', '1', 'Bella', '4', '20');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, weight) VALUES (20, 1, 'M1', 'B1', '1', 'Bella', '2', '18');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, weight) VALUES (5, 1, 'M1', 'B1', '1', 'Lucy', '7', '35');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, weight) VALUES (40, 1, 'M1', 'B1', '1', 'Alpha', '1', '12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age, weight FROM dogs WHERE (abandoned_yn = 1) ORDER BY name, dogs.dog_id NULLS LAST;

/*
Gold Result:
('Alpha', '1', '12')
('Bella', '4', '20')
('Bella', '2', '18')
('Bella', '4', '20')
('Lucy', '7', '35')
*/

-- Prediction Query
SELECT name, age, weight FROM Dogs WHERE abandoned_yn = 1;

/*
Prediction Result:
('Lucy', '7', '35')
('Bella', '4', '20')
('Bella', '2', '18')
('Bella', '4', '20')
('Alpha', '1', '12')
*/