-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1001, 'purpose', 'Johnberg', '12781', 'North Carolina', 'Monaco');
INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1002, 'brother', 'Lake Joyside', '29158', 'Rhode Island', 'Congo');
INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1003, 'ago', 'New Roberttown', '30996', 'Alaska', 'Saint Barthelemy');
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1004, 1001, 'rate', '1970-01-01', '1973-04-04', 'Jacqueline', 'Ramirez', 1007.5, 'helenpeterson@example.org', '507-381-6184x959', '+1-850-930-5641x39537');
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1005, 1001, 'rate', '1970-01-02', '1973-04-05', 'Robert', 'Booth', 1024.5, 'susanrogers@example.org', '7344131647', '(842)738-8496');
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1006, 1001, 'rate', '1970-01-03', '1973-04-06', 'Shane', 'Blake', 1041.5, 'wdavis@example.net', '(653)541-9283x276', '828.371.0122');
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1010, 1001, 'image', '1976-07-07', '1979-10-10', 'Patrick', 'Maddox', 1013.5, 'maldonadoamanda@example.com', '728.914.8932x52880', '+1-534-565-7871');
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1011, 1001, 'image', '1976-07-08', '1979-10-11', 'Wendy', 'Valencia', 1030.5, 'daniel62@example.com', '3159430391', '350-298-3930');
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1012, 1001, 'image', '1976-07-09', '1979-10-12', 'Allison', 'Smith', 1047.5, 'mckaynancy@example.com', '882-527-8248', '510.451.8347');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_status_code_other AS customer_status_code FROM (SELECT LHS.customer_status_code AS customer_status_code, LHS.n AS n, RHS.customer_status_code AS customer_status_code_other, RHS.n AS n_other FROM (SELECT customer_status_code, COUNT(*) AS n FROM customers GROUP BY customer_status_code) AS LHS CROSS JOIN (SELECT customer_status_code, COUNT(*) AS n FROM customers GROUP BY customer_status_code) AS RHS) WHERE (n > n_other) ORDER BY customer_status_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT customer_status_code FROM Customers GROUP BY customer_status_code ORDER BY COUNT(*) ASC, customer_status_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('image',)
*/