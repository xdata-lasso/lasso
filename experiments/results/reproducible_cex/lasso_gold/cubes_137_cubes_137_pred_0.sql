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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('camera', 'Kevin Hall');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('end', 'Benjamin Welch');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('down', 'Taylor Heath');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('attack', 'David Caldwell');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('international', 'Lauren Williams');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('call', 'Matthew Cunningham');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('year', 'Dean Santiago');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('voice', 'Derek Anderson');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1012, 'Jason', 'Anderson', 'USCGC Sanchez
FPO AA 53855', 'North Collin', 'Nevada', '46939', 'ujenkins@example.org', '+1-610-965-1333x87262', '517.481.0801');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1020, 'Debbie', 'Bryant', 'USS Smith
FPO AP 74293', 'North Amandahaven', 'Kentucky', '17862', 'nicole35@example.com', '(378)449-8084', '911-682-4493x534');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('investment', 'Loss ten total clearly able hospital unit.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('western', 'Begin interest everybody.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1013, 1012, 'investment', 'camera', 'land', 'Michelle Moore', 'coach', '1990-10-21', 'today', 'author', '1994-03-02', '1998-07-06', '1973-11-10');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1014, 1012, 'investment', 'camera', 'same', 'Wayne Riley', 'art', '1990-10-22', 'cultural', 'Republican', '1994-03-03', '1998-07-07', '1973-11-11');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1015, 1012, 'investment', 'camera', 'side', 'Nicole Brown', 'movie', '1990-10-23', 'authority', 'training', '1994-03-04', '1998-07-08', '1973-11-12');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1016, 1012, 'investment', 'camera', 'step', 'Kathryn Farrell', 'be', '1990-10-24', 'physical', 'easy', '1994-03-05', '1998-07-09', '1973-11-13');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1021, 1020, 'western', 'international', 'case', 'Kristen Patterson', 'foot', '1977-04-14', 'style', 'develop', '1981-08-18', '1985-01-22', '1989-05-03');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1022, 1020, 'western', 'international', 'public', 'Benjamin Ware', 'his', '1977-04-15', 'traditional', 'rest', '1981-08-19', '1985-01-23', '1989-05-04');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1023, 1020, 'western', 'international', 'everybody', 'Kimberly Davenport', 'way', '1977-04-16', 'among', 'enjoy', '1981-08-20', '1985-01-24', '1989-05-05');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1024, 1020, 'western', 'international', 'color', 'Brittany Anderson', 'worker', '1977-04-17', 'help', 'reflect', '1981-08-21', '1985-01-25', '1989-05-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT breed_name FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, LHS.breed_name AS breed_name, RHS.n AS n FROM (SELECT LHS.dog_id AS dog_id, LHS.owner_id AS owner_id, LHS.abandoned_yn AS abandoned_yn, LHS.breed_code AS breed_code, LHS.size_code AS size_code, LHS.name AS name, LHS.age AS age, LHS.date_of_birth AS date_of_birth, LHS.gender AS gender, LHS.weight AS weight, LHS.date_arrived AS date_arrived, LHS.date_adopted AS date_adopted, LHS.date_departed AS date_departed, RHS.breed_name AS breed_name FROM dogs AS LHS INNER JOIN breeds AS RHS ON (LHS.breed_code = RHS.breed_code)) AS LHS INNER JOIN (SELECT breed_code, breed_name, COUNT(*) OVER () AS n FROM breeds) AS RHS ON (LHS.breed_code = RHS.breed_code AND LHS.breed_name = RHS.breed_name)) ORDER BY date_adopted) LIMIT 1);

/*
Gold Result:
('Lauren Williams',)
*/

-- Prediction Query
SELECT T1.breed_name FROM Breeds AS T1 JOIN Dogs AS T2 ON T1.breed_code = T2.breed_code GROUP BY T1.breed_name ORDER BY COUNT(*) DESC, T1.breed_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Kevin Hall',)
*/