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
-- DATASET 3
-- Tests ORDER BY date_arrived, date_departed NULLS LAST: includes tie-breaking on date_departed, NULL values in date_departed, NULL values in date_arrived, and out-of-order insertion.
INSERT INTO "Breeds" ("breed_code", "breed_name") VALUES ('B1', 'Terrier');
INSERT INTO "Sizes" ("size_code", "size_description") VALUES ('L1', 'Large');
INSERT INTO "Treatment_Types" ("treatment_type_code", "treatment_type_description") VALUES ('TT1', 'Surgery');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name") VALUES (1, 'David', 'Clark');
INSERT INTO "Professionals" ("professional_id", "role_code", "first_name", "last_name") VALUES (1, 'SURG', 'Sarah', 'Connor');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1, 1, 'L1', 'B1', '0', 'DogA', '2', '2019-01-01', 'M', '40', '2022-03-01', '2022-03-05', '2022-03-10');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (2, 1, 'L1', 'B1', '0', 'DogB', '2', '2019-01-01', 'F', '38', '2022-01-01', '2022-01-05', NULL);
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (3, 1, 'L1', 'B1', '0', 'DogC', '2', '2019-01-01', 'M', '42', '2022-01-01', '2022-01-05', '2022-01-20');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (4, 1, 'L1', 'B1', '0', 'DogD', '2', '2019-01-01', 'F', '35', '2022-01-01', '2022-01-05', '2022-01-10');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (5, 1, 'L1', 'B1', '0', 'DogE', '2', '2019-01-01', 'M', '45', NULL, '2022-01-05', '2022-02-01');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (6, 1, 'L1', 'B1', '0', 'DogF', '2', '2019-01-01', 'F', '39', NULL, '2022-01-05', NULL);
INSERT INTO "Treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1, 1, 1, 'TT1', '2022-03-02', 100.0);
INSERT INTO "Treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (2, 2, 1, 'TT1', '2022-01-02', 100.0);
INSERT INTO "Treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (3, 3, 1, 'TT1', '2022-01-02', 100.0);
INSERT INTO "Treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (4, 4, 1, 'TT1', '2022-01-02', 100.0);
INSERT INTO "Treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (5, 5, 1, 'TT1', '2022-01-02', 100.0);
INSERT INTO "Treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (6, 6, 1, 'TT1', '2022-01-02', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT date_arrived, date_departed FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.owner_id AS owner_id, RHS.abandoned_yn AS abandoned_yn, RHS.breed_code AS breed_code, RHS.size_code AS size_code, RHS.name AS name, RHS.age AS age, RHS.date_of_birth AS date_of_birth, RHS.gender AS gender, RHS.weight AS weight, RHS.date_arrived AS date_arrived, RHS.date_adopted AS date_adopted, RHS.date_departed AS date_departed FROM treatments AS LHS INNER JOIN dogs AS RHS ON (LHS.dog_id = RHS.dog_id)) ORDER BY date_arrived, date_departed NULLS LAST;

/*
Gold Result:
(None, '2022-02-01')
(None, None)
('2022-01-01', '2022-01-10')
('2022-01-01', '2022-01-20')
('2022-01-01', None)
('2022-03-01', '2022-03-10')
*/

-- Prediction Query
SELECT DISTINCT T1.date_arrived, T1.date_departed FROM Dogs AS T1 JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id;

/*
Prediction Result:
('2022-03-01', '2022-03-10')
('2022-01-01', None)
('2022-01-01', '2022-01-20')
('2022-01-01', '2022-01-10')
(None, '2022-02-01')
(None, None)
*/