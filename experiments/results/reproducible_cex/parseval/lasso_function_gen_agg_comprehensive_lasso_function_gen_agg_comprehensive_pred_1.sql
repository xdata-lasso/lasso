-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, product_name TEXT, category TEXT, amount REAL, sale_date DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sales --
INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483648, '5k5swwqcgs', 'sal_2a88ca', 1.0, '2021-12-04');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483647, '9n8c4pgu7v', 'sal_2a88ca', 1.0, '2020-12-20');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483646, '4h', 'sal_2a88ca', 1.0, '2023-01-06');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (2, 'a2y', 'sal_2a88ca', 1.0, '2022-09-17');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (3, 'uzhsrwbbp6lu', 'sal_2a88ca', 1.0, '2021-04-10');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483645, 'dlttil', 'sal_2a88ca', 1.0, '2020-04-02');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483642, 'nprmdposii', 'sal_2a88ca', NULL, '2020-11-04');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483641, 'unw6klfa', 'sal_2a88ca', NULL, '2024-07-24');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483640, '00t5c4ecigc', 'sal_2a88ca', NULL, '2020-10-26');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483639, '76nium52', 'sal_2a88ca', NULL, '2024-06-13');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483638, 'u', 'sal_2a88ca', NULL, '2022-07-11');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483637, 'nrqrofqy', 'sal_2a88ca', NULL, '2022-09-19');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483636, 's5bbp02e', 'sal_2a88ca', NULL, '2023-08-24');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483635, 'liqa1', 'sal_2a88ca', NULL, '2024-10-14');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483634, 'yytoo', 'sal_2a88ca', NULL, '2025-02-11');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483633, '9hl7', 'sal_2a88ca', NULL, '2024-12-21');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483632, 'lex', 'sal_2a88ca', NULL, '2024-10-22');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483631, 'ji7zwau2', 'sal_2a88ca', NULL, '2020-08-25');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483630, 'yrq13p', 'sal_2a88ca', NULL, '2024-03-19');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483629, '78d99r', 'sal_2a88ca', NULL, '2022-01-18');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483628, 'sl0', 'sal_2a88ca', NULL, '2020-04-20');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483627, 'yp5qi2rk', 'sal_2a88ca', NULL, '2021-01-15');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483626, 'vqx58pz0f', 'sal_2a88ca', NULL, '2021-08-12');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483625, 'gd', 'sal_2a88ca', NULL, '2025-01-26');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483624, 'vy9uxj4', NULL, NULL, '2021-05-25');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483623, 'bdvlph', NULL, NULL, '2024-12-03');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483622, 'nd', NULL, NULL, '2022-11-09');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483621, 'nqcx5h', 'sal_2a88ca', NULL, '2022-05-10');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483620, 'p', 'sal_2a88ca', NULL, '2023-01-09');

INSERT INTO "sales" ("id", "product_name", "category", "amount", "sale_date") VALUES (-2147483619, 'tu0', 'sal_2a88ca', NULL, '2020-08-25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, COUNT(amount) AS c, SUM(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Gold Result:
(None, 0, None, None, None, None)
('sal_2a88ca', 6, 6.0, 1.0, 1.0, 1.0)
*/

-- Prediction Query
SELECT category, COUNT(amount) AS c, COUNT(amount) AS s, AVG(amount) AS a, MAX(amount) AS mx, MIN(amount) AS mn FROM sales GROUP BY category;

/*
Prediction Result:
(None, 0, 0, None, None, None)
('sal_2a88ca', 6, 6, 1.0, 1.0, 1.0)
*/