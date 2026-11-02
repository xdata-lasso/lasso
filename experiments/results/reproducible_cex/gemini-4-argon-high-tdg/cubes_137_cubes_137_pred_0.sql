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
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B1', 'Afghan Hound');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B2', 'Beagle');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B3', 'Collie');
INSERT INTO Breeds (breed_code, breed_name) VALUES ('B4', 'Dachshund');
INSERT INTO Sizes (size_code, size_description) VALUES ('S', 'Small');
INSERT INTO Sizes (size_code, size_description) VALUES ('M', 'Medium');
INSERT INTO Sizes (size_code, size_description) VALUES ('L', 'Large');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (1, 'Alice', 'Smith', '10 Main St', 'Austin', 'TX', '78701', 'alice@example.com', '512-000-0001', '512-000-0002');
INSERT INTO Owners (owner_id, first_name, last_name, street, city, state, zip_code, email_address, home_phone, cell_number) VALUES (2, 'Bob', 'Jones', '20 Oak Ave', 'Dallas', 'TX', '75201', 'bob@example.com', '214-000-0001', '214-000-0002');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (1, 1, 'L', 'B1', '1', 'Rex', '5', '2016-05-01 00:00:00', 'M', '60', '2017-01-01 09:00:00', '2021-06-15 14:00:00', '2021-06-16 10:00:00');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (2, 1, 'L', 'B1', '0', 'Max', '4', '2017-03-10 00:00:00', 'M', '58', '2019-02-01 09:00:00', '2022-01-20 11:00:00', '2022-01-21 10:00:00');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (3, 2, 'L', 'B1', '1', 'Leo', '6', '2015-08-20 00:00:00', 'M', '65', '2020-04-01 09:00:00', '2022-09-10 16:00:00', '2022-09-11 10:00:00');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (4, 2, 'S', 'B2', '0', 'Bella', '1', '2012-01-01 00:00:00', 'F', '10', '2018-05-01 09:00:00', '2020-03-05 12:00:00', '2020-03-06 10:00:00');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (5, 1, 'M', 'B3', '1', 'Lassie', '3', '2016-11-11 00:00:00', 'F', '45', '2018-01-10 09:00:00', '2018-04-10 10:00:00', '2019-12-01 10:00:00');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (6, 2, 'M', 'B3', '0', 'Shep', '7', '2017-07-07 00:00:00', 'M', '48', '2021-01-10 09:00:00', '2023-08-01 12:00:00', '2023-08-02 10:00:00');
INSERT INTO Dogs (dog_id, owner_id, size_code, breed_code, abandoned_yn, name, age, date_of_birth, gender, weight, date_arrived, date_adopted, date_departed) VALUES (7, 2, 'S', 'B4', '1', 'Oscar', '8', '2018-02-02 00:00:00', 'M', '15', '2018-03-01 09:00:00', '2024-11-20 15:30:00', '2018-03-05 10:00:00');
INSERT INTO Charges (charge_id, charge_type, charge_amount) VALUES (1, 'ADOPT', 150.0000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT breed_name FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, LHS.breed_name AS breed_name, RHS.n AS n FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.breed_name AS breed_name FROM dogs AS LHS INNER JOIN breeds AS RHS ON (LHS.breed_code = RHS.breed_code)) AS LHS INNER JOIN (SELECT breed_code, breed_name, COUNT(*) OVER () AS n FROM breeds) AS RHS ON (LHS.breed_code = RHS.breed_code AND LHS.breed_name = RHS.breed_name)) ORDER BY date_adopted) LIMIT 1);

/*
Gold Result:
('Collie',)
*/

-- Prediction Query
SELECT T1.breed_name FROM Breeds AS T1 JOIN Dogs AS T2 ON T1.breed_code = T2.breed_code GROUP BY T1.breed_name ORDER BY COUNT(*) DESC, T1.breed_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Afghan Hound',)
*/