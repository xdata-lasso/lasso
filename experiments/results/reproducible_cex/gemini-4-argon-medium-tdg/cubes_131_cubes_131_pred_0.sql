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
-- Tests basic ordering by email_address, column projection order, and decoupling from Owners table.
INSERT INTO Owners (owner_id, first_name, last_name, email_address, home_phone, cell_number) VALUES (1, 'OwnerA', 'LastA', 'owner1@example.com', '111-111-1111', '999-999-9991');
INSERT INTO Owners (owner_id, first_name, last_name, email_address, home_phone, cell_number) VALUES (2, 'OwnerB', 'LastB', 'owner2@example.com', '111-111-1112', '999-999-9992');
INSERT INTO Professionals (professional_id, role_code, first_name, last_name, email_address, home_phone, cell_number) VALUES (10, 'VET', 'John', 'Doe', 'z_john@vet.com', '555-1001', '555-2001');
INSERT INTO Professionals (professional_id, role_code, first_name, last_name, email_address, home_phone, cell_number) VALUES (20, 'ASS', 'Jane', 'Smith', 'a_jane@vet.com', '555-1002', '555-2002');
INSERT INTO Professionals (professional_id, role_code, first_name, last_name, email_address, home_phone, cell_number) VALUES (30, 'VET', 'Bob', 'Brown', 'm_bob@vet.com', '555-1003', '555-2003');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address, cell_number, home_phone FROM professionals ORDER BY email_address, professionals.professional_id NULLS LAST;

/*
Gold Result:
('a_jane@vet.com', '555-2002', '555-1002')
('m_bob@vet.com', '555-2003', '555-1003')
('z_john@vet.com', '555-2001', '555-1001')
*/

-- Prediction Query
SELECT email_address, cell_number, home_phone FROM professionals;

/*
Prediction Result:
('z_john@vet.com', '555-2001', '555-1001')
('a_jane@vet.com', '555-2002', '555-1002')
('m_bob@vet.com', '555-2003', '555-1003')
*/