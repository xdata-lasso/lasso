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
INSERT INTO Discount_Coupons (coupon_id, date_issued, coupon_amount) VALUES (1, '2023-01-01', 500.0);
INSERT INTO Customers (customer_id, coupon_id, good_or_bad_customer, first_name, last_name, gender_mf, date_became_customer, date_last_hire) VALUES (1, 1, 'good', 'John', 'Doe', 'M', '2023-01-01', '2023-01-02');
INSERT INTO Customers (customer_id, coupon_id, good_or_bad_customer, first_name, last_name, gender_mf, date_became_customer, date_last_hire) VALUES (2, 1, 'bad', 'Jane', 'Doe', 'F', '2023-01-01', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT good_or_bad_customer FROM (SELECT LHS.customer_id AS customer_id, LHS.coupon_id AS coupon_id, LHS.good_or_bad_customer AS good_or_bad_customer, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.gender_mf AS gender_mf, LHS.date_became_customer AS date_became_customer, LHS.date_last_hire AS date_last_hire, RHS.date_issued AS date_issued, RHS.coupon_amount AS coupon_amount FROM customers AS LHS INNER JOIN (SELECT * FROM discount_coupons WHERE (coupon_amount = 500.0)) AS RHS ON (LHS.coupon_id = RHS.coupon_id)) ORDER BY good_or_bad_customer;

/*
Gold Result:
('bad',)
('good',)
*/

-- Prediction Query
SELECT T1.good_or_bad_customer FROM customers AS T1 JOIN discount_coupons AS T2 ON T1.coupon_id = T2.coupon_id WHERE T2.coupon_amount = 500;

/*
Prediction Result:
('good',)
('bad',)
*/