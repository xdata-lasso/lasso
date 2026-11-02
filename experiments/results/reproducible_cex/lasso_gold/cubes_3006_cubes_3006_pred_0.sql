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
INSERT INTO "discount_coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (1170, '1985-04-11', 1171.5);
INSERT INTO "discount_coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (1190, '1997-05-23', 1191.5);
INSERT INTO "customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (1172, 1170, 'anyone', 'Michelle', 'Hernandez', 'collection', '1986-05-12', '1987-06-13');
INSERT INTO "customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (1192, 1190, 'activity', 'Erin', 'Wilson', 'value', '1998-06-01', '1970-07-02');
INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (1173, 1172, 'structure', 'response', '1988-07-14', '1989-08-15', 'knowledge', 1174.5, 1175.5, 1176.5, 1177.5);
INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (1193, 1192, 'not', 'social', '1971-08-03', '1972-09-04', 'example', 1194.5, 1195.5, 1196.5, 1197.5);
INSERT INTO "payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (1178, 1172, 1173, 'Check', 'pick', '1990-09-16', 1179.5, 301.0);
INSERT INTO "payments" ("payment_id", "customer_id", "booking_id", "payment_type_code", "amount_paid_in_full_yn", "payment_date", "amount_due", "amount_paid") VALUES (1198, 1192, 1193, 'Check', 'specific', '1973-10-05', 1199.5, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "payment_date" FROM "payments" WHERE ("payment_type_code" = 'Check' OR amount_paid > 300.0) ORDER BY payment_date, payments.payment_id NULLS LAST;

/*
Gold Result:
('1973-10-05',)
('1990-09-16',)
*/

-- Prediction Query
SELECT payment_date FROM payments WHERE amount_paid > 300 OR payment_type_code = 'Check';

/*
Prediction Result:
('1990-09-16',)
('1973-10-05',)
*/