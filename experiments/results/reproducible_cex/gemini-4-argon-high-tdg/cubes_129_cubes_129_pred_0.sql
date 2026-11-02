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
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Alice', 'Smith', '100 Palm St', 'Honolulu', 'Hawaii', '96801', 'owner_hi@example.com', '808-111-2222', '808-111-3333');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (2, 'Bob', 'Jones', '200 Lake Rd', 'Madison', 'Wisconsin', '53701', 'owner_wi@example.com', '608-222-3333', '608-222-4444');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (1, 'VET', 'Zack', '10 Aloha Way', 'Honolulu', 'Hawaii', '96815', 'Miller', 'zack@alohavet.com', '808-555-0101', '808-555-0102');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (2, 'VET', 'Amy', '20 Sunset Blvd', 'Los Angeles', 'California', '90001', 'Davis', 'amy@calvet.com', '213-555-0101', '213-555-0102');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (3, 'NRS', 'Bella', '30 Dairy Ln', 'Milwaukee', 'Wisconsin', '53201', 'Wilson', 'bella@badgervet.com', '414-555-0101', '414-555-0102');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (4, 'GROOM', 'Mark', '40 Beach Rd', 'Maui', 'Hawaii', '96761', 'Taylor', 'mark@islandvet.com', '808-555-0201', '808-555-0202');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (5, 'VET', 'Carl', '50 Pine St', 'Green Bay', 'WI', '54301', 'Moore', 'carl@abbrwi.com', '920-555-0101', '920-555-0102');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (6, 'VET', 'Dana', '60 Kona St', 'Kona', 'HI', '96740', 'White', 'dana@abbrhi.com', '808-555-0301', '808-555-0302');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "email_address" FROM "professionals" WHERE ("state" = 'Hawaii' OR "state" = 'Wisconsin') ORDER BY email_address, professionals.professional_id NULLS LAST;

/*
Gold Result:
('bella@badgervet.com',)
('mark@islandvet.com',)
('zack@alohavet.com',)
*/

-- Prediction Query
SELECT email_address FROM Professionals WHERE state = 'Hawaii' OR state = 'Wisconsin';

/*
Prediction Result:
('zack@alohavet.com',)
('bella@badgervet.com',)
('mark@islandvet.com',)
*/