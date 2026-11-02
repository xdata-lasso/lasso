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
-- Tests basic ordering by date_arrived, secondary tie-breaking by dog_id, and duplicate row preservation (SELECT vs SELECT DISTINCT).
INSERT INTO "Breeds" ("breed_code", "breed_name") VALUES ('B1', 'Bulldog');
INSERT INTO "Sizes" ("size_code", "size_description") VALUES ('S1', 'Medium');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name") VALUES (1, 'John', 'Doe');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1, 1, 'S1', 'B1', '0', 'Max', '3', '2020-01-01', 'M', '20', '2023-05-01', '2023-05-05', '2023-05-10');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (2, 1, 'S1', 'B1', '0', 'Bella', '2', '2021-02-01', 'F', '15', '2023-01-15', '2023-01-20', '2023-01-25');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (3, 1, 'S1', 'B1', '0', 'Charlie', '4', '2019-03-01', 'M', '25', '2023-03-10', '2023-03-15', '2023-03-20');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (4, 1, 'S1', 'B1', '0', 'Lucy', '1', '2022-04-01', 'F', '10', '2023-03-10', '2023-03-15', '2023-03-20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_arrived, date_departed FROM dogs ORDER BY date_arrived, dogs.dog_id NULLS LAST;

/*
Gold Result:
('2023-01-15', '2023-01-25')
('2023-03-10', '2023-03-20')
('2023-03-10', '2023-03-20')
('2023-05-01', '2023-05-10')
*/

-- Prediction Query
SELECT date_arrived, date_departed FROM Dogs;

/*
Prediction Result:
('2023-05-01', '2023-05-10')
('2023-01-15', '2023-01-25')
('2023-03-10', '2023-03-20')
('2023-03-10', '2023-03-20')
*/