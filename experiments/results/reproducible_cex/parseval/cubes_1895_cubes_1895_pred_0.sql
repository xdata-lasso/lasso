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
-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "address_details", "city", "zip_postcode", "state_province_county", "country") VALUES (1, 'lhs_ba43b2', 'lhs_8733a4', 'lhs_fad5d9', 'lhs_a0832b', 'lhs_d759da');

INSERT INTO "addresses" ("address_id", "address_details", "city", "zip_postcode", "state_province_county", "country") VALUES (3, 'lhs_ba43b2', 'lhs_8733a4', 'lhs_fad5d9', 'lhs_a0832b', 'lhs_d759da');

INSERT INTO "addresses" ("address_id", "address_details", "city", "zip_postcode", "state_province_county", "country") VALUES (2, 'add_5c8c92', 'add_ae09f0', 'add_92aefd', 'add_7d1289', 'add_0b134e');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (-2147483648, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2024-12-15 00:56:33+00:00');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (1, 'cus_9c1fa8', 'cus_8d1b6b', 'cus_a818b6', 'cus_14971e', '2022-03-24 16:30:12+00:00');

-- Inserting into table: customer_addresses --
INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2025-11-23 07:28:46+00:00', 'cus_67d0c8', '2025-10-14 06:39:08+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2021-05-28 17:00:04+00:00', 'cus_67d0c8', '2024-02-19 01:18:26+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2022-12-08 21:38:59+00:00', 'cus_67d0c8', '2023-01-16 20:10:41+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, -2147483648, '2020-10-31 07:51:16+00:00', 'cus_67d0c8', '2022-06-28 11:34:24+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, -2147483648, '2024-11-14 12:35:58+00:00', 'cus_67d0c8', '2024-09-28 03:06:45+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, -2147483648, '2025-02-21 23:30:13+00:00', 'cus_67d0c8', '2024-07-26 19:47:18+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (2, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, -2147483648, '2024-01-16 07:29:50+00:00', 'cus_67d0c8', '2022-02-14 19:27:39+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, -2147483648, '2025-11-08 19:01:33+00:00', 'cus_67d0c8', '2022-09-05 02:10:50+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, 1, '2020-09-25 19:25:33+00:00', 'cus_67d0c8', '2020-07-23 07:32:15+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (2, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, 1, '2025-06-13 15:31:02+00:00', 'cus_67d0c8', '2021-01-07 01:22:28+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, 1, '2021-02-21 20:09:01+00:00', 'cus_67d0c8', '2020-01-15 18:18:33+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, 1, '2023-03-21 21:13:18+00:00', 'cus_67d0c8', '2022-01-21 14:23:36+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (2, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, 1, '2023-05-25 17:04:36+00:00', 'cus_67d0c8', '2020-12-10 17:36:20+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, 1, '2025-08-22 00:34:24+00:00', 'cus_67d0c8', '2022-04-13 09:01:25+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (3, 1, '2020-04-05 14:43:51+00:00', 'cus_67d0c8', '2020-03-08 22:40:47+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (2, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2024-04-12 00:38:47+00:00', 'cus_67d0c8', '2021-07-31 11:04:01+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2020-12-19 01:52:21+00:00', 'cus_67d0c8', '2022-11-06 10:19:41+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2021-07-11 07:27:32+00:00', 'cus_67d0c8', '2022-07-30 13:34:14+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_118f62', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2021-01-23 18:11:33+00:00', 'cus_67d0c8', '2021-07-20 10:41:36+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2025-02-07 06:53:31+00:00', 'cus_67d0c8', '2021-10-06 00:40:57+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2022-04-12 01:47:28+00:00', 'cus_67d0c8', '2021-08-20 16:50:24+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_118f62', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2021-12-31 07:20:26+00:00', 'cus_67d0c8', '2021-12-08 15:32:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2021-02-17 05:47:13+00:00', 'cus_67d0c8', '2021-01-29 03:06:29+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2024-02-29 12:08:41+00:00', 'cus_67d0c8', '2022-10-15 07:04:26+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_118f62', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2022-12-10 02:38:39+00:00', 'cus_67d0c8', '2024-05-04 23:07:19+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2021-06-25 00:51:07+00:00', 'cus_67d0c8', '2020-09-15 12:11:12+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2024-12-31 04:19:17+00:00', 'cus_67d0c8', '2024-10-02 15:57:32+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_118f62', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2025-05-02 19:47:39+00:00', NULL, '2023-07-26 05:50:21+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2022-07-16 22:41:51+00:00', NULL, '2024-03-03 15:52:53+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2025-08-21 21:00:40+00:00', NULL, '2024-01-02 11:27:20+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2020-05-12 00:10:04+00:00', 'cus_67d0c8', '2021-02-04 01:21:18+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2020-05-18 19:45:10+00:00', 'cus_67d0c8', '2025-04-19 21:11:20+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2023-12-22 03:17:01+00:00', 'cus_67d0c8', '2024-05-26 02:52:16+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2021-02-10 21:10:52+00:00', 'cus_67d0c8', '2022-09-29 20:25:58+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2024-10-24 14:16:53+00:00', 'cus_67d0c8', '2024-02-23 22:32:48+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2025-09-21 09:36:38+00:00', 'cus_67d0c8', '2023-05-17 17:49:21+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2025-10-02 08:51:14+00:00', 'cus_67d0c8', NULL);

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2021-11-30 23:39:10+00:00', 'cus_67d0c8', NULL);

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2021-09-24 11:50:48+00:00', 'cus_67d0c8', NULL);

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', NULL);

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, NULL, 'cus_67d0c8', '2025-10-19 18:29:54+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, NULL, 'cus_67d0c8', '2025-01-30 02:54:07+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, NULL, 'cus_67d0c8', '2021-11-17 08:00:56+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2024-12-28 10:57:01+00:00', 'cus_67d0c8', '2022-03-17 22:33:35+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2022-01-22 16:14:13+00:00', 'cus_67d0c8', '2024-02-28 04:46:49+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-04-01 02:40:29+00:00', 'cus_67d0c8', '2020-02-25 10:33:58+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2022-01-05 17:19:47+00:00', 'cus_67d0c8', '2023-07-13 23:57:06+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-11-25 22:27:17+00:00', 'cus_67d0c8', '2020-08-22 17:31:36+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2022-07-13 23:48:43+00:00', 'cus_67d0c8', '2021-08-01 11:21:15+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2022-02-19 15:51:21+00:00', 'cus_67d0c8', '2020-01-22 05:30:29+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2023-08-19 04:29:46+00:00', 'cus_67d0c8', '2022-05-03 02:13:10+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-10-18 05:00:47+00:00', 'cus_67d0c8', '2023-03-18 23:06:49+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2025-09-09 06:56:52+00:00', 'cus_67d0c8', '2021-11-25 10:04:53+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2023-11-18 08:10:54+00:00', 'cus_67d0c8', '2021-12-11 04:26:48+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2021-08-05 01:19:54+00:00', 'cus_67d0c8', '2025-11-19 11:50:18+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2021-05-27 14:39:41+00:00', 'cus_67d0c8', '2021-07-01 18:29:24+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2023-03-10 01:47:11+00:00', 'cus_67d0c8', '2023-08-25 07:55:29+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2021-03-25 19:22:18+00:00', 'cus_67d0c8', '2021-02-17 21:51:43+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2023-01-02 05:47:29+00:00', 'cus_67d0c8', '2025-03-16 12:14:02+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2022-08-31 15:38:50+00:00', 'cus_67d0c8', '2023-10-12 22:40:24+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2023-01-13 04:58:30+00:00', 'cus_67d0c8', '2024-12-22 09:14:04+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2022-05-13 17:57:39+00:00', 'cus_67d0c8', '2022-03-25 08:00:08+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2025-01-11 14:32:08+00:00', 'cus_67d0c8', '2023-11-27 00:51:18+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2023-03-13 16:07:34+00:00', 'cus_67d0c8', '2022-10-12 16:19:32+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, -2147483648, '2024-09-04 21:17:21+00:00', 'cus_67d0c8', '2024-09-26 13:13:01+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2021-07-21 20:51:39+00:00', 'cus_67d0c8', '2021-03-27 18:00:10+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2021-07-14 21:04:24+00:00', 'cus_67d0c8', '2023-07-26 21:52:05+00:00');

INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'rhs_b443c2', '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT state_province_county, n AS count___ FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.customer_id AS customer_id, LHS.date_from AS date_from, LHS.address_type AS address_type, LHS.date_to AS date_to, RHS.n AS n FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, RHS.customer_id AS customer_id, RHS.date_from AS date_from, RHS.address_type AS address_type, RHS.date_to AS date_to FROM addresses AS LHS INNER JOIN customer_addresses AS RHS ON (LHS.address_id = RHS.address_id)) AS LHS INNER JOIN (SELECT address_id, COUNT(*) AS n FROM customer_addresses GROUP BY address_id) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY state_province_county, count___ NULLS LAST;

/*
Gold Result:
('add_7d1289', 4)
('lhs_a0832b', 12)
('lhs_a0832b', 76)
*/

-- Prediction Query
SELECT t2.state_province_county, COUNT(*) FROM customer_addresses AS t1 JOIN addresses AS t2 ON t1.address_id = t2.address_id GROUP BY t2.state_province_county;

/*
Prediction Result:
('add_7d1289', 4)
('lhs_a0832b', 88)
*/