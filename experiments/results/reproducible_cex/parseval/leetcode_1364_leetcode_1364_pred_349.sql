-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_8d1b6b', 'a_s_1dbc36');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'cus_8d1b6b', 'a_s_8f5272');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'b_s_e0c4d7', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'b_s_e0c4d7', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'a_s_1dbc36');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'cus_8d1b6b', 'a_s_1dbc36');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'cus_8d1b6b', 'a_s_1dbc36');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'cus_8d1b6b', 'a_s_1dbc36');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'cus_8d1b6b', 'a_s_1dbc36');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_d88276', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_833d9a', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_940a9d', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_1dbc36', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'G', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'Q', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '_', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '_', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'O', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cus_8d1b6b', 1, 7, 1)
(1, 'cus_8d1b6b', 1, 7, 1)
*/

-- Prediction Query
WITH CONTACTS_COUNT AS (SELECT USER_ID, COUNT(CONTACT_EMAIL) AS TOTAL_CONTACTS FROM CONTACTS GROUP BY USER_ID), TRUSTED_CONTACT_COUNTS AS (SELECT USER_ID, COUNT(CONTACT_EMAIL) AS TOTAL_TRUTSED_CONTACTS FROM (SELECT A.CUSTOMER_ID, A.EMAIL, B.USER_ID, B.CONTACT_EMAIL FROM CUSTOMERS AS A INNER JOIN CONTACTS AS B ON A.EMAIL = B.CONTACT_EMAIL) AS T1 GROUP BY USER_ID), INVOICEINFO_JOINED AS (SELECT INVOICE_ID, PRICE, T1.USER_ID, (CASE WHEN NOT TOTAL_CONTACTS IS NULL THEN TOTAL_CONTACTS ELSE 0 END) AS CONTACTS_CNT, (CASE WHEN NOT TOTAL_TRUTSED_CONTACTS IS NULL THEN TOTAL_TRUTSED_CONTACTS ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM (SELECT INVOICE_ID, PRICE, A.USER_ID, TOTAL_CONTACTS FROM INVOICES AS A LEFT JOIN CONTACTS_COUNT AS B ON A.USER_ID = B.USER_ID) AS T1 LEFT JOIN TRUSTED_CONTACT_COUNTS AS T2 ON T1.USER_ID = T2.USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICEINFO_JOINED AS A LEFT JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID ORDER BY INVOICE_ID ASC, B.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cus_8d1b6b', 1, 7, 6)
(1, 'cus_8d1b6b', 1, 7, 6)
*/