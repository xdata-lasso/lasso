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
-- Tests basic OR condition (Hawaii vs Wisconsin), exclusion of other states, and DISTINCT vs ALL with duplicate email_address values.
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1, 'VET', 'John', '123 Main', 'Honolulu', 'Hawaii', '96801', 'Doe', 'zack@vet.com', '111-2222', '333-4444');
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (2, 'VET', 'Jane', '456 Oak', 'Madison', 'Wisconsin', '53701', 'Smith', 'alice@vet.com', '222-3333', '444-5555');
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (3, 'ASS', 'Bob', '789 Pine', 'Milwaukee', 'Wisconsin', '53201', 'Brown', 'alice@vet.com', '333-4444', '555-6666');
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (4, 'VET', 'Eve', '101 Maple', 'Austin', 'Texas', '73301', 'White', 'eve@vet.com', '444-5555', '666-7777');
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (5, 'VET', 'Charlie', '202 Birch', 'Chicago', 'Illinois', '60601', 'Green', 'charlie@vet.com', '555-6666', '777-8888');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "email_address" FROM "professionals" WHERE ("state" = 'Hawaii' OR "state" = 'Wisconsin') ORDER BY email_address, professionals.professional_id NULLS LAST;

/*
Gold Result:
('alice@vet.com',)
('alice@vet.com',)
('zack@vet.com',)
*/

-- Prediction Query
SELECT email_address FROM Professionals WHERE state = 'Hawaii' OR state = 'Wisconsin';

/*
Prediction Result:
('zack@vet.com',)
('alice@vet.com',)
('alice@vet.com',)
*/