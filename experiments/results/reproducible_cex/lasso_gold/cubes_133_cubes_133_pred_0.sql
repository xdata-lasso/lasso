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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('technology', 'Larry Salas');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('imagine', 'Cody Holt');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1060, 'Brett', 'Castillo', '814 Kathryn Groves
Whiteheadberg, MP 57841', 'East Lisastad', 'Alaska', '54882', 'sandersnathaniel@example.com', '253-605-1522', '827.379.0104x3289');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1065, 'Michael', 'Salinas', '616 Amy Islands
North Markport, ME 58948', 'Jacksonmouth', 'Minnesota', '59107', 'acostarhonda@example.net', '(340)516-5820x29702', '001-455-769-0927x55719');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1061, 'Homeopath', 'John', '9711 Carlson Brook
Lake Douglas, NE 00706', 'Johnchester', 'Idaho', '87581', 'Barnett', 'carlos88@example.net', '380.767.0654x05153', '(405)385-2772');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1066, 'Occupational therapist', 'Leonard', '27868 Jose Green
Lewisport, UT 64883', 'North Derek', 'California', '59751', 'Thompson', 'zosborn@example.net', '451-588-4422x58313', '805.989.5782x9114');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('sense', 'Already cut social though firm financial huge.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('never', 'Shoulder statement available win politics last.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('teacher', 'List already positive experience television answer pretty.');
INSERT INTO "treatment_types" ("treatment_type_code", "treatment_type_description") VALUES ('response', 'Various different way million exist bad.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1062, 1060, 'sense', 'technology', 'explain', 'Jacob Preston', 'six', '1971-05-14', 'less', 'want', '1972-06-15', '1973-07-16', '1974-08-17');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1067, 1065, 'never', 'imagine', 'whether', 'Sandra Holmes', 'fly', '1976-10-19', 'community', 'color', '1977-11-20', '1978-01-21', '1979-02-22');
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1063, 1062, 1061, 'teacher', '1975-09-18', 1065.5);
INSERT INTO "treatments" ("treatment_id", "dog_id", "professional_id", "treatment_type_code", "date_of_treatment", "cost_of_treatment") VALUES (1068, 1067, 1066, 'response', '1980-03-23', 1064.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cost_of_treatment, treatment_type_description FROM (SELECT LHS.treatment_type_code AS treatment_type_code, LHS.treatment_type_description AS treatment_type_description, RHS.treatment_id AS treatment_id, RHS.dog_id AS dog_id, RHS.professional_id AS professional_id, RHS.date_of_treatment AS date_of_treatment, RHS.cost_of_treatment AS cost_of_treatment FROM treatment_types AS LHS INNER JOIN treatments AS RHS ON (LHS.treatment_type_code = RHS.treatment_type_code)) ORDER BY cost_of_treatment, treatment_type_description NULLS LAST;

/*
Gold Result:
(1064.5, 'Various different way million exist bad.')
(1065.5, 'List already positive experience television answer pretty.')
*/

-- Prediction Query
SELECT T1.cost_of_treatment, T2.treatment_type_description FROM Treatments AS T1 JOIN treatment_types AS T2 ON T1.treatment_type_code = T2.treatment_type_code;

/*
Prediction Result:
(1065.5, 'List already positive experience television answer pretty.')
(1064.5, 'Various different way million exist bad.')
*/