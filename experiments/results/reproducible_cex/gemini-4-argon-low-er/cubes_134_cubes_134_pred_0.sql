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
INSERT INTO Professionals (professional_id, first_name) VALUES (1, 'Alice');
INSERT INTO Professionals (professional_id, first_name) VALUES (2, NULL);
INSERT INTO Treatments (treatment_id, professional_id, date_of_treatment) VALUES (1, 1, '2023-01-02');
INSERT INTO Treatments (treatment_id, professional_id, date_of_treatment) VALUES (2, 1, '2023-01-01');
INSERT INTO Treatments (treatment_id, professional_id, date_of_treatment) VALUES (3, 2, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_treatment, first_name FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.role_code AS role_code, RHS.first_name AS first_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.last_name AS last_name, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM treatments AS LHS INNER JOIN professionals AS RHS ON (LHS.professional_id = RHS.professional_id)) ORDER BY date_of_treatment, first_name NULLS LAST;

/*
Gold Result:
('2023-01-01', 'Alice')
('2023-01-01', None)
('2023-01-02', 'Alice')
*/

-- Prediction Query
SELECT T1.date_of_treatment, T2.first_name FROM Treatments AS T1 JOIN Professionals AS T2 ON T1.professional_id = T2.professional_id;

/*
Prediction Result:
('2023-01-02', 'Alice')
('2023-01-01', 'Alice')
('2023-01-01', None)
*/