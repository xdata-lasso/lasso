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
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1, 1, 'lhs_230e4f', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_8bbf49', 'lhs_6ddabf', 1.0);

INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (-2147483647, 1, 'lhs_db758b', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_15150e', 'lhs_027aba', 1.0);

-- Inserting into table: complaints --
INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -55602865, 'com_20278c', 'com_1eb969', 'com_81b554', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1022641847, 'com_20278c', 'com_1eb969', 'com_81b554', '2020-10-31 07:51:16+00:00', '2022-06-28 11:34:24+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1980249628, 'com_20278c', 'com_1eb969', 'com_81b554', '2022-02-14 19:27:39+00:00', '2020-11-05 04:59:51+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1865039888, 'com_20278c', 'com_1eb969', 'com_81b554', '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1914020640, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1644814318, 'com_20278c', 'com_1eb969', 'com_81b554', '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1908028688, 'com_20278c', 'com_1eb969', 'com_81b554', '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1019800248, 'com_20278c', 'com_1eb969', 'com_81b554', '2022-11-06 10:19:41+00:00', '2020-06-20 11:35:06+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -841692980, 'com_20278c', 'com_1eb969', 'com_81b554', '2021-07-20 10:41:36+00:00', '2020-03-11 00:23:16+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1236688122, 'com_20278c', 'com_1eb969', 'com_81b554', '2021-08-20 16:50:24+00:00', '2025-09-01 05:13:03+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 2026480202, 'com_20278c', 'com_1eb969', 'com_81b554', '2021-02-17 05:47:13+00:00', '2021-01-29 03:06:29+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1209887326, 'com_20278c', 'com_1eb969', 'com_81b554', '2024-05-04 23:07:19+00:00', '2021-05-18 10:50:30+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1038707349, 'com_20278c', 'com_1eb969', 'com_81b554', '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 947159877, 'com_20278c', 'com_1eb969', 'com_81b554', '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 374105386, 'com_20278c', 'com_1eb969', 'com_81b554', '2020-05-12 00:10:04+00:00', '2021-02-04 01:21:18+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 528680845, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-12-22 03:17:01+00:00', '2024-05-26 02:52:16+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -761141909, 'com_20278c', 'com_1eb969', 'com_81b554', '2024-10-24 14:16:53+00:00', '2024-02-23 22:32:48+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -747753377, 'com_20278c', 'com_1eb969', 'com_81b554', '2024-01-27 22:01:59+00:00', '2021-09-24 11:50:48+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 418417917, 'com_20278c', 'com_1eb969', 'com_81b554', '2021-11-17 08:00:56+00:00', '2025-10-15 06:50:58+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -472966518, 'com_20278c', 'com_1eb969', 'com_81b554', '2024-02-28 04:46:49+00:00', '2022-06-06 01:51:46+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 2107872094, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-07-13 23:57:06+00:00', '2025-09-22 03:26:15+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -751275471, 'com_20278c', 'com_1eb969', 'com_81b554', '2021-08-01 11:21:15+00:00', '2021-03-04 19:22:02+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -314162272, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-03-22 03:47:49+00:00', '2024-10-18 05:00:47+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1898504886, 'com_20278c', 'com_1eb969', 'com_81b554', '2025-06-28 05:56:56+00:00', '2021-12-20 12:18:45+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 226938182, 'com_20278c', 'com_1eb969', 'com_81b554', '2021-08-05 01:19:54+00:00', '2025-11-19 11:50:18+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1390245819, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-03-10 01:47:11+00:00', '2023-08-25 07:55:29+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 105869088, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-01-02 05:47:29+00:00', '2025-03-16 12:14:02+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1909986641, NULL, 'com_1eb969', 'com_81b554', '2023-01-13 04:58:30+00:00', '2024-12-22 09:14:04+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1021749117, NULL, 'com_1eb969', 'com_81b554', '2025-01-11 14:32:08+00:00', '2023-11-27 00:51:18+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 244829661, NULL, 'com_1eb969', 'com_81b554', '2021-07-21 20:51:39+00:00', '2021-03-27 18:00:10+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -346339240, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-12-31 18:03:51+00:00', '2023-04-11 01:23:11+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1255852738, 'com_20278c', 'com_1eb969', 'com_81b554', '2021-03-04 06:15:13+00:00', '2023-10-21 02:54:45+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -705985602, 'com_20278c', 'com_1eb969', 'com_81b554', '2025-02-21 13:28:29+00:00', '2025-05-10 04:07:07+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1836127587, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-06-28 05:47:44+00:00', '2025-11-28 13:30:18+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1937207087, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-09-10 09:37:01+00:00', '2022-11-21 09:24:31+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1442655647, 'com_20278c', 'com_1eb969', 'com_81b554', '2024-01-30 01:02:36+00:00', '2021-01-22 00:53:52+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1929953647, 'com_20278c', 'com_1eb969', 'com_81b554', '2021-07-30 02:29:08+00:00', '2022-01-26 11:13:48+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1298861365, 'com_20278c', 'com_1eb969', 'com_81b554', '2020-07-01 12:41:54+00:00', '2022-03-02 18:03:57+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1070063173, 'com_20278c', 'com_1eb969', 'com_81b554', '2025-05-09 05:17:21+00:00', '2023-02-13 21:14:29+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1245312912, 'com_20278c', 'com_1eb969', 'com_81b554', '2022-01-23 03:13:33+00:00', '2022-04-18 00:53:20+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -792947627, 'com_20278c', 'com_1eb969', 'com_81b554', '2020-06-29 02:04:50+00:00', '2023-05-14 17:39:51+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1742081330, 'com_20278c', 'com_1eb969', 'com_81b554', '2024-08-10 07:57:32+00:00', '2021-10-07 12:15:00+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, -1056308489, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-06-17 22:27:46+00:00', '2024-11-28 11:20:05+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1631231566, 'com_20278c', 'com_1eb969', 'com_81b554', '2024-09-26 23:38:30+00:00', '2024-08-05 04:49:57+00:00');

INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (-2147483648, 1, -2147483648, 1443629118, 'com_20278c', 'com_1eb969', 'com_81b554', '2023-12-12 02:47:46+00:00', '2023-05-15 04:44:08+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, n AS count___ FROM (SELECT LHS.product_id AS product_id, LHS.parent_product_id AS parent_product_id, LHS.product_category_code AS product_category_code, LHS.date_product_first_available AS date_product_first_available, LHS.date_product_discontinued AS date_product_discontinued, LHS.product_name AS product_name, LHS.product_description AS product_description, LHS.product_price AS product_price, RHS.complaint_outcome_code AS complaint_outcome_code, RHS.n AS n FROM products AS LHS INNER JOIN (SELECT complaint_outcome_code, product_id, COUNT(*) AS n FROM complaints GROUP BY complaint_outcome_code, product_id) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY product_name, count___ NULLS LAST;

/*
Gold Result:
('lhs_8bbf49', 3)
('lhs_8bbf49', 42)
*/

-- Prediction Query
SELECT t1.product_name, COUNT(*) FROM products AS t1 JOIN complaints AS t2 ON t1.product_id = t2.product_id GROUP BY t1.product_name;

/*
Prediction Result:
('lhs_8bbf49', 45)
*/