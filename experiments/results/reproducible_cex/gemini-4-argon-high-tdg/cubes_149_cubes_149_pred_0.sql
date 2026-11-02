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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Labrador');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B2', 'Beagle');
INSERT INTO Sizes (size_code, size_description) VALUES ('S1', 'Large');
INSERT INTO Sizes (size_code, size_description) VALUES ('S2', 'Small');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Zoe', 'Adams', '10 Main St', 'Richmond', 'Virginia', '23220', 'zoe@example.com', '111-1111', '111-1112');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (2, 'Alice', 'Baker', '20 Oak Ave', 'Norfolk', 'Virginia', '23501', 'alice@example.com', '222-2221', '222-2222');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (3, 'Bob', 'Carter', '30 Pine Rd', 'Charleston', 'West Virginia', '25301', 'bob@example.com', '333-3331', '333-3332');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (4, 'Diana', 'Evans', 'Virginia', 'Virginia', 'Maryland', '20701', 'diana@example.com', '444-4441', '444-4442');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (5, 'Evan', 'Foster', '50 Elm St', 'Arlington', 'VA', '22201', 'evan@example.com', '555-5551', '555-5552');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (6, 'Fiona', 'Green', '60 Maple Dr', 'Roanoke', NULL, '24001', 'fiona@example.com', '666-6661', '666-6662');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (10, 1, 'S1', 'B1', '0', 'Rex', '3', '2020-01-01', 'M', '65', '2020-02-01', '2020-03-01', '2020-03-02');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (20, 2, 'S2', 'B2', '0', 'Bella', '2', '2021-05-10', 'F', '22', '2021-06-01', '2021-07-01', '2021-07-02');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (30, 3, 'S1', 'B1', '0', 'Max', '4', '2019-03-15', 'M', '70', '2019-04-01', '2019-05-01', '2019-05-02');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (40, 4, 'S2', 'B2', '0', 'Lucy', '1', '2022-08-20', 'F', '18', '2022-09-01', '2022-10-01', '2022-10-02');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (50, 5, 'S1', 'B1', '0', 'Cooper', '5', '2018-11-11', 'M', '60', '2018-12-01', '2019-01-01', '2019-01-02');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (60, 6, 'S2', 'B2', '0', 'Daisy', '2', '2021-02-14', 'F', '20', '2021-03-01', '2021-04-01', '2021-04-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "name" FROM (SELECT "LHS"."dog_id" AS "dog_id", "LHS"."owner_id" AS "owner_id", "LHS"."abandoned_yn" AS "abandoned_yn", "LHS"."breed_code" AS "breed_code", "LHS"."size_code" AS "size_code", "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."date_of_birth" AS "date_of_birth", "LHS"."gender" AS "gender", "LHS"."weight" AS "weight", "LHS"."date_arrived" AS "date_arrived", "LHS"."date_adopted" AS "date_adopted", "LHS"."date_departed" AS "date_departed", "RHS"."first_name" AS "first_name", "RHS"."last_name" AS "last_name", "RHS"."street" AS "street", "RHS"."city" AS "city", "RHS"."state" AS "state", "RHS"."zip_code" AS "zip_code", "RHS"."email_address" AS "email_address", "RHS"."home_phone" AS "home_phone", "RHS"."cell_number" AS "cell_number" FROM "dogs" AS "LHS" INNER JOIN (SELECT * FROM "owners" WHERE ("state" = 'Virginia')) AS RHS ON (LHS.owner_id = RHS.owner_id)) ORDER BY first_name, "first_name" NULLS LAST, "name" NULLS LAST;

/*
Gold Result:
('Alice', 'Bella')
('Zoe', 'Rex')
*/

-- Prediction Query
SELECT T1.first_name, T2.name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id WHERE T1.state = 'Virginia';

/*
Prediction Result:
('Zoe', 'Rex')
('Alice', 'Bella')
*/