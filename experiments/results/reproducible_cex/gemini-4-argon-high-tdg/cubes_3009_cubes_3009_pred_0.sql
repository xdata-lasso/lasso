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
-- DATASET 1
INSERT INTO Discount_Coupons (coupon_id, date_issued, coupon_amount) VALUES (101, '2023-01-01 00:00:00', 10.00);
INSERT INTO Discount_Coupons (coupon_id, date_issued, coupon_amount) VALUES (102, '2023-02-01 00:00:00', 20.00);
INSERT INTO Customers (customer_id, coupon_id, good_or_bad_customer, first_name, last_name, gender_mf, date_became_customer, date_last_hire) VALUES (1, 101, 'good', 'Zoe', 'Miller', 'F', '2022-01-10 00:00:00', NULL);
INSERT INTO Customers (customer_id, coupon_id, good_or_bad_customer, first_name, last_name, gender_mf, date_became_customer, date_last_hire) VALUES (2, 101, 'bad', 'Aaron', 'Baker', 'M', '2022-02-15 00:00:00', '2023-03-01 00:00:00');
INSERT INTO Customers (customer_id, coupon_id, good_or_bad_customer, first_name, last_name, gender_mf, date_became_customer, date_last_hire) VALUES (3, NULL, 'good', 'Alice', 'Zimmerman', 'M', '2022-03-20 00:00:00', '2023-04-01 00:00:00');
INSERT INTO Customers (customer_id, coupon_id, good_or_bad_customer, first_name, last_name, gender_mf, date_became_customer, date_last_hire) VALUES (4, 102, NULL, 'Bob', 'Carter', 'M', '2022-04-25 00:00:00', '2023-05-01 00:00:00');
INSERT INTO Customers (customer_id, coupon_id, good_or_bad_customer, first_name, last_name, gender_mf, date_became_customer, date_last_hire) VALUES (5, 102, 'good', 'Alice', 'Adams', 'F', '2022-05-30 00:00:00', '2023-06-01 00:00:00');
INSERT INTO Bookings (booking_id, customer_id, booking_status_code, returned_damaged_yn, booking_start_date, booking_end_date, count_hired, amount_payable, amount_of_discount, amount_outstanding, amount_of_refund) VALUES (201, 2, 'CLOSED', 'N', '2023-03-01 00:00:00', '2023-03-05 00:00:00', '1', 100.00, 10.00, 0.00, 0.00);
INSERT INTO Bookings (booking_id, customer_id, booking_status_code, returned_damaged_yn, booking_start_date, booking_end_date, count_hired, amount_payable, amount_of_discount, amount_outstanding, amount_of_refund) VALUES (202, 5, 'CLOSED', 'N', '2023-05-01 00:00:00', '2023-05-03 00:00:00', '2', 150.00, 20.00, 0.00, 0.00);
INSERT INTO Bookings (booking_id, customer_id, booking_status_code, returned_damaged_yn, booking_start_date, booking_end_date, count_hired, amount_payable, amount_of_discount, amount_outstanding, amount_of_refund) VALUES (203, 5, 'OPEN', 'N', '2023-06-01 00:00:00', '2023-06-04 00:00:00', '1', 80.00, 0.00, 80.00, 0.00);
INSERT INTO Payments (payment_id, customer_id, booking_id, payment_type_code, amount_paid_in_full_yn, payment_date, amount_due, amount_paid) VALUES (301, 2, 201, 'CARD', 'Y', '2023-03-05 00:00:00', 90.00, 90.00);
INSERT INTO Payments (payment_id, customer_id, booking_id, payment_type_code, amount_paid_in_full_yn, payment_date, amount_due, amount_paid) VALUES (302, 5, 202, 'CASH', 'Y', '2023-05-03 00:00:00', 130.00, 130.00);
INSERT INTO Payments (payment_id, customer_id, booking_id, payment_type_code, amount_paid_in_full_yn, payment_date, amount_due, amount_paid) VALUES (303, 5, 203, 'CARD', 'N', '2023-06-01 00:00:00', 80.00, 40.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "last_name", "gender_mf" FROM "customers" WHERE ("good_or_bad_customer" = 'good') ORDER BY first_name, customers.customer_id NULLS LAST;

/*
Gold Result:
('Alice', 'Zimmerman', 'M')
('Alice', 'Adams', 'F')
('Zoe', 'Miller', 'F')
*/

-- Prediction Query
SELECT first_name, last_name, gender_mf FROM customers WHERE good_or_bad_customer = 'good' ORDER BY last_name, customers.customer_id NULLS LAST;

/*
Prediction Result:
('Alice', 'Adams', 'F')
('Zoe', 'Miller', 'F')
('Alice', 'Zimmerman', 'M')
*/