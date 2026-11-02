-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_9c0dd5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'c_s_9c0dd5', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'cus_8d1b6b', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, NULL, 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, NULL, 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'cus_8d1b6b', 'ct__ab1779');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'cus_8d1b6b', 'cus_fe43f3');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'cus_8d1b6b', 'ct__ab1779');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__ab1779', 'ct__de6aed');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'ct__de6aed');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'c_s_9c0dd5', 1, 2, 1)
(0, 'c_s_9c0dd5', 1, 2, 1)
(1, 'c_s_9c0dd5', 1, 2, 1)
(2, 'c_s_9c0dd5', 1, 2, 1)
(3, 'c_s_9c0dd5', 1, 2, 1)
*/

-- Prediction Query
WITH CNT AS (SELECT T.USER_ID, COUNT(*) AS CONTACTS_CNT, SUM(TRUSTED) AS TRUSTED_CONTACTS_CNT FROM (SELECT CT.*, CASE WHEN CM.EMAIL IS NULL THEN 0 ELSE 1 END AS TRUSTED FROM CONTACTS AS CT LEFT JOIN CUSTOMERS AS CM ON CT.CONTACT_EMAIL = CM.EMAIL) AS T GROUP BY T.USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CNT ON I.USER_ID = CNT.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'c_s_9c0dd5', 1, 19, 18)
(0, 'c_s_9c0dd5', 1, 19, 18)
(1, 'c_s_9c0dd5', 1, 19, 18)
(2, 'c_s_9c0dd5', 1, 19, 18)
(3, 'c_s_9c0dd5', 1, 19, 18)
*/