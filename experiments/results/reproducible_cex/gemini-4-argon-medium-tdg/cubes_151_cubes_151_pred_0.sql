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
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Alice', 'Smith', '100 Main St', 'Austin', 'TX', '78701', 'alice@example.com', '555-0101', '555-0102');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (2, 'Bob', 'Smith', '100 Main St', 'Austin', 'TX', '78701', 'bob@example.com', '555-0103', '555-0104');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (3, 'Charlie', 'Jones', '200 Oak St', 'Los Angeles', 'CA', '90001', 'charlie@example.com', '555-0105', '555-0106');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (4, 'David', 'White', '300 Pine St', 'Seattle', 'WA', '98101', 'david@example.com', '555-0107', '555-0108');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (5, 'Eve', 'Black', '400 Elm St', 'Miami', NULL, '33101', 'eve@example.com', '555-0109', '555-0110');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (1, 'VET', 'Frank', '500 Birch St', 'Dallas', 'TX', '75201', 'Miller', 'frank@example.com', '555-0201', '555-0202');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (2, 'ASS', 'Grace', '600 Cedar St', 'Houston', 'TX', '77001', 'Davis', 'grace@example.com', '555-0203', '555-0204');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (3, 'VET', 'Hank', '700 Walnut St', 'San Diego', 'CA', '92101', 'Wilson', 'hank@example.com', '555-0205', '555-0206');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (4, 'VET', 'Ivy', '800 Ash St', 'New York', 'NY', '10001', 'Moore', 'ivy@example.com', '555-0207', '555-0208');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (5, 'ASS', 'Jack', '900 Cherry St', 'Orlando', NULL, '32801', 'Taylor', 'jack@example.com', '555-0209', '555-0210');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Bulldog');
INSERT INTO Sizes (size_code, size_description) VALUES ('S1', 'Small');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T1', 'Checkup');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (1, 4, 'S1', 'B1', '0', 'Rex', '3', '2020-01-01', 'M', '20', '2021-01-01', '2021-02-01', '2021-02-02');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 1, 4, 'T1', '2021-01-15', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT state FROM (SELECT LHS.professional_id AS professional_id, LHS.role_code AS role_code, LHS.first_name AS first_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.last_name AS last_name, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number, RHS.owner_id AS owner_id, RHS.first_name AS first_name_other, RHS.last_name AS last_name_other, RHS.street AS street_other, RHS.city AS city_other, RHS.zip_code AS zip_code_other, RHS.email_address AS email_address_other, RHS.home_phone AS home_phone_other, RHS.cell_number AS cell_number_other FROM professionals AS LHS INNER JOIN owners AS RHS ON (LHS.state = RHS.state)) ORDER BY state;

/*
Gold Result:
('CA',)
('TX',)
*/

-- Prediction Query
SELECT state FROM Owners INTERSECT SELECT state FROM Professionals;

/*
Prediction Result:
(None,)
('CA',)
('TX',)
*/