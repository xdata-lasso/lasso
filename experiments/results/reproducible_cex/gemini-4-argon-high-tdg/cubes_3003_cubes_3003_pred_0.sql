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
INSERT INTO Discount_Coupons (coupon_id, date_issued, coupon_amount) VALUES (1, '2023-01-01 00:00:00', 10.00);
INSERT INTO Customers (customer_id, coupon_id, good_or_bad_customer, first_name, last_name, gender_mf, date_became_customer, date_last_hire) VALUES (1, 1, 'good', 'Alice', 'Smith', 'F', '2022-05-01 00:00:00', '2023-06-01 00:00:00');
INSERT INTO Bookings (booking_id, customer_id, booking_status_code, returned_damaged_yn, booking_start_date, booking_end_date, count_hired, amount_payable, amount_of_discount, amount_outstanding, amount_of_refund) VALUES (10, 1, 'CONF', 'N', '2023-06-01 00:00:00', '2023-06-05 00:00:00', '1', 100.00, 10.00, 0.00, 0.00);
INSERT INTO Bookings (booking_id, customer_id, booking_status_code, returned_damaged_yn, booking_start_date, booking_end_date, count_hired, amount_payable, amount_of_discount, amount_outstanding, amount_of_refund) VALUES (20, 1, 'CONF', 'N', '2023-06-06 00:00:00', '2023-06-10 00:00:00', '2', 200.00, 0.00, 50.00, 0.00);
INSERT INTO Products_for_Hire (product_id, product_type_code, daily_hire_cost, product_name, product_description) VALUES (1, 'TENT', 15.00, 'Zebra Canopy', 'Large striped tent');
INSERT INTO Products_for_Hire (product_id, product_type_code, daily_hire_cost, product_name, product_description) VALUES (2, 'CAM', 80.00, 'Alpha Camera', 'Digital cinema camera');
INSERT INTO Products_for_Hire (product_id, product_type_code, daily_hire_cost, product_name, product_description) VALUES (3, 'AUD', 45.00, 'Beta Mixer', 'Audio mixing console');
INSERT INTO Products_for_Hire (product_id, product_type_code, daily_hire_cost, product_name, product_description) VALUES (4, 'LGT', 25.00, 'Delta Strobe', 'High power strobe light');
INSERT INTO Products_for_Hire (product_id, product_type_code, daily_hire_cost, product_name, product_description) VALUES (5, 'GEN', 60.00, 'Epsilon Generator', 'Portable diesel generator');
INSERT INTO Products_for_Hire (product_id, product_type_code, daily_hire_cost, product_name, product_description) VALUES (6, 'CBL', 5.00, 'Gamma Cable', 'XLR cable 10m');
INSERT INTO View_Product_Availability (status_date, product_id, booking_id, available_yn) VALUES ('2023-07-01 00:00:00', 1, 20, '1');
INSERT INTO View_Product_Availability (status_date, product_id, booking_id, available_yn) VALUES ('2023-07-03 00:00:00', 2, 10, '1');
INSERT INTO View_Product_Availability (status_date, product_id, booking_id, available_yn) VALUES ('2023-07-02 00:00:00', 3, 10, '1');
INSERT INTO View_Product_Availability (status_date, product_id, booking_id, available_yn) VALUES ('2023-07-04 00:00:00', 4, 20, '0');
INSERT INTO View_Product_Availability (status_date, product_id, booking_id, available_yn) VALUES ('2023-07-05 00:00:00', 5, 10, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.daily_hire_cost AS daily_hire_cost, LHS.product_name AS product_name, LHS.product_description AS product_description, RHS.booking_id AS booking_id, RHS.status_date AS status_date, RHS.available_yn AS available_yn FROM products_for_hire AS LHS INNER JOIN view_product_availability AS RHS ON (LHS.product_id = RHS.product_id)) WHERE (available_yn = 1) ORDER BY product_name;

/*
Gold Result:
('Alpha Camera',)
('Beta Mixer',)
('Zebra Canopy',)
*/

-- Prediction Query
SELECT T2.product_name FROM view_product_availability AS T1 JOIN products_for_hire AS T2 ON T1.product_id = T2.product_id WHERE T1.available_yn = 1;

/*
Prediction Result:
('Zebra Canopy',)
('Alpha Camera',)
('Beta Mixer',)
*/