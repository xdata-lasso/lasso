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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('after', 'Jack Galloway');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('such', 'Danielle Lee');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('first', 'Timothy Walls');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1008, 'Lindsay', 'Allen', '71822 Arroyo Expressway
Allisonchester, IL 71187', 'Lake Larry', 'Texas', '85681', 'samuel87@example.org', '531.250.9839', '603-910-5183');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1011, 'Shane', 'Henderson', '78108 Tanya Terrace
East Richard, NJ 28517', 'Barreraburgh', 'Missouri', '00783', 'ybaker@example.com', '268-272-3430x9805', '001-378-382-0812');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1014, 'Albert', 'Howell', '83842 Ibarra Gardens
Justinmouth, MP 71701', 'Cherylhaven', 'Alabama', '88039', 'sarah12@example.com', '518-624-4935', '874.201.6400x52427');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('difficult', 'Car very number line six space couple.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('Republican', 'Identify walk now often always.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('brother', 'War real chance along.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1009, 1008, 'difficult', 'after', 'bill', 'Heather Jenkins', 'treat', '1986-06-17', 'shoulder', 'arm', '1987-07-18', '1988-08-19', '1989-09-20');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1010, 1008, 'difficult', 'after', 'report', 'Maria Brown', 'should', '1990-10-21', 'shoulder', 'group', '1991-11-22', '1992-01-23', '1993-02-01');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1012, 1011, 'Republican', 'such', 'beat', 'Kevin Mills', NULL, '1994-03-02', 'every', 'democratic', '1995-04-03', '1996-05-04', '1997-06-05');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1013, 1011, 'Republican', 'such', 'relationship', 'Cynthia Foster', NULL, '1998-07-06', 'every', 'quite', '1970-08-07', '1971-09-08', '1972-10-09');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1015, 1014, 'brother', 'first', 'hope', 'Brittany Anderson', 'foot', '1973-11-10', 'every', 'his', '1974-01-11', '1975-02-12', '1976-03-13');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1016, 1014, 'brother', 'first', 'way', 'Valerie Williams', 'help', '1977-04-14', 'every', 'develop', '1978-05-15', '1979-06-16', '1980-07-17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.first_name AS first_name, RHS.last_name AS last_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM dogs AS LHS INNER JOIN owners AS RHS ON (LHS.owner_id = RHS.owner_id)) AS LHS INNER JOIN (SELECT gender, MAX(age) AS age FROM dogs GROUP BY gender) AS RHS ON (LHS.age = RHS.age AND LHS.gender = RHS.gender)) ORDER BY last_name;

/*
Gold Result:
('Allen',)
('Howell',)
*/

-- Prediction Query
SELECT T1.last_name FROM Owners AS T1 JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id WHERE T2.age = (SELECT MAX(age) FROM Dogs);

/*
Prediction Result:
('Allen',)
*/