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
INSERT INTO "discount_coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (1214, '1971-01-20', 1215.5);
INSERT INTO "discount_coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (1226, '1976-06-02', 1227.5);
INSERT INTO "products_for_hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (1216, 'clear', 1217.5, 'Book collection A', 'Father why often my security.');
INSERT INTO "products_for_hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (1228, 'today', 1229.5, 'Book collection A', 'Attention attack technology identify.');
INSERT INTO "customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (1218, 1214, 'art', 'Brendan', 'Woods', 'wide', '1972-02-21', '1973-03-22');
INSERT INTO "customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (1230, 1226, 'year', 'Pamela', 'Sanchez', 'phone', '1977-07-03', '1978-08-04');
INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (1219, 1218, 'among', 'nice', '1974-04-24', '1975-05-01', 'beat', 1220.5, 1221.5, 1222.5, 1223.5);
INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (1231, 1230, 'tonight', 'president', '1974-04-23', '1975-05-02', 'coach', 1232.5, 1233.5, 1234.5, 1235.5);
INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (1219, 1216, 'movie', 'be', 1224, 1225.5);
INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (1231, 1228, 'kind', 'really', 1236, 1237.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "booking_start_date", "booking_end_date" FROM (SELECT "LHS"."booking_id" AS "booking_id", "LHS"."customer_id" AS "customer_id", "LHS"."booking_status_code" AS "booking_status_code", "LHS"."returned_damaged_yn" AS "returned_damaged_yn", "LHS"."booking_start_date" AS "booking_start_date", "LHS"."booking_end_date" AS "booking_end_date", "LHS"."count_hired" AS "count_hired", "LHS"."amount_payable" AS "amount_payable", "LHS"."amount_of_discount" AS "amount_of_discount", "LHS"."amount_outstanding" AS "amount_outstanding", "LHS"."amount_of_refund" AS "amount_of_refund", "LHS"."product_id" AS "product_id", "LHS"."returned_yn" AS "returned_yn", "LHS"."returned_late_yn" AS "returned_late_yn", "LHS"."booked_count" AS "booked_count", "LHS"."booked_amount" AS "booked_amount", "RHS"."product_type_code" AS "product_type_code", "RHS"."daily_hire_cost" AS "daily_hire_cost", "RHS"."product_name" AS "product_name", "RHS"."product_description" AS "product_description" FROM (SELECT "LHS"."booking_id" AS "booking_id", "LHS"."customer_id" AS "customer_id", "LHS"."booking_status_code" AS "booking_status_code", "LHS"."returned_damaged_yn" AS "returned_damaged_yn", "LHS"."booking_start_date" AS "booking_start_date", "LHS"."booking_end_date" AS "booking_end_date", "LHS"."count_hired" AS "count_hired", "LHS"."amount_payable" AS "amount_payable", "LHS"."amount_of_discount" AS "amount_of_discount", "LHS"."amount_outstanding" AS "amount_outstanding", "LHS"."amount_of_refund" AS "amount_of_refund", "RHS"."product_id" AS "product_id", "RHS"."returned_yn" AS "returned_yn", "RHS"."returned_late_yn" AS "returned_late_yn", "RHS"."booked_count" AS "booked_count", "RHS"."booked_amount" AS "booked_amount" FROM "bookings" AS "LHS" INNER JOIN "products_booked" AS "RHS" ON ("LHS"."booking_id" = "RHS"."booking_id")) AS "LHS" INNER JOIN (SELECT * FROM "products_for_hire" WHERE ("product_name" = 'Book collection A')) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY booking_start_date, "booking_start_date" NULLS LAST, "booking_end_date" NULLS LAST;

/*
Gold Result:
('1974-04-23', '1975-05-02')
('1974-04-24', '1975-05-01')
*/

-- Prediction Query
SELECT T3.booking_start_date, T3.booking_end_date FROM Products_for_hire AS T1 JOIN products_booked AS T2 ON T1.product_id = T2.product_id JOIN bookings AS T3 ON T2.booking_id = T3.booking_id WHERE T1.product_name = 'Book collection A';

/*
Prediction Result:
('1974-04-24', '1975-05-01')
('1974-04-23', '1975-05-02')
*/