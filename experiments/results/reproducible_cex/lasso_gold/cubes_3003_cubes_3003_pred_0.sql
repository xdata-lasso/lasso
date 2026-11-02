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
INSERT INTO "discount_coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (1211, '1980-06-12', 1212.5);
INSERT INTO "discount_coupons" ("coupon_id", "date_issued", "coupon_amount") VALUES (1221, '1986-01-18', 1222.5);
INSERT INTO "products_for_hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (1213, 'country', 1214.5, 'Michael Estrada', 'Environment skin blue the teach.');
INSERT INTO "products_for_hire" ("product_id", "product_type_code", "daily_hire_cost", "product_name", "product_description") VALUES (1223, 'way', 1224.5, 'Courtney Keller', 'Sister this image per choice upon.');
INSERT INTO "customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (1215, 1211, 'treatment', 'Francisco', 'Marsh', 'cost', '1981-07-13', '1982-08-14');
INSERT INTO "customers" ("customer_id", "coupon_id", "good_or_bad_customer", "first_name", "last_name", "gender_mf", "date_became_customer", "date_last_hire") VALUES (1225, 1221, 'doctor', 'James', 'Sellers', 'hard', '1987-02-19', '1988-03-20');
INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (1216, 1215, 'upon', 'itself', '1983-09-15', '1984-10-16', 'ago', 1217.5, 1218.5, 1219.5, 1220.5);
INSERT INTO "bookings" ("booking_id", "customer_id", "booking_status_code", "returned_damaged_yn", "booking_start_date", "booking_end_date", "count_hired", "amount_payable", "amount_of_discount", "amount_outstanding", "amount_of_refund") VALUES (1226, 1225, 'focus', 'tend', '1989-04-21', '1990-05-22', 'stuff', 1227.5, 1228.5, 1229.5, 1230.5);
INSERT INTO "view_product_availability" ("status_date", "product_id", "booking_id", "available_yn") VALUES ('1985-11-17', 1213, 1216, '1');
INSERT INTO "view_product_availability" ("status_date", "product_id", "booking_id", "available_yn") VALUES ('1991-06-23', 1223, 1226, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.daily_hire_cost AS daily_hire_cost, LHS.product_name AS product_name, LHS.product_description AS product_description, RHS.booking_id AS booking_id, RHS.status_date AS status_date, RHS.available_yn AS available_yn FROM products_for_hire AS LHS INNER JOIN view_product_availability AS RHS ON (LHS.product_id = RHS.product_id)) WHERE (available_yn = 1) ORDER BY product_name;

/*
Gold Result:
('Courtney Keller',)
('Michael Estrada',)
*/

-- Prediction Query
SELECT T2.product_name FROM view_product_availability AS T1 JOIN products_for_hire AS T2 ON T1.product_id = T2.product_id WHERE T1.available_yn = 1;

/*
Prediction Result:
('Michael Estrada',)
('Courtney Keller',)
*/