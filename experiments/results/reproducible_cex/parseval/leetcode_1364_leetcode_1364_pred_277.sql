-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cu__1da84c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cu__1da84c', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_8d1b6b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, NULL, 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'cus_8d1b6b', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'cus_8d1b6b', 'c_s_1cd477');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'cus_8d1b6b', 'c_s_1cd477');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_1cd477', 'c_s_d12f7d');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'c_s_d12f7d');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'c_s_c51a1d');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '!', 'c_s_d12f7d');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'c_s_1cd477', 'c_s_d12f7d');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'c_s_1cd477', 'c_s_d12f7d');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483630, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483638, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483637, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cu__1da84c', 1, 4, 1)
(-2147483646, 'cu__1da84c', 1, 4, 1)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cu__1da84c', 1, 4, 1)
(-2147483642, 'cus_8d1b6b', 1, 0, 0)
(-2147483641, 'cus_8d1b6b', 1, 0, 0)
(-2147483640, 'cu__1da84c', 1, 4, 1)
(-2147483639, 'cus_8d1b6b', 1, 0, 0)
(-2147483638, 'cus_8d1b6b', 1, 0, 0)
(-2147483637, 'cu__1da84c', 1, 4, 1)
(1, 'cu__1da84c', 1, 4, 1)
(2, 'cu__1da84c', 1, 4, 1)
(3, 'cu__1da84c', 1, 4, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT, COUNT(CU.EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C LEFT JOIN CUSTOMERS AS CU ON C.CONTACT_EMAIL = CU.EMAIL GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID LEFT JOIN CTE AS C ON I.USER_ID = C.USER_ID ORDER BY INVOICE_ID, CU.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cu__1da84c', 1, 27, 24)
(-2147483646, 'cu__1da84c', 1, 27, 24)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cu__1da84c', 1, 27, 24)
(-2147483642, 'cus_8d1b6b', 1, 0, 0)
(-2147483641, 'cus_8d1b6b', 1, 0, 0)
(-2147483640, 'cu__1da84c', 1, 27, 24)
(-2147483639, 'cus_8d1b6b', 1, 0, 0)
(-2147483638, 'cus_8d1b6b', 1, 0, 0)
(-2147483637, 'cu__1da84c', 1, 27, 24)
(1, 'cu__1da84c', 1, 27, 24)
(2, 'cu__1da84c', 1, 27, 24)
(3, 'cu__1da84c', 1, 27, 24)
*/