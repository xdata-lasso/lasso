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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('purpose', 'Patrick Sanchez');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1001, 'Donald', 'Garcia', '600 Jeffery Parkways
New Jamesside, MT 29394', 'Lawrencetown', 'Wisconsin', '21427', 'jpeterson@example.org', '001-851-316-1559x40781', '+1-649-359-3103');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1002, 'Exhibitions officer, museum/gallery', 'Michelle', '525 Clark Grove Apt. 928
East Steven, KY 84387', 'Lake Mark', 'Wyoming', '07832', 'Perez', 'trujillorichard@example.org', '495.537.6724', '001-388-249-6965x3287');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1004, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('traditional', 'Check civil quite others.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('image', 'Other life edge network wall quite.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1003, 1001, 'traditional', 'purpose', 'building', 'Kimberly Adams', 'put', '1970-01-01', 'grow', 'brother', '1971-02-02', '1972-03-03', '1973-04-04');
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1002, 1003, 1004, 'image', '1974-05-05', 1005.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT LHS.professional_id AS professional_id, LHS.role_code AS role_code, LHS.first_name AS first_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.last_name AS last_name, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number, RHS.dog_id AS dog_id, RHS.professional_id AS professional_id_other, RHS.treatment_type_code AS treatment_type_code, RHS.date_of_treatment AS date_of_treatment, RHS.cost_of_treatment AS cost_of_treatment, RHS.meancost_of_treatment AS meancost_of_treatment FROM professionals AS LHS INNER JOIN (SELECT treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment, AVG(cost_of_treatment) OVER () AS meancost_of_treatment FROM treatments) AS RHS ON (LHS.professional_id = RHS.treatment_id)) ORDER BY first_name, last_name NULLS LAST;

/*
Gold Result:
('Michelle', 'Perez')
*/

-- Prediction Query
SELECT DISTINCT T1.first_name, T1.last_name FROM Professionals AS T1 CROSS JOIN Treatments AS T2 WHERE cost_of_treatment < (SELECT AVG(cost_of_treatment) FROM Treatments);

/*
Prediction Result:
*/