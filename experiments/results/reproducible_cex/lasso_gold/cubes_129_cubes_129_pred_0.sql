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
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1012, 'Legal executive', 'Patricia', '231 Russell Plains Suite 603
Priceshire, UT 03061', 'Ramseymouth', 'Hawaii', '52146', 'Elliott', 'dtaylor@example.org', '256-246-4170x80531', '001-645-829-9124x190');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1013, 'IT consultant', 'Christopher', '0546 Medina Street Apt. 734
Tuckerfurt, MA 88171', 'New Amanda', 'Wisconsin', '78081', 'Johnson', 'greenmark@example.com', '530.992.3271', '(831)793-1491x9058');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1014, 'Broadcast presenter', 'Deborah', '65726 Jessica Run Suite 987
Grahamshire, KY 42746', 'Joshuaview', 'Hawaii', '32136', 'Russell', 'hannahbrewer@example.com', '763.849.5788', '674.598.9413');
INSERT INTO "professionals" ("professional_id", "role_code", "first_name", "street", "city", "state", "zip_code", "last_name", "email_address", "home_phone", "cell_number") VALUES (1015, 'Risk manager', 'Alexander', '7379 Rogers Park
Hunterborough, MI 34363', 'New Stacyland', 'Wisconsin', '94882', 'Peters', 'fmcguire@example.com', '001-485-557-4443x1351', '(924)308-2400x842');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "email_address" FROM "professionals" WHERE ("state" = 'Hawaii' OR "state" = 'Wisconsin') ORDER BY email_address, professionals.professional_id NULLS LAST;

/*
Gold Result:
('dtaylor@example.org',)
('fmcguire@example.com',)
('greenmark@example.com',)
('hannahbrewer@example.com',)
*/

-- Prediction Query
SELECT email_address FROM Professionals WHERE state = 'Hawaii' OR state = 'Wisconsin';

/*
Prediction Result:
('dtaylor@example.org',)
('greenmark@example.com',)
('hannahbrewer@example.com',)
('fmcguire@example.com',)
*/