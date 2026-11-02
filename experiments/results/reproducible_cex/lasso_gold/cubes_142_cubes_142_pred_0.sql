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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('glass', 'Shelly Alexander');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('card', 'Mark Kelley');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1039, 'Alicia', 'Bryant', '217 Morgan Square Suite 158
Finleyfort, VI 71413', 'New Caseyport', 'Iowa', '98381', 'hamiltoncorey@example.net', '001-817-424-0050x455', '886.592.2219');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1049, 'Mark', 'Vang', '961 Melissa Run Apt. 673
Morganmouth, MO 55025', 'West Ronaldview', 'Mississippi', '20507', 'fjones@example.org', '(215)628-0988x51656', '+1-745-319-8327x315');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1040, 'Research scientist (medical)', 'Roberta', '474 Rachel Mountain Suite 821
Landryshire, ME 84247', 'Vaughnmouth', 'Maryland', '26612', 'Kidd', 'yrodriguez@example.net', '(694)540-6409x097', '+1-753-439-4210x470');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1050, 'Health promotion specialist', 'Audrey', '402 Park Inlet
Michaelburgh, VI 19277', 'Jonestown', 'Colorado', '98295', 'Moreno', 'vbarnes@example.org', '(645)999-1022x901', '+1-967-697-6438x15614');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('believe', 'Force indeed customer skill theory.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('answer', 'House out account feeling deep.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('history', 'Maybe evening clearly trial want whose far.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('certain', 'Face build market issue can.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1041, 1039, 'believe', 'glass', 'truth', 'Brian Mccarty', 'chance', '1980-07-17', 'somebody', 'draw', '1981-08-18', '1982-09-19', '1983-10-20');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1051, 1049, 'answer', 'card', 'no', 'Kathryn Whitaker', 'sure', '1990-06-04', 'health', 'away', '1991-07-05', '1992-08-06', '1993-09-07');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1046, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1042, 1041, 1040, 'history', '1984-11-21', 1043.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1047, 1046, 1040, 'history', '1989-05-03', 1048.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1052, 1051, 1050, 'certain', '1994-10-08', 1053.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT first_name, treatment_type_description FROM (SELECT LHS.treatment_type_code AS treatment_type_code, LHS.treatment_type_description AS treatment_type_description, LHS.professional_id AS professional_id, LHS.role_code AS role_code, LHS.first_name AS first_name, LHS.street AS street, LHS.city AS city, LHS.state AS state, LHS.zip_code AS zip_code, LHS.last_name AS last_name, LHS.email_address AS email_address, LHS.home_phone AS home_phone, LHS.cell_number AS cell_number, RHS.treatment_id AS treatment_id, RHS.dog_id AS dog_id, RHS.date_of_treatment AS date_of_treatment, RHS.cost_of_treatment AS cost_of_treatment FROM (SELECT LHS.treatment_type_code AS treatment_type_code, LHS.treatment_type_description AS treatment_type_description, RHS.professional_id AS professional_id, RHS.role_code AS role_code, RHS.first_name AS first_name, RHS.street AS street, RHS.city AS city, RHS.state AS state, RHS.zip_code AS zip_code, RHS.last_name AS last_name, RHS.email_address AS email_address, RHS.home_phone AS home_phone, RHS.cell_number AS cell_number FROM treatment_types AS LHS CROSS JOIN professionals AS RHS) AS LHS INNER JOIN treatments AS RHS ON (LHS.treatment_type_code = RHS.treatment_type_code AND LHS.professional_id = RHS.professional_id)) ORDER BY first_name, treatment_type_description NULLS LAST;

/*
Gold Result:
('Audrey', 'Face build market issue can.')
('Roberta', 'Maybe evening clearly trial want whose far.')
*/

-- Prediction Query
SELECT DISTINCT T1.first_name, T3.treatment_type_description FROM professionals AS T1 JOIN Treatments AS T2 ON T1.professional_id = T2.professional_id JOIN Treatment_types AS T3 ON T2.treatment_type_code = T3.treatment_type_code;

/*
Prediction Result:
('Roberta', 'Maybe evening clearly trial want whose far.')
('Audrey', 'Face build market issue can.')
*/