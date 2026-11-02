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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('manager', 'Glen Sheppard');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('main', 'Julia Estrada');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1029, 'Johnny', 'Hensley', '7190 Edward Port
Christopherbury, DE 73648', 'Obrienbury', 'Wyoming', '68995', 'chayes@example.com', '001-564-699-0913', '+1-212-532-8120x67974');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1039, 'Rachel', 'Marshall', '75946 Bryant Hollow
South Melissa, CT 31592', 'Armstrongshire', 'Maine', '92156', 'andrew64@example.org', '001-509-674-3953', '+1-421-504-7095x21456');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1030, 'Homeopath', 'Jasmine', '34936 Amy Rue Apt. 421
East Laurashire, PW 38329', 'Martinezport', 'Vermont', '53258', 'Bender', 'mkim@example.org', '(959)940-1399x04902', '429-767-1756x551');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1040, 'Consulting civil engineer', 'Kristin', '842 Sloan Orchard Suite 517
East Karenbury, VI 89148', 'Coffeyside', 'Mississippi', '12337', 'Gibbs', 'bakerdavid@example.com', '+1-349-965-1370x98593', '001-446-812-0047x113');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1035, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('its', 'Explain war spend nearly lawyer fire follow.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('long', 'Provide sea watch industry score choice.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('spring', 'Ten stay ability thank left approach.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('join', 'Street past voice evidence.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('child', NULL);
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1031, 1029, 'its', 'manager', 'national', 'Peter Garrett', 'soon', '1995-04-03', 'approach', 'Democrat', '1996-05-04', '1997-06-05', '1998-07-06');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1041, 1039, 'long', 'main', 'road', 'Jeremy Sampson', 'top', '1976-03-13', 'him', 'bit', '1977-04-14', '1978-05-15', '1979-06-16');
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1032, 1031, 1030, 'spring', '1970-08-07', 1033.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1037, 1031, 1035, 'child', '1975-02-12', 1038.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1042, 1041, 1040, 'join', '1980-07-17', 1043.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT date_arrived, date_departed FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.owner_id AS owner_id, RHS.abandoned_yn AS abandoned_yn, RHS.breed_code AS breed_code, RHS.size_code AS size_code, RHS.name AS name, RHS.age AS age, RHS.date_of_birth AS date_of_birth, RHS.gender AS gender, RHS.weight AS weight, RHS.date_arrived AS date_arrived, RHS.date_adopted AS date_adopted, RHS.date_departed AS date_departed FROM treatments AS LHS INNER JOIN dogs AS RHS ON (LHS.dog_id = RHS.dog_id)) ORDER BY date_arrived, date_departed NULLS LAST;

/*
Gold Result:
('1977-04-14', '1979-06-16')
('1996-05-04', '1998-07-06')
*/

-- Prediction Query
SELECT DISTINCT T1.date_arrived, T1.date_departed FROM Dogs AS T1 JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id;

/*
Prediction Result:
('1996-05-04', '1998-07-06')
('1977-04-14', '1979-06-16')
*/