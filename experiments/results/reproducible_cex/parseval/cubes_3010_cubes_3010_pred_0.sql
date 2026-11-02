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
-- Inserting into table: bookings --
INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483648, -2147483648, 'boo_6a2048', 'boo_455245', '2025-06-10 18:20:47+00:00', '2024-02-22 05:22:28+00:00', 'boo_67dfab', 0.0001, 0.0001, 0.0001, 0.0001);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483647, -2147483648, 'boo_6a2048', 'boo_455245', '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00', 'boo_67dfab', 0.0002, 0.0002, 0.0002, 0.0002);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483646, -2147483648, 'boo_6a2048', 'boo_455245', '2024-06-06 00:28:47+00:00', '2022-10-19 03:44:42+00:00', 'boo_67dfab', 0.0003, 0.0003, 0.0003, 0.0003);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483645, -2147483648, 'boo_6a2048', 'boo_455245', '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', 'boo_67dfab', 0.0004, 0.0004, 0.0004, 0.0004);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483644, -2147483648, 'boo_6a2048', 'boo_455245', '2025-08-22 00:34:24+00:00', '2022-04-13 09:01:25+00:00', 'boo_67dfab', 0.0005, 0.0005, 0.0005, 0.0005);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483643, -2147483648, 'boo_6a2048', 'boo_455245', '2022-01-03 02:42:55+00:00', '2024-04-12 00:38:47+00:00', 'boo_67dfab', 0.0006, 0.0006, 0.0006, 0.0006);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483642, -2147483648, 'boo_6a2048', 'boo_455245', '2022-11-06 10:19:41+00:00', '2020-06-20 11:35:06+00:00', 'boo_67dfab', 0.0007, 0.0007, 0.0007, 0.0007);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483641, -2147483648, 'boo_6a2048', 'boo_455245', '2021-07-20 10:41:36+00:00', '2020-03-11 00:23:16+00:00', 'boo_67dfab', 0.0008, 0.0008, 0.0008, 0.0008);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483640, -2147483648, 'boo_6a2048', 'boo_455245', '2025-09-01 05:13:03+00:00', '2025-03-03 08:26:45+00:00', 'boo_67dfab', 0.0009, 0.0009, 0.0009, 0.0009);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483639, -2147483648, 'boo_6a2048', 'boo_455245', '2021-02-17 05:47:13+00:00', '2021-01-29 03:06:29+00:00', 'boo_67dfab', 0.001, 0.001, 0.001, 0.001);

INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (-2147483638, -2147483648, 'boo_6a2048', 'boo_455245', '2024-05-04 23:07:19+00:00', '2021-05-18 10:50:30+00:00', 'boo_67dfab', 0.0011, 0.0011, 0.0011, 0.0011);

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (-2147483648, -2147483648, '7c18', 'cus_3e707b', 'cus_c0de68', '4', '2025-11-23 07:28:46+00:00', '2025-10-14 06:39:08+00:00');

-- Inserting into table: products_for_hire --
INSERT INTO "products_for_hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (1, 'pro_8772c9', 0.0001, 'pro_47e504', 't2__963df6');

INSERT INTO "products_for_hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (-2147483647, 'pro_8772c9', 0.0002, 'pro_47e504', 't2__963df6');

INSERT INTO "products_for_hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (3, 'pro_8772c9', 0.0003, 'pro_47e504', 'pro_8f74f5');

INSERT INTO "products_for_hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (2, 'pro_8772c9', 0.0004, 'pro_47e504', 'pro_8f74f5');

-- Inserting into table: discount_coupons --
INSERT INTO "discount_coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (-2147483648, '2024-12-15 00:56:33+00:00', 0.0001);

-- Inserting into table: products_booked --
INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483648, 1, '6', '6', -1437333179, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483647, 1, '6', '6', -1981402255, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483647, 3, '6', '6', 247012447, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483648, 2, '6', '6', -106629402, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483646, 2, '6', '6', -1865039888, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483645, 2, '6', '6', 1914020640, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483645, 1, '6', '6', 1219478689, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483646, 1, '6', '6', 1644814318, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483644, 1, '6', '6', 906324270, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483643, 1, '6', '6', -1349201381, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483642, 1, '6', '6', -1377057208, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483641, 1, '6', '6', -1257178728, 102.76);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483640, 1, '6', '6', 907682809, 1.0);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483639, 1, '6', '6', -1823627488, 327.753528);

INSERT INTO "products_booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (-2147483638, 1, '6', '6', 1151980946, 102.76);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_description FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.daily_hire_cost AS daily_hire_cost, LHS.product_name AS product_name, LHS.product_description AS product_description, RHS.booking_id AS booking_id, RHS.returned_yn AS returned_yn, RHS.returned_late_yn AS returned_late_yn, RHS.booked_count AS booked_count, RHS.booked_amount AS booked_amount FROM products_for_hire AS LHS INNER JOIN products_booked AS RHS ON (LHS.product_id = RHS.product_id)) WHERE (booked_amount <= 102.76) ORDER BY product_description;

/*
Gold Result:
('pro_8f74f5',)
('pro_8f74f5',)
('pro_8f74f5',)
('pro_8f74f5',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
*/

-- Prediction Query
SELECT T2.product_description FROM products_booked AS T1 JOIN products_for_hire AS T2 ON T1.product_id = T2.product_id WHERE T1.booked_amount = 102.76;

/*
Prediction Result:
('t2__963df6',)
('t2__963df6',)
('pro_8f74f5',)
('pro_8f74f5',)
('pro_8f74f5',)
('pro_8f74f5',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
('t2__963df6',)
*/