-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests OR vs AND in the WHERE clause, non-matching rows, and column confusion (nickname/middle_name vs first_name/last_name, city/zip vs country/state_province_county).
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, '100 Main St', 'Austin', '78701', 'Texas', 'USA');
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (2, '200 Oak Ave', 'Toronto', 'M5V 2T6', 'Ontario', 'Canada');
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (3, '300 Pine Rd', 'London', 'SW1A 1AA', 'Greater London', 'UK');
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (4, '400 Elm St', 'Sydney', '2000', 'NSW', 'Australia');
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (5, '500 Birch Ln', 'Berlin', '10115', 'Berlin', 'Germany');
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (10, 1, 'Jan', 'Janessa', 'Marie', 'Doe', '1985-04-12', '2015-01-10', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (20, 2, 'Saw', 'Robert', 'Lee', 'Sawayn', '1990-08-22', '2018-06-15', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (30, 3, 'Janie', 'Janessa', 'Ann', 'Sawayn', '1988-11-05', '2016-03-20', '2021-12-31');
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (40, 4, 'Janessa', 'Alice', 'Sawayn', 'Smith', '1992-02-14', '2019-09-01', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (50, 5, 'Sawayn', 'Sawayn', 'Janessa', 'Janessa', '1980-07-30', '2010-05-05', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country", "state_province_county" FROM (SELECT "address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country", "staff_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff", "address_id" AS "staff_address_id" FROM (SELECT "LHS"."address_id" AS "address_id", "LHS"."line_1_number_building" AS "line_1_number_building", "LHS"."city" AS "city", "LHS"."zip_postcode" AS "zip_postcode", "LHS"."state_province_county" AS "state_province_county", "LHS"."country" AS "country", "RHS"."staff_id" AS "staff_id", "RHS"."nickname" AS "nickname", "RHS"."first_name" AS "first_name", "RHS"."middle_name" AS "middle_name", "RHS"."last_name" AS "last_name", "RHS"."date_of_birth" AS "date_of_birth", "RHS"."date_joined_staff" AS "date_joined_staff", "RHS"."date_left_staff" AS "date_left_staff" FROM "addresses" AS "LHS" INNER JOIN "staff" AS "RHS" ON ("LHS"."address_id" = "RHS"."staff_address_id"))) WHERE ("first_name" = 'Janessa' OR "last_name" = 'Sawayn') ORDER BY country, "country" NULLS LAST, "state_province_county" NULLS LAST;

/*
Gold Result:
('Canada', 'Ontario')
('UK', 'Greater London')
('USA', 'Texas')
*/

-- Prediction Query
SELECT T1.country, T1.state_province_county FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T2.first_name = 'Janessa' AND T2.last_name = 'Sawayn';

/*
Prediction Result:
('UK', 'Greater London')
*/