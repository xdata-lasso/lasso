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
INSERT INTO "Breeds" ("breed_code", "breed_name") VALUES ('B1', 'Bulldog');
INSERT INTO "Sizes" ("size_code", "size_description") VALUES ('S1', 'Small');
INSERT INTO "Treatment_Types" ("treatment_type_code", "treatment_type_description") VALUES ('T1', 'Checkup');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name") VALUES (1, 'John', 'Doe');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "name") VALUES (1, 1, 'S1', 'B1', 'Rex');
INSERT INTO "Professionals" ("professional_id", "first_name", "last_name") VALUES (1, 'Alice', 'Smith');
INSERT INTO "Treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "cost_of_treatment") VALUES (1, 1, 1, 'T1', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT LHS.professional_id AS professional_id, LHS.role_code AS role_code, LHS.first_name AS first_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.last_name AS last_name, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number, RHS.dog_id AS dog_id, RHS.professional_id AS professional_id_other, RHS.treatment_type_code AS treatment_type_code, RHS.date_of_treatment AS date_of_treatment, RHS.cost_of_treatment AS cost_of_treatment, RHS.meancost_of_treatment AS meancost_of_treatment FROM professionals AS LHS INNER JOIN (SELECT treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment, AVG(cost_of_treatment) OVER () AS meancost_of_treatment FROM treatments) AS RHS ON (LHS.professional_id = RHS.treatment_id)) ORDER BY first_name, last_name NULLS LAST;

/*
Gold Result:
('Alice', 'Smith')
*/

-- Prediction Query
SELECT DISTINCT T1.first_name, T1.last_name FROM Professionals AS T1 CROSS JOIN Treatments AS T2 WHERE cost_of_treatment < (SELECT AVG(cost_of_treatment) FROM Treatments);

/*
Prediction Result:
*/