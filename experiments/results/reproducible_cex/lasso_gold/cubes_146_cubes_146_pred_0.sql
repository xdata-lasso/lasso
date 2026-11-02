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
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('traditional', 'Check civil quite others.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('image', 'Other life edge network wall quite.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1003, 1001, 'traditional', 'purpose', 'building', 'Kimberly Adams', 'put', '1970-01-01', 'grow', 'brother', '1971-02-02', '1972-03-03', '1973-04-04');
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1, 1003, 1002, 'image', '1974-05-05', 1004.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT professional_id AS count___ FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.owner_id AS owner_id, RHS.abandoned_yn AS abandoned_yn, RHS.breed_code AS breed_code, RHS.size_code AS size_code, RHS.name AS name, RHS.age AS age, RHS.date_of_birth AS date_of_birth, RHS.gender AS gender, RHS.weight AS weight, RHS.date_arrived AS date_arrived, RHS.date_adopted AS date_adopted, RHS.date_departed AS date_departed FROM treatments AS LHS INNER JOIN (SELECT dog_id, owner_id, abandoned_yn, breed_code, size_code, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed, COUNT(*) OVER () AS n FROM dogs) AS RHS ON (LHS.treatment_id = RHS.n AND LHS.dog_id = RHS.dog_id)) ORDER BY count___;

/*
Gold Result:
(1002,)
*/

-- Prediction Query
SELECT COUNT(*) FROM dogs WHERE NOT dog_id IN (SELECT dog_id FROM treatments);

/*
Prediction Result:
(0,)
*/