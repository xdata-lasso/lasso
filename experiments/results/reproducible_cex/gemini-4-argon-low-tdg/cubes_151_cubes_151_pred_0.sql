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
-- Tests basic intersection, difference (Professional only vs Owner only), duplicates (DISTINCT vs ALL), and NULL state handling.
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1, 'Alice', 'Smith', '100 Main St', 'Los Angeles', 'CA', '90001', 'alice@example.com', '111-1111', '222-2222');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (2, 'Bob', 'Jones', '101 Main St', 'San Diego', 'CA', '92101', 'bob@example.com', '111-1112', '222-2223');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (3, 'Charlie', 'Brown', '200 Oak St', 'Houston', 'TX', '77001', 'charlie@example.com', '111-1113', '222-2224');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (4, 'David', 'Wilson', '300 Pine St', 'Seattle', NULL, '98101', 'david@example.com', '111-1114', '222-2225');
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1, 'VET', 'Eve', '400 Elm St', 'San Francisco', 'CA', '94101', 'Davis', 'eve@example.com', '333-3331', '444-4441');
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (2, 'VET', 'Frank', '401 Elm St', 'Sacramento', 'CA', '95814', 'Miller', 'frank@example.com', '333-3332', '444-4442');
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (3, 'GROM', 'Grace', '500 Maple St', 'New York', 'NY', '10001', 'Taylor', 'grace@example.com', '333-3333', '444-4443');
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (4, 'GROM', 'Heidi', '600 Cedar St', 'Boston', NULL, '02101', 'Anderson', 'heidi@example.com', '333-3334', '444-4444');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT state FROM (SELECT LHS.professional_id AS professional_id, LHS.role_code AS role_code, LHS.first_name AS first_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.last_name AS last_name, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number, RHS.owner_id AS owner_id, RHS.first_name AS first_name_other, RHS.last_name AS last_name_other, RHS.street AS street_other, RHS.city AS city_other, RHS.zip_code AS zip_code_other, RHS.email_address AS email_address_other, RHS.home_phone AS home_phone_other, RHS.cell_number AS cell_number_other FROM professionals AS LHS INNER JOIN owners AS RHS ON (LHS.state = RHS.state)) ORDER BY state;

/*
Gold Result:
('CA',)
*/

-- Prediction Query
SELECT state FROM Owners INTERSECT SELECT state FROM Professionals;

/*
Prediction Result:
(None,)
('CA',)
*/