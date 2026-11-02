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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Beagle');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B2', 'Poodle');
INSERT INTO Sizes (size_code, size_description) VALUES ('S', 'Small');
INSERT INTO Sizes (size_code, size_description) VALUES ('M', 'Medium');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T1', 'Vaccination');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T2', 'Checkup');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (101, 'Alice', 'Smith', '1st St', 'Austin', 'TX', '78701', 'alice@example.com', '111-1111', '111-1112');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (102, 'Bob', 'Jones', '2nd St', 'Dallas', 'TX', '75201', 'bob@example.com', '222-2221', '222-2222');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (555, 'VET', 'Carol', '3rd St', 'Austin', 'TX', '78702', 'White', 'carol@example.com', '333-3331', '333-3332');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (901, 'VET', 'Dan', '4th St', 'Austin', 'TX', '78703', 'Brown', 'dan@example.com', '444-4441', '444-4442');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (902, 'NUR', 'Eve', '5th St', 'Austin', 'TX', '78704', 'Green', 'eve@example.com', '555-5551', '555-5552');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (907, 'NUR', 'Frank', '6th St', 'Austin', 'TX', '78705', 'Black', 'frank@example.com', '666-6661', '666-6662');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (910, 'VET', 'Grace', '7th St', 'Austin', 'TX', '78706', 'Hall', 'grace@example.com', '777-7771', '777-7772');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (920, 'VET', 'Hank', '8th St', 'Austin', 'TX', '78707', 'King', 'hank@example.com', '888-8881', '888-8882');
INSERT INTO Professionals (professional_id, role_code, first_name, street, city, state, zip_code, last_name, email_address, home_phone, cell_number) VALUES (930, 'VET', 'Ivy', '9th St', 'Austin', 'TX', '78708', 'Lee', 'ivy@example.com', '999-9991', '999-9992');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (10, 101, 'S', 'B1', '1', 'Rex', '2', '2021-01-01', 'M', '15', '2022-01-01', '2022-02-01', '2022-02-02');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (20, 102, 'M', 'B2', '0', 'Bella', '3', '2020-05-01', 'F', '25', '2022-03-01', '2022-04-01', '2022-04-02');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (30, 102, 'M', 'B2', '0', 'Max', '4', '2019-06-01', 'F', '28', '2022-05-01', '2022-06-01', '2022-06-02');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (1, 10, 901, 'T1', '2022-07-01', 50.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (2, 20, 902, 'T1', '2022-07-02', 60.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (3, 30, 555, 'T2', '2022-07-03', 120.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (7, 10, 907, 'T2', '2022-07-04', 70.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (10, 10, 910, 'T1', '2022-07-05', 80.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (20, 20, 920, 'T1', '2022-07-06', 90.00);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment) VALUES (30, 30, 930, 'T2', '2022-07-07', 100.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT professional_id AS count___ FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.owner_id AS owner_id, RHS.abandoned_yn AS abandoned_yn, RHS.breed_code AS breed_code, RHS.size_code AS size_code, RHS.name AS name, RHS.age AS age, RHS.date_of_birth AS date_of_birth, RHS.gender AS gender, RHS.weight AS weight, RHS.date_arrived AS date_arrived, RHS.date_adopted AS date_adopted, RHS.date_departed AS date_departed FROM treatments AS LHS INNER JOIN (SELECT dog_id, owner_id, abandoned_yn, breed_code, size_code, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed, COUNT(*) OVER () AS n FROM dogs) AS RHS ON (LHS.treatment_id = RHS.n AND LHS.dog_id = RHS.dog_id)) ORDER BY count___;

/*
Gold Result:
(555,)
*/

-- Prediction Query
SELECT COUNT(*) FROM dogs WHERE NOT dog_id IN (SELECT dog_id FROM treatments);

/*
Prediction Result:
(0,)
*/