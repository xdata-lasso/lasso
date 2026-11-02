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
-- Tests INNER JOIN vs LEFT/RIGHT/FULL OUTER JOIN, duplicate output rows (DISTINCT vs ALL), and basic two-column ORDER BY
INSERT INTO "Breeds" ("breed_code", "breed_name") VALUES ('B1', 'Poodle');
INSERT INTO "Sizes" ("size_code", "size_description") VALUES ('S1', 'Small');
-- Owner 1 has multiple dogs (including two with the exact same name to test DISTINCT)
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1, 'Alice', 'Smith', '123 Maple', 'Austin', 'TX', '78701', 'alice@example.com', '555-0101', '555-0102');
-- Owner 2 has one dog
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (2, 'Bob', 'Jones', '456 Oak', 'Dallas', 'TX', '75201', 'bob@example.com', '555-0201', '555-0202');
-- Owner 3 has NO dogs (tests RIGHT JOIN / LEFT JOIN from Owners)
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (3, 'Charlie', 'Brown', '789 Pine', 'Houston', 'TX', '77001', 'charlie@example.com', '555-0301', '555-0302');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (101, 1, 'S1', 'B1', '0', 'Zoe', '3', '2020-01-01', 'F', '10', '2020-02-01', '2020-03-01', NULL);
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (102, 1, 'S1', 'B1', '1', 'Buddy', '5', '2018-05-01', 'M', '15', '2019-01-01', NULL, NULL);
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (103, 1, 'S1', 'B1', '0', 'Buddy', '2', '2021-06-01', 'M', '12', '2021-07-01', '2021-08-01', '2022-01-01');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (104, 2, 'S1', 'B1', '0', 'Max', '4', '2019-03-01', 'M', '20', '2019-04-01', '2019-05-01', NULL);
-- Dog 105 has NULL owner_id (tests LEFT JOIN from Dogs)
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (105, NULL, 'S1', 'B1', '1', 'Ghost', '1', '2022-01-01', 'F', '8', '2022-02-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, name FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM dogs AS LHS INNER JOIN owners AS RHS ON (LHS.owner_id = RHS.owner_id)) ORDER BY first_name, name NULLS LAST;

/*
Gold Result:
('Alice', 'Buddy')
('Alice', 'Buddy')
('Alice', 'Zoe')
('Bob', 'Max')
*/

-- Prediction Query
SELECT T1.first_name, T2.name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id;

/*
Prediction Result:
('Alice', 'Zoe')
('Alice', 'Buddy')
('Alice', 'Buddy')
('Bob', 'Max')
*/