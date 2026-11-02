-- Schema DDL
CREATE TABLE "Discount_Coupons" ("coupon_id" INTEGER PRIMARY KEY, "date_issued" DATETIME, "coupon_amount" REAL(19, 4));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "coupon_id" INTEGER, "good_or_bad_customer" TEXT(4), "first_name" TEXT(80), "last_name" TEXT(80), "gender_mf" TEXT(1), "date_became_customer" DATETIME, "date_last_hire" DATETIME, FOREIGN KEY ("coupon_id") REFERENCES "Discount_Coupons" ("coupon_id"));

CREATE TABLE "Bookings" ("booking_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "booking_status_code" TEXT(10), "returned_damaged_yn" TEXT(40), "booking_start_date" DATETIME, "booking_end_date" DATETIME, "count_hired" TEXT(40), "amount_payable" REAL(19, 4), "amount_of_discount" REAL(19, 4), "amount_outstanding" REAL(19, 4), "amount_of_refund" REAL(19, 4), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Products_for_Hire" ("product_id" INTEGER PRIMARY KEY, "product_type_code" TEXT(15), "daily_hire_cost" REAL(19, 4), "product_name" TEXT(80), "product_description" TEXT(255));

CREATE TABLE "Payments" ("payment_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "booking_id" INTEGER, "payment_type_code" TEXT(15), "amount_paid_in_full_yn" TEXT(1), "payment_date" DATETIME, "amount_due" REAL(19, 4), "amount_paid" REAL(19, 4), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("booking_id") REFERENCES "Bookings" ("booking_id"));

CREATE TABLE "Products_Booked" ("booking_id" INTEGER, "product_id" INTEGER, "returned_yn" TEXT(1), "returned_late_yn" TEXT(1), "booked_count" INTEGER, "booked_amount" REAL, PRIMARY KEY ("booking_id", "product_id"), FOREIGN KEY ("product_id") REFERENCES "Products_for_Hire" ("product_id"), FOREIGN KEY ("booking_id") REFERENCES "Bookings" ("booking_id"));

CREATE TABLE "View_Product_Availability" ("status_date" DATETIME PRIMARY KEY, "product_id" INTEGER, "booking_id" INTEGER, "available_yn" TEXT(1), FOREIGN KEY ("product_id") REFERENCES "Products_for_Hire" ("product_id"), FOREIGN KEY ("booking_id") REFERENCES "Bookings" ("booking_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate rows (SELECT vs SELECT DISTINCT), multiple products with the same name, and tie-breaking in ORDER BY.
INSERT INTO "Customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (1, NULL, 'good', 'Alice', 'Smith', 'F', '2022-01-01', '2022-02-01');
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (10, 'TYPE1', 10.0, 'Book collection A', 'First copy');
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (20, 'TYPE2', 15.0, 'Book collection A', 'Second copy');
-- Same booking_start_date and booking_end_date across multiple bookings/products to test DISTINCT vs ALL
INSERT INTO "Bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (100, 1, 'OK', 'N', '2023-03-10', '2023-03-15', '2', 50.0, 0.0, 0.0, 0.0);
INSERT INTO "Bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (101, 1, 'OK', 'Y', '2023-03-10', '2023-03-12', '1', 20.0, 0.0, 0.0, 0.0);
INSERT INTO "Bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (102, 1, 'CANC', 'N', '2023-01-05', '2023-01-10', '1', 30.0, 0.0, 0.0, 0.0);
-- Booking 100 books both product 10 and 20 (both named 'Book collection A'), producing identical output rows
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (100, 10, 'Y', 'N', 1, 25.0);
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (100, 20, 'N', 'Y', 1, 25.0);
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (101, 10, 'Y', 'N', 1, 20.0);
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (102, 20, 'N', 'N', 1, 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "booking_start_date", "booking_end_date" FROM (SELECT "LHS"."booking_id" AS "booking_id", "LHS"."customer_id" AS "customer_id", "LHS"."booking_status_code" AS "booking_status_code", "LHS"."returned_damaged_yn" AS "returned_damaged_yn", "LHS"."booking_start_date" AS "booking_start_date", "LHS"."booking_end_date" AS "booking_end_date", "LHS"."count_hired" AS "count_hired", "LHS"."amount_payable" AS "amount_payable", "LHS"."amount_of_discount" AS "amount_of_discount", "LHS"."amount_outstanding" AS "amount_outstanding", "LHS"."amount_of_refund" AS "amount_of_refund", "LHS"."product_id" AS "product_id", "LHS"."returned_yn" AS "returned_yn", "LHS"."returned_late_yn" AS "returned_late_yn", "LHS"."booked_count" AS "booked_count", "LHS"."booked_amount" AS "booked_amount", "RHS"."product_type_code" AS "product_type_code", "RHS"."daily_hire_cost" AS "daily_hire_cost", "RHS"."product_name" AS "product_name", "RHS"."product_description" AS "product_description" FROM (SELECT "LHS"."booking_id" AS "booking_id", "LHS"."customer_id" AS "customer_id", "LHS"."booking_status_code" AS "booking_status_code", "LHS"."returned_damaged_yn" AS "returned_damaged_yn", "LHS"."booking_start_date" AS "booking_start_date", "LHS"."booking_end_date" AS "booking_end_date", "LHS"."count_hired" AS "count_hired", "LHS"."amount_payable" AS "amount_payable", "LHS"."amount_of_discount" AS "amount_of_discount", "LHS"."amount_outstanding" AS "amount_outstanding", "LHS"."amount_of_refund" AS "amount_of_refund", "RHS"."product_id" AS "product_id", "RHS"."returned_yn" AS "returned_yn", "RHS"."returned_late_yn" AS "returned_late_yn", "RHS"."booked_count" AS "booked_count", "RHS"."booked_amount" AS "booked_amount" FROM "bookings" AS "LHS" INNER JOIN "products_booked" AS "RHS" ON ("LHS"."booking_id" = "RHS"."booking_id")) AS "LHS" INNER JOIN (SELECT * FROM "products_for_hire" WHERE ("product_name" = 'Book collection A')) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY booking_start_date, "booking_start_date" NULLS LAST, "booking_end_date" NULLS LAST;

/*
Gold Result:
('2023-01-05', '2023-01-10')
('2023-03-10', '2023-03-12')
('2023-03-10', '2023-03-15')
('2023-03-10', '2023-03-15')
*/

-- Prediction Query
SELECT T3.booking_start_date, T3.booking_end_date FROM Products_for_hire AS T1 JOIN products_booked AS T2 ON T1.product_id = T2.product_id JOIN bookings AS T3 ON T2.booking_id = T3.booking_id WHERE T1.product_name = 'Book collection A';

/*
Prediction Result:
('2023-03-10', '2023-03-15')
('2023-03-10', '2023-03-15')
('2023-03-10', '2023-03-12')
('2023-01-05', '2023-01-10')
*/