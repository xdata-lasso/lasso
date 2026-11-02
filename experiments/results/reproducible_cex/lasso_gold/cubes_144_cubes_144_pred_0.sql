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
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('religious', 'Melissa Fernandez');
INSERT INTO "breeds" ("breed_code", "breed_name") VALUES ('young', 'Monica Kerr');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1036, 'Brenda', 'Barber', '9640 Robinson Mills
Port Michael, TX 48648', 'Bruceview', 'Illinois', '16512', 'ndavis@example.net', '+1-590-505-3293x1839', '729-504-2284x21020');
INSERT INTO "owners" ("owner_id", "first_name", "last_name", "street", "city", "state", "zip_code", "email_address", "home_phone", "cell_number") VALUES (1038, 'Donna', 'Turner', '76617 Jones Common
Charleneland, DC 36547', 'Oscarhaven', 'Maine', '59970', 'sgarcia@example.org', '+1-883-767-3657x6615', '+1-245-727-1111x61528');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('per', 'Administration enter camera inside box as.');
INSERT INTO "sizes" ("size_code", "size_description") VALUES ('can', 'Government program seek test return why.');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1037, 1036, 'per', 'religious', '1', 'Ivan Wheeler', 'difference', '1980-03-23', 'clear', 'do', '1981-04-01', '1982-05-02', '1983-06-03');
INSERT INTO "dogs" ("dog_id", "owner_id", "size_code", "breed_code", "abandoned_yn", "name", "age", "date_of_birth", "gender", "weight", "date_arrived", "date_adopted", "date_departed") VALUES (1039, 1038, 'can', 'young', '1', 'Dr. Gregory Hawkins', 'live', '1984-07-04', 'most', 'realize', '1985-08-05', '1986-09-06', '1987-10-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age, weight FROM dogs WHERE (abandoned_yn = 1) ORDER BY name, dogs.dog_id NULLS LAST;

/*
Gold Result:
('Dr. Gregory Hawkins', 'live', 'realize')
('Ivan Wheeler', 'difference', 'do')
*/

-- Prediction Query
SELECT name, age, weight FROM Dogs WHERE abandoned_yn = 1;

/*
Prediction Result:
('Ivan Wheeler', 'difference', 'do')
('Dr. Gregory Hawkins', 'live', 'realize')
*/