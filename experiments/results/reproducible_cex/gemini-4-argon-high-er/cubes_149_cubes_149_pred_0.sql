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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Beagle');
INSERT INTO Sizes (size_code, size_description) VALUES ('S1', 'Small');
INSERT INTO Owners (owner_id, first_name, state) VALUES (1, 'Bob', 'Virginia');
INSERT INTO Owners (owner_id, first_name, state) VALUES (2, 'Alice', 'Virginia');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, name) VALUES (1, 1, 'S1', 'B1', 'Rex');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, name) VALUES (2, 2, 'S1', 'B1', 'Max');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "name" FROM (SELECT "LHS"."dog_id" AS "dog_id", "LHS"."owner_id" AS "owner_id", "LHS"."abandoned_yn" AS "abandoned_yn", "LHS"."breed_code" AS "breed_code", "LHS"."size_code" AS "size_code", "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."date_of_birth" AS "date_of_birth", "LHS"."gender" AS "gender", "LHS"."weight" AS "weight", "LHS"."date_arrived" AS "date_arrived", "LHS"."date_adopted" AS "date_adopted", "LHS"."date_departed" AS "date_departed", "RHS"."first_name" AS "first_name", "RHS"."last_name" AS "last_name", "RHS"."street" AS "street", "RHS"."city" AS "city", "RHS"."state" AS "state", "RHS"."zip_code" AS "zip_code", "RHS"."email_address" AS "email_address", "RHS"."home_phone" AS "home_phone", "RHS"."cell_number" AS "cell_number" FROM "dogs" AS "LHS" INNER JOIN (SELECT * FROM "owners" WHERE ("state" = 'Virginia')) AS RHS ON (LHS.owner_id = RHS.owner_id)) ORDER BY first_name, "first_name" NULLS LAST, "name" NULLS LAST;

/*
Gold Result:
('Alice', 'Max')
('Bob', 'Rex')
*/

-- Prediction Query
SELECT T1.first_name, T2.name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id WHERE T1.state = 'Virginia';

/*
Prediction Result:
('Bob', 'Rex')
('Alice', 'Max')
*/