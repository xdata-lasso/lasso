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
-- Core behavior: Multiple "Ray" customers, distinct lesson_status_code groups, non-Ray customer exclusion, and ORDER BY verification.
INSERT INTO Customers (customer_id, first_name, last_name) VALUES (1, 'Ray', 'Charles');
INSERT INTO Customers (customer_id, first_name, last_name) VALUES (2, 'Ray', 'Romano');
INSERT INTO Customers (customer_id, first_name, last_name) VALUES (3, 'Alice', 'Smith');
-- Customer 1 ('Ray') has 3 'Completed' and 1 'Cancelled' (produces counts 3 and 1)
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (101, 1, 'Completed');
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (102, 1, 'Completed');
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (103, 1, 'Completed');
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (104, 1, 'Cancelled');
-- Customer 2 ('Ray') has 2 'Completed' (produces count 2; tests grouping by customer_id AND lesson_status_code)
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (105, 2, 'Completed');
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (106, 2, 'Completed');
-- Customer 3 ('Alice') has 4 'Completed' (should be excluded by NOT EXISTS)
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (107, 3, 'Completed');
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (108, 3, 'Completed');
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (109, 3, 'Completed');
INSERT INTO Lessons (lesson_id, customer_id, lesson_status_code) VALUES (110, 3, 'Completed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT * FROM (SELECT "customer_id", "lesson_status_code", COUNT(*) AS "n" FROM "lessons" GROUP BY "customer_id", "lesson_status_code") AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "customers" WHERE ("first_name" <> 'Ray')) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Lessons AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'Ray';

/*
Prediction Result:
(6,)
*/