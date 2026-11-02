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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('about', 'Sherri Baker');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('my', 'Michael Lewis');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1006, 'Vincent', 'White', 'PSC 4893, Box 2528
APO AP 00575', 'Tracyville', 'Mississippi', '40807', 'brianhumphrey@example.org', '671-882-2782', '383.546.5787');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1008, 'David', 'Walls', '76311 Gomez Loop Suite 010
Chandlerville, IA 25613', 'New Shane', 'Nevada', '24551', 'steven17@example.net', '908-501-3267', '(502)660-6474x6872');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('down', 'Full open discover detail.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('director', 'Often my security arm.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1007, 1006, 'down', 'about', 'avoid', 'Amy Jones', 'almost', '1978-09-09', 'movie', 'be', '1979-10-11', '1980-11-11', '1981-01-12');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1009, 1008, 'director', 'my', 'pattern', 'Thomas Schmidt', 'art', '1982-02-13', 'trade', 'give', '1979-10-10', '1984-04-15', '1985-05-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_arrived, date_departed FROM dogs ORDER BY date_arrived, dogs.dog_id NULLS LAST;

/*
Gold Result:
('1979-10-10', '1985-05-16')
('1979-10-11', '1981-01-12')
*/

-- Prediction Query
SELECT date_arrived, date_departed FROM Dogs;

/*
Prediction Result:
('1979-10-11', '1981-01-12')
('1979-10-10', '1985-05-16')
*/