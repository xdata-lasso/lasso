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
INSERT INTO "Breeds" ("breed_code", "breed_name") VALUES ('B1', 'Labrador');
INSERT INTO "Sizes" ("size_code", "size_description") VALUES ('S1', 'Medium');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1, 'Wrong', 'WrongIdJoin', '100 Main St', 'Austin', 'TX', '78701', 'wrong@example.com', '555-0100', '555-0101');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (10, 'Alice', 'Zimmerman', '101 Oak St', 'Austin', 'TX', '78702', 'alice@example.com', '555-0110', '555-0111');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (20, 'Bob', 'Miller', '202 Pine St', 'Dallas', 'TX', '75201', 'bob@example.com', '555-0120', '555-0121');
INSERT INTO "Owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (30, 'Zack', 'Adams', '303 Elm St', 'Houston', 'TX', '77001', 'zack@example.com', '555-0130', '555-0131');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1, 10, 'S1', 'B1', 'N', 'Rex', '9', '2015-01-01', 'M', '30', '2016-01-01', '2016-02-01', '2016-02-02');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (2, 20, 'S1', 'B1', 'N', 'Buddy', '5', '2019-01-01', 'M', '25', '2019-06-01', '2019-07-01', '2019-07-02');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (3, 30, 'S1', 'B1', 'N', 'Bella', '5', '2019-03-01', 'F', '22', '2019-08-01', '2019-09-01', '2019-09-02');
INSERT INTO "Dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (4, 20, 'S1', 'B1', 'N', 'Lucy', '2', '2022-01-01', 'F', '18', '2022-05-01', '2022-06-01', '2022-06-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM dogs AS LHS INNER JOIN owners AS RHS ON (LHS.owner_id = RHS.owner_id)) AS LHS INNER JOIN (SELECT gender, MAX(age) AS age FROM dogs GROUP BY gender) AS RHS ON (LHS.age = RHS.age AND LHS.gender = RHS.gender)) ORDER BY last_name;

/*
Gold Result:
('Adams',)
('Zimmerman',)
*/

-- Prediction Query
SELECT T1.last_name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id WHERE T2.age = (SELECT MAX(age) FROM Dogs);

/*
Prediction Result:
('Zimmerman',)
*/