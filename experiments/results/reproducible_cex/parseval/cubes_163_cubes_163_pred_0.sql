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
-- Inserting into table: breeds --
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('breed_co_1', 'bre_c9f807');

INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('lhs_35cb4d', 'bre_c9f807');

INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('lhs_617a0a', 'bre_c9f807');

-- Inserting into table: sizes --
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('size_cod_1', 'siz_1158c4');

INSERT INTO "sizes" ("size_code", "size_description") VALUES ('lhs_5a5a39', 'siz_1158c4');

INSERT INTO "sizes" ("size_code", "size_description") VALUES ('lhs_41499a', 'siz_1158c4');

-- Inserting into table: owners --
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1, 'rhs_7abe57', 'rhs_0cc513', 'rhs_327d0f', 'rhs_05cc98', 'rhs_35ac31', 'rhs_3a3656', 'rhs_f9fe4b', 'rhs_a99c0f', 'rhs_cc9d86');

INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (-2147483647, 'rhs_1aff63', 'rhs_339228', 'rhs_10a75e', 'rhs_e3a533', 'rhs_bb3389', 'rhs_b5c41d', 'rhs_0fde0d', 'rhs_61df55', 'rhs_440d7a');

INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (2, 'rhs_7abe57', 'rhs_0cc513', 'rhs_327d0f', 'rhs_05cc98', 'rhs_35ac31', 'rhs_3a3656', 'rhs_f9fe4b', 'rhs_a99c0f', 'rhs_cc9d86');

INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (3, 'own_a0b92a', 'own_b5dd6f', 'own_b7af96', 'own_9a29f2', 'own_72ab3a', 'own_3a1da4', 'own_057ecf', 'own_68c91c', 'own_d2eb3f');

-- Inserting into table: dogs --
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1, 1, 'size_cod_1', 'breed_co_1', '8', 'dog_9ed778', 'dog_4f34a5', '2021-05-28 17:00:04+00:00', 'd', 'dog_9ccc00', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (-2147483647, -2147483647, 'size_cod_1', 'breed_co_1', '8', 'dog_9ed778', 'dog_4f34a5', '2024-02-11 16:43:27+00:00', 'd', 'dog_9ccc00', '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00', '2022-04-15 05:01:35+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (3, 1, 'lhs_41499a', 'lhs_617a0a', 'lhs_d2b4dd', 'lhs_6dce2e', 'lhs_102001', '2024-06-15 00:00:00+00:00', 'lhs_7d0c33', 'lhs_188dfd', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM dogs AS LHS INNER JOIN owners AS RHS ON (LHS.owner_id = RHS.owner_id)) AS LHS INNER JOIN (SELECT gender, MAX(age) AS age FROM dogs GROUP BY gender) AS RHS ON (LHS.age = RHS.age AND LHS.gender = RHS.gender)) ORDER BY last_name;

/*
Gold Result:
('rhs_0cc513',)
('rhs_0cc513',)
('rhs_339228',)
*/

-- Prediction Query
SELECT T1.last_name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id WHERE T2.age = (SELECT MAX(age) FROM Dogs);

/*
Prediction Result:
('rhs_0cc513',)
*/