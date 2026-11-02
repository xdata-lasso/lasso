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

-- Inserting into table: sizes --
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('size_cod_1', 'siz_1158c4');

-- Inserting into table: treatment_types --
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('treatmen_1', 'tre_252530');

-- Inserting into table: owners --
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (-2147483648, 'own_a0b92a', 'own_b5dd6f', 'own_b7af96', 'own_9a29f2', 'own_72ab3a', 'own_3a1da4', 'own_057ecf', 'own_68c91c', 'own_d2eb3f');

-- Inserting into table: dogs --
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (-2147483648, -2147483648, 'size_cod_1', 'breed_co_1', '8', 'dog_9ed778', 'dog_4f34a5', '2024-12-15 00:56:33+00:00', 'd', 'dog_9ccc00', '2025-11-23 07:28:46+00:00', '2025-10-14 06:39:08+00:00', '2025-06-10 18:20:47+00:00');

-- Inserting into table: professionals --
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (2, 'pro_008b42', 't1__b28c09', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 't1__6536c9', 'pro_3761e1', 'pro_02195f', 'pro_442513');

INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (3, 'pro_008b42', 't1__b28c09', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 't1__6536c9', 'pro_3761e1', 'pro_02195f', 'pro_442513');

INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (4, 'pro_008b42', 'pro_7fbba0', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 'pro_76e64d', 'pro_3761e1', 'pro_02195f', 'pro_442513');

INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (5, 'pro_008b42', 'pro_7fbba0', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 'pro_76e64d', 'pro_3761e1', 'pro_02195f', 'pro_442513');

INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (6, 'pro_008b42', 'pro_7fbba0', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 'pro_76e64d', 'pro_3761e1', 'pro_02195f', 'pro_442513');

INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (7, 'pro_008b42', 'pro_7fbba0', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 'pro_76e64d', 'pro_3761e1', 'pro_02195f', 'pro_442513');

INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (8, 'pro_008b42', 'pro_7fbba0', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 'pro_76e64d', 'pro_3761e1', 'pro_02195f', 'pro_442513');

INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (9, 'pro_008b42', 'pro_7fbba0', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 'pro_76e64d', 'pro_3761e1', 'pro_02195f', 'pro_442513');

INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (10, 'pro_008b42', 'pro_7fbba0', 'pro_281ab9', 'pro_fdde3a', 'pro_0450af', 'pro_a67452', 'pro_76e64d', 'pro_3761e1', 'pro_02195f', 'pro_442513');

-- Inserting into table: treatments --
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483648, -2147483648, 3, 'treatmen_1', '2021-05-28 17:00:04+00:00', NULL);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483647, -2147483648, 3, 'treatmen_1', '2023-01-16 20:10:41+00:00', NULL);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483646, -2147483648, 2, 'treatmen_1', '2022-06-28 11:34:24+00:00', NULL);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483645, -2147483648, 2, 'treatmen_1', '2024-01-16 07:29:50+00:00', NULL);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483644, -2147483648, 2, 'treatmen_1', '2024-06-06 00:28:47+00:00', NULL);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483643, -2147483648, 2, 'treatmen_1', '2024-02-11 16:43:27+00:00', NULL);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (4, -2147483648, 3, 'treatmen_1', '2020-01-15 18:18:33+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483641, -2147483648, 3, 'treatmen_1', '2022-10-06 13:20:05+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (2, -2147483648, 2, 'treatmen_1', '2025-08-22 00:34:24+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (3, -2147483648, 4, 'treatmen_1', '2020-04-05 14:43:51+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (7, -2147483648, 3, 'treatmen_1', '2022-09-23 20:24:07+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483637, -2147483648, 4, 'treatmen_1', '2021-07-11 07:27:32+00:00', 0.5);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (5, -2147483648, 4, 'treatmen_1', '2021-07-20 10:41:36+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (6, -2147483648, 3, 'treatmen_1', '2022-04-12 01:47:28+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (10, -2147483648, 6, 'treatmen_1', '2021-12-31 07:20:26+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483633, -2147483648, 6, 'treatmen_1', '2021-02-17 05:47:13+00:00', 0.5);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (8, -2147483648, 2, 'treatmen_1', '2022-10-15 07:04:26+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (9, -2147483648, 4, 'treatmen_1', '2021-06-25 00:51:07+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (13, -2147483648, 7, 'treatmen_1', '2024-12-31 04:19:17+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483629, -2147483648, 7, 'treatmen_1', '2024-10-26 11:04:11+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (11, -2147483648, 4, 'treatmen_1', '2020-04-28 17:03:46+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (12, -2147483648, 6, 'treatmen_1', '2020-05-12 00:10:04+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (16, -2147483648, 7, 'treatmen_1', '2020-05-18 19:45:10+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483625, -2147483648, 5, 'treatmen_1', '2021-02-10 21:10:52+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (14, -2147483648, 3, 'treatmen_1', '2023-11-07 12:14:47+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (15, -2147483648, 2, 'treatmen_1', '2021-11-30 23:39:10+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (19, -2147483648, 5, 'treatmen_1', '2025-10-19 18:29:54+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483621, -2147483648, 6, 'treatmen_1', '2025-10-15 06:50:58+00:00', 0.5);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (17, -2147483648, 6, 'treatmen_1', '2022-01-22 16:14:13+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (18, -2147483648, 6, 'treatmen_1', '2020-02-25 10:33:58+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (22, -2147483648, 5, 'treatmen_1', '2025-09-22 03:26:15+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (-2147483617, -2147483648, 3, 'treatmen_1', '2022-07-13 23:48:43+00:00', 0.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (20, -2147483648, 4, 'treatmen_1', '2020-01-22 05:30:29+00:00', -1.0);

INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (21, -2147483648, 8, 'treatmen_1', '2023-03-22 03:47:49+00:00', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT LHS.professional_id AS professional_id, LHS.role_code AS role_code, LHS.first_name AS first_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.last_name AS last_name, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number, RHS.dog_id AS dog_id, RHS.professional_id AS professional_id_other, RHS.treatment_type_code AS treatment_type_code, RHS.date_of_treatment AS date_of_treatment, RHS.cost_of_treatment AS cost_of_treatment, RHS.meancost_of_treatment AS meancost_of_treatment FROM professionals AS LHS INNER JOIN (SELECT treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment, AVG(cost_of_treatment) OVER () AS meancost_of_treatment FROM treatments) AS RHS ON (LHS.professional_id = RHS.treatment_id)) ORDER BY first_name, last_name NULLS LAST;

/*
Gold Result:
('pro_7fbba0', 'pro_76e64d')
('pro_7fbba0', 'pro_76e64d')
('pro_7fbba0', 'pro_76e64d')
('pro_7fbba0', 'pro_76e64d')
('pro_7fbba0', 'pro_76e64d')
('pro_7fbba0', 'pro_76e64d')
('pro_7fbba0', 'pro_76e64d')
('t1__b28c09', 't1__6536c9')
('t1__b28c09', 't1__6536c9')
*/

-- Prediction Query
SELECT DISTINCT T1.first_name, T1.last_name FROM Professionals AS T1 CROSS JOIN Treatments AS T2 WHERE cost_of_treatment < (SELECT AVG(cost_of_treatment) FROM Treatments);

/*
Prediction Result:
('t1__b28c09', 't1__6536c9')
('pro_7fbba0', 'pro_76e64d')
*/