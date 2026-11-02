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
-- DATASET 2
-- Tests ORDER BY first_name, "first_name" NULLS LAST, "name" NULLS LAST, and column confusion (last_name vs first_name, street/city vs state).
INSERT INTO "Breeds" ("breed_code", "breed_name") VALUES ('B1', 'Poodle');
INSERT INTO "Sizes" ("size_code", "size_description") VALUES ('M1', 'Medium');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (10, 'Zack', 'Adams', '1 St', 'Fairfax', 'Virginia', '22030', 'z@e.com', '111', '222');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (20, 'Aaron', 'Zimmerman', '2 St', 'Arlington', 'Virginia', '22201', 'a@e.com', '333', '444');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (30, NULL, 'Middleton', '3 St', 'Alexandria', 'Virginia', '22301', 'n@e.com', '555', '666');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (40, 'Virginia', 'Virginia', 'Virginia', 'Virginia', 'Maryland', '20001', 'v@e.com', '777', '888');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1, 10, 'M1', 'B1', '0', 'Alpha', '2', '2021-01-01', 'F', '30', '2022-01-01', '2022-02-01', '2022-02-02');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (2, 20, 'M1', 'B1', '0', 'Zorro', '3', '2020-01-01', 'M', '35', '2022-01-01', '2022-02-01', '2022-02-02');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (3, 20, 'M1', 'B1', '0', NULL, '1', '2022-01-01', 'F', '25', '2022-01-01', '2022-02-01', '2022-02-02');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (4, 20, 'M1', 'B1', '0', 'Bella', '4', '2019-01-01', 'F', '28', '2022-01-01', '2022-02-01', '2022-02-02');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (5, 30, 'M1', 'B1', '0', 'Charlie', '2', '2021-01-01', 'M', '32', '2022-01-01', '2022-02-01', '2022-02-02');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (6, 30, 'M1', 'B1', '0', NULL, '5', '2018-01-01', 'M', '40', '2022-01-01', '2022-02-01', '2022-02-02');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (7, 40, 'M1', 'B1', '0', 'Ghost', '2', '2021-01-01', 'M', '30', '2022-01-01', '2022-02-01', '2022-02-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "name" FROM (SELECT "LHS"."dog_id" AS "dog_id", "LHS"."owner_id" AS "owner_id", "LHS"."abandoned_yn" AS "abandoned_yn", "LHS"."breed_code" AS "breed_code", "LHS"."size_code" AS "size_code", "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."date_of_birth" AS "date_of_birth", "LHS"."gender" AS "gender", "LHS"."weight" AS "weight", "LHS"."date_arrived" AS "date_arrived", "LHS"."date_adopted" AS "date_adopted", "LHS"."date_departed" AS "date_departed", "RHS"."first_name" AS "first_name", "RHS"."last_name" AS "last_name", "RHS"."street" AS "street", "RHS"."city" AS "city", "RHS"."state" AS "state", "RHS"."zip_code" AS "zip_code", "RHS"."email_address" AS "email_address", "RHS"."home_phone" AS "home_phone", "RHS"."cell_number" AS "cell_number" FROM "dogs" AS "LHS" INNER JOIN (SELECT * FROM "owners" WHERE ("state" = 'Virginia')) AS RHS ON (LHS.owner_id = RHS.owner_id)) ORDER BY first_name, "first_name" NULLS LAST, "name" NULLS LAST;

/*
Gold Result:
(None, 'Charlie')
(None, None)
('Aaron', 'Bella')
('Aaron', 'Zorro')
('Aaron', None)
('Zack', 'Alpha')
*/

-- Prediction Query
SELECT T1.first_name, T2.name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id WHERE T1.state = 'Virginia';

/*
Prediction Result:
('Zack', 'Alpha')
('Aaron', 'Zorro')
('Aaron', None)
('Aaron', 'Bella')
(None, 'Charlie')
(None, None)
*/