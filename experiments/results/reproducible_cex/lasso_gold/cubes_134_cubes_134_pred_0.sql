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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('movement', 'Sandy Stephenson');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('many', 'James Brooks');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1063, 'Benjamin', 'Rogers', '622 Marie Trail
Lake Samuel, MT 48250', 'South Cheryl', 'Wisconsin', '98613', 'pyoung@example.com', '435.697.7468x8623', '4756818141');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1068, 'Julie', 'Kelly', '195 Bradley Plains
Lisaburgh, MP 90243', 'Pollardfort', 'South Dakota', '24392', 'bryanparsons@example.com', '8439030548', '903-845-0541x566');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1064, 'Production assistant, television', 'Heather', '37506 Randy Landing Apt. 615
North Lucas, CT 94178', 'Laceyberg', 'Arizona', '38102', 'Lowery', 'ihorton@example.net', '379.601.0432x8986', '341.903.6971');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1069, 'Librarian, academic', 'Rebecca', '8416 Ryan View Apt. 845
North Markport, ME 58948', 'Jacksonmouth', 'Minnesota', '59107', 'Williams', 'christina64@example.net', '9162582029', '(413)955-6909');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('picture', 'Administration middle drop century investment pass drive.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('hospital', 'Know baby case happen fire everything.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('keep', 'Professor beat window attack.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('build', 'Save material hit.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1065, 1063, 'picture', 'movement', 'never', 'Rachel Romero', 'again', '1971-05-14', 'in', 'TV', '1972-06-15', '1973-07-16', '1974-08-17');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1070, 1068, 'hospital', 'many', 'or', 'Reginald Padilla', 'difficult', '1976-10-19', 'population', 'feeling', '1977-11-20', '1978-01-21', '1979-02-22');
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1066, 1065, 1064, 'keep', '1975-09-19', 1067.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1071, 1070, 1069, 'build', '1975-09-18', 1072.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_treatment, first_name FROM (SELECT LHS.treatment_id AS treatment_id, LHS.dog_id AS dog_id, LHS.professional_id AS professional_id, LHS.treatment_type_code AS treatment_type_code, LHS.date_of_treatment AS date_of_treatment, LHS.cost_of_treatment AS cost_of_treatment, RHS.role_code AS role_code, RHS.first_name AS first_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.last_name AS last_name, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM treatments AS LHS INNER JOIN professionals AS RHS ON (LHS.professional_id = RHS.professional_id)) ORDER BY date_of_treatment, first_name NULLS LAST;

/*
Gold Result:
('1975-09-18', 'Rebecca')
('1975-09-19', 'Heather')
*/

-- Prediction Query
SELECT T1.date_of_treatment, T2.first_name FROM Treatments AS T1 JOIN Professionals AS T2 ON T1.professional_id = T2.professional_id;

/*
Prediction Result:
('1975-09-19', 'Heather')
('1975-09-18', 'Rebecca')
*/