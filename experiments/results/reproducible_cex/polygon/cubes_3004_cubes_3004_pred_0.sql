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
INSERT INTO "Discount_Coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (12, 25, 25);
INSERT INTO "Discount_Coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (11, 25, 25);
INSERT INTO "Customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (14, 11, 'Cutlery25', 'Cutlery25', 'Cutlery25', 'Cutlery25', 25, 25);
INSERT INTO "Customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (13, 11, 'Cutlery25', 'Cutlery25', 'Cutlery25', 'Cutlery25', 25, 25);
INSERT INTO "Bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (15, 13, 'Cutlery25', 'Cutlery25', 25, 25, 'Cutlery25', 25, 25, 25, 25);
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (17, 'Cutlery', 20, NULL, 'Cutlery25');
INSERT INTO "Products_for_Hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (16, 'Cutlery', -900, NULL, 'Cutlery25');
INSERT INTO "Payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (19, 13, 15, 'Cutlery25', 'Cutlery25', 25, 25, 25);
INSERT INTO "Payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (18, 13, 15, 'Cutlery25', 'Cutlery25', 25, 25, 25);
INSERT INTO "Products_Booked" ("booking_id", "product_id", "returned_yn", "returned_late_yn", "booked_count", "booked_amount") VALUES (15, 16, 'Cutlery25', 'Cutlery25', 25, 25);
INSERT INTO "View_Product_Availability" ("status_date", "product_id", "booking_id", "available_yn") VALUES (22, 16, 15, 'Cutlery25');
INSERT INTO "View_Product_Availability" ("status_date", "product_id", "booking_id", "available_yn") VALUES (21, 17, 15, 'Cutlery25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product_name", "product_description" FROM "products_for_hire" WHERE ("product_type_code" = 'Cutlery' AND daily_hire_cost <= 20.0) ORDER BY product_name, products_for_hire.product_id NULLS LAST;

/*
Gold Result:
(None, 'Cutlery25')
(None, 'Cutlery25')
*/

-- Prediction Query
SELECT product_name, product_description FROM products_for_hire WHERE product_type_code = 'Cutlery' AND daily_hire_cost < 20;

/*
Prediction Result:
(None, 'Cutlery25')
*/