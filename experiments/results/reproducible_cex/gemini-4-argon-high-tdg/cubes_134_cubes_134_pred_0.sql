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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Bulldog');
INSERT INTO Sizes (size_code, size_description) VALUES ('S1', 'Medium');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('TT1', 'Vaccination');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('TT2', 'Checkup');
INSERT INTO Charges (charge_id, charge_type, charge_amount) VALUES (1, 'Standard', 50.0000);
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'OwnerAlice', 'Anderson', '10 Main St', 'Austin', 'TX', '78701', 'alice@example.com', '555-0101', '555-0102');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (2, 'OwnerBob', 'Brown', '20 Oak St', 'Boston', 'MA', '02101', 'bob@example.com', '555-0201', '555-0202');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (1, 1, 'S1', 'B1', '0', 'DogRex', '3', '2020-01-01 00:00:00', 'M', '25', '2021-01-01 00:00:00', '2021-02-01 00:00:00', '2021-02-02 00:00:00');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (2, 2, 'S1', 'B1', '1', 'DogMax', '5', '2018-06-15 00:00:00', 'F', '30', '2019-03-10 00:00:00', '2019-04-10 00:00:00', '2019-04-12 00:00:00');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (3, 1, 'S1', 'B1', '0', 'DogBella', '2', '2021-09-09 00:00:00', 'F', '20', '2022-01-01 00:00:00', '2022-02-01 00:00:00', '2022-02-05 00:00:00');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (1, 'VET', 'Zack', '101 Pine St', 'Denver', 'CO', '80201', 'LastZack', 'zack@vet.com', '555-1001', '555-1002');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (2, 'NURSE', 'Clara', '202 Elm St', 'Miami', 'FL', '33101', 'LastClara', 'clara@vet.com', '555-2001', '555-2002');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (3, 'VET', 'Aaron', '303 Birch St', 'Seattle', 'WA', '98101', 'LastAaron', 'aaron@vet.com', '555-3001', '555-3002');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (4, 'SURG', 'UnmatchedProf', '404 Cedar St', 'Dallas', 'TX', '75201', 'LastUnmatched', 'unmatched@vet.com', '555-4001', '555-4002');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 2, 1, 'TT1', '2023-03-15 10:00:00', 120.0000);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (2, 3, 3, 'TT2', '2023-03-15 10:00:00', 80.0000);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (3, 1, 2, 'TT1', '2023-01-10 09:30:00', 50.0000);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (4, 2, 2, 'TT2', '2023-01-10 09:30:00', 95.0000);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (5, 1, 1, 'TT2', '2023-02-20 14:15:00', 200.0000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_treatment, first_name FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.role_code AS role_code, RHS.first_name AS first_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.last_name AS last_name, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM treatments AS LHS INNER JOIN professionals AS RHS ON (LHS.professional_id = RHS.professional_id)) ORDER BY date_of_treatment, first_name NULLS LAST;

/*
Gold Result:
('2023-01-10 09:30:00', 'Clara')
('2023-01-10 09:30:00', 'Clara')
('2023-02-20 14:15:00', 'Zack')
('2023-03-15 10:00:00', 'Aaron')
('2023-03-15 10:00:00', 'Zack')
*/

-- Prediction Query
SELECT T1.date_of_treatment, T2.first_name FROM Treatments AS T1 JOIN Professionals AS T2 ON T1.professional_id = T2.professional_id;

/*
Prediction Result:
('2023-03-15 10:00:00', 'Zack')
('2023-03-15 10:00:00', 'Aaron')
('2023-01-10 09:30:00', 'Clara')
('2023-01-10 09:30:00', 'Clara')
('2023-02-20 14:15:00', 'Zack')
*/