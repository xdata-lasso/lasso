-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '123 St', 'City', '12345', 'State', 'Country');
INSERT INTO Staff (staff_id, staff_address_id, first_name, last_name) VALUES (1, 1, 'Janessa', 'Sawayn');
INSERT INTO Customers (customer_id, customer_address_id, first_name, last_name) VALUES (1, 1, 'John', 'Doe');
INSERT INTO Vehicles (vehicle_id, vehicle_details) VALUES (1, 'Car');
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, price) VALUES (1, 1, 1, 1, 10.0);
INSERT INTO Lessons (lesson_id, customer_id, staff_id, vehicle_id, price) VALUES (2, 1, 1, 1, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "price" AS "avg_price_" FROM (SELECT "LHS"."staff_id" AS "staff_id", "LHS"."staff_address_id" AS "staff_address_id", "LHS"."nickname" AS "nickname", "LHS"."first_name" AS "first_name", "LHS"."middle_name" AS "middle_name", "LHS"."last_name" AS "last_name", "LHS"."date_of_birth" AS "date_of_birth", "LHS"."date_joined_staff" AS "date_joined_staff", "LHS"."date_left_staff" AS "date_left_staff", "RHS"."lesson_id" AS "lesson_id", "RHS"."customer_id" AS "customer_id", "RHS"."lesson_status_code" AS "lesson_status_code", "RHS"."vehicle_id" AS "vehicle_id", "RHS"."lesson_date" AS "lesson_date", "RHS"."lesson_time" AS "lesson_time", "RHS"."price" AS "price" FROM "staff" AS "LHS" INNER JOIN "lessons" AS "RHS" ON ("LHS"."staff_id" = "RHS"."staff_id")) WHERE ("first_name" = 'Janessa' AND "last_name" = 'Sawayn') ORDER BY avg_price_;

/*
Gold Result:
(10.0,)
(20.0,)
*/

-- Prediction Query
SELECT AVG(price) FROM Lessons AS T1 JOIN Staff AS T2 ON T1.staff_id = T2.staff_id WHERE T2.first_name = 'Janessa' AND T2.last_name = 'Sawayn';

/*
Prediction Result:
(15.0,)
*/