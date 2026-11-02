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
-- DATASET 1
INSERT INTO "Breeds" ("breed_code", "breed_name") VALUES ('B1', 'Bulldog');
INSERT INTO "Sizes" ("size_code", "size_description") VALUES ('S1', 'Small');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name") VALUES (1, 'Alice', 'Zimmerman');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name") VALUES (2, 'Bob', 'Adams');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name") VALUES (3, 'Charlie', 'Baker');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name") VALUES (4, 'David', 'Clark');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name") VALUES (5, 'Eve', 'Davis');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "name", "age", "gender") VALUES (1, 1, 'S1', 'B1', 'Rex', '9', 'M');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "name", "age", "gender") VALUES (2, 2, 'S1', 'B1', 'Max', '5', 'M');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "name", "age", "gender") VALUES (3, 3, 'S1', 'B1', 'Bella', '5', 'F');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "name", "age", "gender") VALUES (4, 4, 'S1', 'B1', 'Lucy', '2', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM dogs AS LHS INNER JOIN owners AS RHS ON (LHS.owner_id = RHS.owner_id)) AS LHS INNER JOIN (SELECT gender, MAX(age) AS age FROM dogs GROUP BY gender) AS RHS ON (LHS.age = RHS.age AND LHS.gender = RHS.gender)) ORDER BY last_name;

/*
Gold Result:
('Baker',)
('Zimmerman',)
*/

-- Prediction Query
SELECT T1.last_name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id WHERE T2.age = (SELECT MAX(age) FROM Dogs);

/*
Prediction Result:
('Zimmerman',)
*/