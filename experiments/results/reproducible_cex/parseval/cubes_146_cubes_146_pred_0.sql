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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('dog_f202ba', 'bre_c9f807');

INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('dog_a34366', 'bre_c9f807');

-- Inserting into table: sizes --
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('dog_b33de9', 'siz_1158c4');

INSERT INTO "sizes" ("size_code", "size_description") VALUES ('dog_0b9590', 'siz_1158c4');

-- Inserting into table: treatment_types --
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('lhs_b7b5e0', 'tre_252530');

INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('lhs_6f39e3', 'tre_252530');

-- Inserting into table: owners --
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1, 'own_a0b92a', 'own_b5dd6f', 'own_b7af96', 'own_9a29f2', 'own_72ab3a', 'own_3a1da4', 'own_057ecf', 'own_68c91c', 'own_d2eb3f');

-- Inserting into table: dogs --
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1, 1, 'dog_b33de9', 'dog_f202ba', 'dog_3854c6', 'dog_478783', 'dog_84ed79', '2024-06-15 00:00:00+00:00', 'dog_b0a834', 'dog_cee06c', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (-2147483647, 1, 'dog_0b9590', 'dog_a34366', 'dog_756689', 'dog_a3d8ec', 'dog_4d5439', '2024-06-15 00:00:00+00:00', 'dog_2fd65b', 'dog_3d5d7f', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (2, 1, 'dog_0b9590', 'dog_f202ba', '8', 'dog_9ed778', 'dog_4f34a5', '2020-10-31 07:51:16+00:00', 'd', 'dog_9ccc00', '2022-06-28 11:34:24+00:00', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (3, 1, 'dog_b33de9', 'dog_a34366', '8', 'dog_9ed778', 'dog_4f34a5', '2024-06-06 00:28:47+00:00', 'd', 'dog_9ccc00', '2022-10-19 03:44:42+00:00', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (4, 1, 'dog_0b9590', 'dog_a34366', '8', 'dog_9ed778', 'dog_4f34a5', '2022-01-21 14:23:36+00:00', 'd', 'dog_9ccc00', '2022-10-06 13:20:05+00:00', '2023-05-25 17:04:36+00:00', '2020-12-10 17:36:20+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (5, 1, 'dog_b33de9', 'dog_f202ba', '8', 'dog_9ed778', 'dog_4f34a5', '2022-09-23 20:24:07+00:00', 'd', 'dog_9ccc00', '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00', '2020-06-20 11:35:06+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (6, 1, 'dog_b33de9', 'dog_f202ba', '8', 'dog_9ed778', 'dog_4f34a5', '2022-01-18 15:57:55+00:00', 'd', 'dog_9ccc00', '2022-04-12 01:47:28+00:00', '2021-08-20 16:50:24+00:00', '2025-09-01 05:13:03+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (7, 1, 'dog_b33de9', 'dog_f202ba', '8', 'dog_9ed778', 'dog_4f34a5', '2020-08-22 06:30:10+00:00', 'd', 'dog_9ccc00', '2024-02-29 12:08:41+00:00', '2022-10-15 07:04:26+00:00', '2021-11-09 05:42:50+00:00');

INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (8, 1, 'dog_0b9590', 'dog_a34366', '8', 'dog_9ed778', 'dog_4f34a5', '2024-10-26 11:04:11+00:00', 'd', 'dog_9ccc00', '2025-07-08 08:09:50+00:00', '2023-07-30 11:48:16+00:00', '2022-07-16 22:41:51+00:00');

-- Inserting into table: professionals --
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1, 'pro_008b42', 'pro_7fbba0', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 'pro_76e64d', 'pro_3761e1', 'pro_02195f', 'pro_442513');

-- Inserting into table: treatments --
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1, 1, 1, 'lhs_b7b5e0', '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483647, 1, 1, 'lhs_6f39e3', '2024-06-15 00:00:00+00:00', 1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (2, 2, 1, 'lhs_b7b5e0', '2024-01-16 07:29:50+00:00', 0.0003);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (3, 3, 1, 'lhs_6f39e3', '2021-02-21 20:09:01+00:00', 0.0004);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (4, 2, 1, 'lhs_6f39e3', '2020-04-05 14:43:51+00:00', 0.0005);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (5, -2147483647, 1, 'lhs_6f39e3', '2021-01-23 18:11:33+00:00', 0.0006);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (6, 4, 1, 'lhs_b7b5e0', '2021-12-08 15:32:00+00:00', 0.0007);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (7, 5, 1, 'lhs_b7b5e0', '2020-09-15 12:11:12+00:00', 0.0008);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (8, 7, 1, 'lhs_6f39e3', '2024-12-29 01:35:14+00:00', 0.0009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT professional_id AS count___ FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.owner_id AS owner_id, RHS.abandoned_yn AS abandoned_yn, RHS.breed_code AS breed_code, RHS.size_code AS size_code, RHS.name AS name, RHS.age AS age, RHS.date_of_birth AS date_of_birth, RHS.gender AS gender, RHS.weight AS weight, RHS.date_arrived AS date_arrived, RHS.date_adopted AS date_adopted, RHS.date_departed AS date_departed FROM treatments AS LHS INNER JOIN (SELECT dog_id, owner_id, abandoned_yn, breed_code, size_code, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed, COUNT(*) OVER () AS n FROM dogs) AS RHS ON (LHS.treatment_id = RHS.n AND LHS.dog_id = RHS.dog_id)) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM dogs WHERE NOT dog_id IN (SELECT dog_id FROM treatments);

/*
Prediction Result:
(2,)
*/