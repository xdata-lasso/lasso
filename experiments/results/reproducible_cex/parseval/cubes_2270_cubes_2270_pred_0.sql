-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (-2147483648, '7', 'sta_e6aab2', 'sta_26e2dc', 'sta_a5d85a', 'sta_d048f5');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (-2147483648, 'cus_fbfcb6', 'cus_2eb566', 'cus_554be6', 'cus_c3359a', 'cus_ae3ea2', 'cus_275a9f', 'cus_d5f626');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (-2147483648, -55602865, 'pro_c1719f', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'pro_bf129f', 'pro_0bcc33', 0.0001);

-- Inserting into table: complaints --
INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -664303813, 'com_22e47b', 'com_9480c6', 'Product Failure', '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, 1610062532, 'com_22e47b', 'com_9480c6', 'Product Failure', '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -1865039888, 'com_22e47b', 'com_9480c6', 'Product Failure', '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, 1268590800, 'com_22e47b', 'com_9480c6', 'Product Failure', '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -1349201381, 'com_22e47b', 'com_9480c6', 'Product Failure', '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -841692980, 'com_22e47b', 'com_9480c6', 'Product Failure', '2021-07-20 10:41:36+00:00', '2020-03-11 00:23:16+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, 2087640001, 'com_22e47b', 'com_9480c6', 'com_13cf4e', '2025-09-01 05:13:03+00:00', '2025-03-03 08:26:45+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -918961358, 'com_22e47b', 'com_9480c6', 'com_f001db', '2021-01-29 03:06:29+00:00', '2020-08-22 06:30:10+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, 44952191, 'com_22e47b', 'com_9480c6', 'com_ab6e34', '2021-06-25 00:51:07+00:00', '2020-09-15 12:11:12+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, 947159877, 'com_22e47b', 'com_9480c6', 'Product Failure', '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, 1274489983, 'com_22e47b', 'com_9480c6', 'Product Failure', '2021-02-04 01:21:18+00:00', '2025-03-10 20:24:26+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -1585009206, 'com_22e47b', 'com_9480c6', 'Product Failure', '2021-08-19 01:10:02+00:00', '2024-10-24 14:16:53+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -747753377, 'com_22e47b', NULL, 'Product Failure', '2024-01-27 22:01:59+00:00', '2021-09-24 11:50:48+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -1031969798, 'com_22e47b', NULL, 'Product Failure', '2022-01-22 16:14:13+00:00', '2024-02-28 04:46:49+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, 2107872094, 'com_22e47b', NULL, 'Product Failure', '2023-07-13 23:57:06+00:00', '2025-09-22 03:26:15+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -751275471, 'com_22e47b', 'com_ab7d50', 'Product Failure', '2021-08-01 11:21:15+00:00', '2021-03-04 19:22:02+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -314162272, 'com_22e47b', 'com_ab7d50', 'Product Failure', '2023-03-22 03:47:49+00:00', '2024-10-18 05:00:47+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, 624571013, 'com_22e47b', 'com_1eb969', NULL, '2023-11-18 08:10:54+00:00', '2021-12-11 04:26:48+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, -1438850342, 'com_22e47b', 'com_d531f3', 'com_81b554', '2020-08-18 16:30:34+00:00', '2023-03-10 01:47:11+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, -2147483648, -2147483648, 105869088, 'com_22e47b', 'com_1eb969', 'Product Failure', '2023-01-02 05:47:29+00:00', '2025-03-16 12:14:02+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "complaint_status_code", "n_distinct" AS "count___" FROM (SELECT "complaint_status_code", "complaint_type_code", COUNT(DISTINCT "complaint_type_code") AS "n_distinct" FROM "complaints" GROUP BY "complaint_status_code", "complaint_type_code") WHERE ("complaint_type_code" = 'Product Failure') ORDER BY complaint_status_code, "complaint_status_code" NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('com_1eb969', 1)
('com_9480c6', 1)
('com_ab7d50', 1)
*/

-- Prediction Query
SELECT complaint_status_code, COUNT(*) FROM complaints WHERE complaint_type_code = 'Product Failure' GROUP BY complaint_status_code;

/*
Prediction Result:
(None, 3)
('com_1eb969', 1)
('com_9480c6', 9)
('com_ab7d50', 2)
*/