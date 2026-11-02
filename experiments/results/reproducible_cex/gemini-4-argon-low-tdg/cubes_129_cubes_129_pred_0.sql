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
INSERT INTO Professionals (professional_id, role_code, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'VET', 'John', 'Doe', '123 Aloha St', 'Honolulu', 'Hawaii', '96801', 'z_john@example.com', '808-111-1111', '808-111-1112');
INSERT INTO Professionals (professional_id, role_code, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (2, 'VET', 'Jane', 'Smith', '456 Cheese Way', 'Madison', 'Wisconsin', '53701', 'a_jane@example.com', '608-222-2222', '608-222-2223');
INSERT INTO Professionals (professional_id, role_code, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (3, 'GROOM', 'Bob', 'Johnson', '789 Pine Rd', 'Austin', 'Texas', '73301', 'm_bob@example.com', '512-333-3333', '512-333-3334');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Owner', 'One', '111 Main St', 'Honolulu', 'Hawaii', '96801', 'owner_hi@example.com', '808-999-9999', '808-999-9998');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (2, 'Owner', 'Two', '222 Main St', 'Madison', 'Wisconsin', '53701', 'owner_wi@example.com', '608-888-8888', '608-888-8887');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "email_address" FROM "professionals" WHERE ("state" = 'Hawaii' OR "state" = 'Wisconsin') ORDER BY email_address, professionals.professional_id NULLS LAST;

/*
Gold Result:
('a_jane@example.com',)
('z_john@example.com',)
*/

-- Prediction Query
SELECT email_address FROM Professionals WHERE state = 'Hawaii' OR state = 'Wisconsin';

/*
Prediction Result:
('z_john@example.com',)
('a_jane@example.com',)
*/