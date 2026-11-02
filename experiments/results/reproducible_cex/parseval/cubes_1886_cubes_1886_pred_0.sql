-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(20), "product_price" REAL(19, 4), "product_description" TEXT(255));

CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_details" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(10), "customer_name" TEXT(80), "customer_phone" TEXT(80), "customer_email" TEXT(80), "date_became_customer" DATETIME);

CREATE TABLE "Regular_Orders" ("regular_order_id" INTEGER PRIMARY KEY, "distributer_id" INTEGER, FOREIGN KEY ("distributer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Regular_Order_Products" ("regular_order_id" INTEGER, "product_id" INTEGER, FOREIGN KEY ("regular_order_id") REFERENCES "Regular_Orders" ("regular_order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Actual_Orders" ("actual_order_id" INTEGER PRIMARY KEY, "regular_order_id" INTEGER, "order_status_code" TEXT(10), "actual_order_date" DATETIME, FOREIGN KEY ("regular_order_id") REFERENCES "Regular_Orders" ("regular_order_id"));

CREATE TABLE "Actual_Order_Products" ("actual_order_id" INTEGER, "product_id" INTEGER, FOREIGN KEY ("actual_order_id") REFERENCES "Actual_Orders" ("actual_order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Customer_Addresses" ("address_id" INTEGER, "customer_id" INTEGER, "date_from" DATETIME, "address_type" TEXT(10), "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Delivery_Routes" ("route_id" INTEGER PRIMARY KEY, "route_name" TEXT(50), "other_route_details" TEXT(255));

CREATE TABLE "Delivery_Route_Locations" ("location_code" TEXT(10) PRIMARY KEY, "route_id" INTEGER, "location_address_id" INTEGER, "location_name" TEXT(50), FOREIGN KEY ("route_id") REFERENCES "Delivery_Routes" ("route_id"), FOREIGN KEY ("location_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Trucks" ("truck_id" INTEGER PRIMARY KEY, "truck_licence_number" TEXT(20), "truck_details" TEXT(255));

CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "employee_address_id" INTEGER, "employee_name" TEXT(80), "employee_phone" TEXT(80), FOREIGN KEY ("employee_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Order_Deliveries" ("driver_employee_id" INTEGER, "location_code" TEXT(10), "actual_order_id" INTEGER, "truck_id" INTEGER, "delivery_status_code" TEXT(10), "delivery_date" DATETIME, FOREIGN KEY ("driver_employee_id") REFERENCES "Employees" ("employee_id"), FOREIGN KEY ("location_code") REFERENCES "Delivery_Route_Locations" ("location_code"), FOREIGN KEY ("actual_order_id") REFERENCES "Actual_Orders" ("actual_order_id"), FOREIGN KEY ("truck_id") REFERENCES "Trucks" ("truck_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (1, 'cus_16ca91', 'cus_88d23f', 'cus_d0de5e', 'cus_89d5c1', '2024-06-15 00:00:00+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (-2147483647, 'cus_6cdb9e', 'cus_c3aefb', 'cus_370aa2', 'cus_ef3ee8', '2024-06-15 00:00:00+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (2, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2024-12-15 00:56:33+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (3, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2025-11-23 07:28:46+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (4, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2025-10-14 06:39:08+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (5, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2025-06-10 18:20:47+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (6, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2024-02-22 05:22:28+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (7, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2021-05-28 17:00:04+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (8, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2024-02-19 01:18:26+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (9, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2022-06-06 02:35:43+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (10, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2022-12-08 21:38:59+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (11, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2023-01-16 20:10:41+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (12, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2022-03-24 16:30:12+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (13, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2020-04-30 03:21:27+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (14, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2020-10-31 07:51:16+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (15, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2022-06-28 11:34:24+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (16, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2021-06-17 14:22:38+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (17, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2024-11-14 12:35:58+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (18, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2024-09-28 03:06:45+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (19, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2021-10-04 22:30:57+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (20, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2025-02-21 23:30:13+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (21, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2024-07-26 19:47:18+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method FROM (SELECT customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer, customer_id AS n, payment_method_other, customer_name_other, customer_phone_other, customer_email_other, date_became_customer_other FROM (SELECT LHS.customer_id AS customer_id, LHS.payment_method AS payment_method, LHS.customer_name AS customer_name, LHS.customer_phone AS customer_phone, LHS.customer_email AS customer_email, LHS.date_became_customer AS date_became_customer, LHS.n AS n, RHS.payment_method AS payment_method_other, RHS.customer_name AS customer_name_other, RHS.customer_phone AS customer_phone_other, RHS.customer_email AS customer_email_other, RHS.date_became_customer AS date_became_customer_other FROM (SELECT customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer, COUNT(*) OVER () AS n FROM customers) AS LHS INNER JOIN (SELECT customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer, COUNT(*) OVER () AS n FROM customers) AS RHS ON (LHS.customer_id = RHS.n AND LHS.n = RHS.customer_id))) ORDER BY payment_method;

/*
Gold Result:
*/

-- Prediction Query
SELECT payment_method FROM Customers GROUP BY payment_method ORDER BY COUNT(*) DESC, payment_method NULLS LAST LIMIT 1;

/*
Prediction Result:
('cus_9c1fa8',)
*/