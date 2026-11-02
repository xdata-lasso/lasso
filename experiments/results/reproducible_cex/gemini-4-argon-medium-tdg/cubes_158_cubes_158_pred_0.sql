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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Bulldog');
INSERT INTO Sizes (size_code, size_description) VALUES ('S1', 'Medium');
INSERT INTO Treatment_Types (treatment_type_code, treatment_type_description) VALUES ('T1', 'Vaccination');
INSERT INTO Professionals (professional_id, role_code, first_name, last_name, zip_code) VALUES (1, 'VET', 'Alice', 'Smith', '00001');
INSERT INTO Owners (owner_id, first_name, last_name, zip_code) VALUES (1, 'John', 'Doe', '10001');
INSERT INTO Owners (owner_id, first_name, last_name, zip_code) VALUES (2, 'Jane', 'Roe', '20002');
INSERT INTO Owners (owner_id, first_name, last_name, zip_code) VALUES (3, 'Bob', 'Cue', '30003');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, name, age, weight) VALUES (1, 1, 'S1', 'B1', 'Rex', '9', '100');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, name, age, weight) VALUES (2, 2, 'S1', 'B1', 'Max', '1', '90');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, name, age, weight) VALUES (3, 3, 'S1', 'B1', 'Buddy', '5', '99');
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, cost_of_treatment) VALUES (1, 1, 1, 'T1', 500.0);
INSERT INTO Treatments (treatment_id, dog_id, professional_id, treatment_type_code, cost_of_treatment) VALUES (2, 2, 1, 'T1', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT owner_id, zip_code FROM (SELECT * FROM (SELECT * FROM (SELECT treatment_id, dog_id, professional_id, treatment_type_code, date_of_treatment, cost_of_treatment, owner_id, abandoned_yn, breed_code, size_code, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number, SUM(cost_of_treatment) OVER () AS sumcost_of_treatment FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.owner_id AS owner_id, RHS.abandoned_yn AS abandoned_yn, RHS.breed_code AS breed_code, RHS.size_code AS size_code, RHS.name AS name, RHS.age AS age, RHS.date_of_birth AS date_of_birth, RHS.gender AS gender, RHS.weight AS weight, RHS.date_arrived AS date_arrived, RHS.date_adopted AS date_adopted, RHS.date_departed AS date_departed FROM treatments AS LHS INNER JOIN dogs AS RHS ON (LHS.dog_id = RHS.dog_id)) AS LHS INNER JOIN owners AS RHS ON (LHS.owner_id = RHS.owner_id))) ORDER BY weight DESC) LIMIT 1);

/*
Gold Result:
(2, '20002')
*/

-- Prediction Query
SELECT T1.owner_id, T1.zip_code FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id JOIN Treatments AS T3 ON T2.dog_id = T3.dog_id GROUP BY T1.owner_id ORDER BY SUM(T3.cost_of_treatment) DESC, T1.owner_id NULLS LAST, T1.zip_code NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, '10001')
*/