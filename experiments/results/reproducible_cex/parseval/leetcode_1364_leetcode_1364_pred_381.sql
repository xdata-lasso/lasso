-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_d74bc0', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'a_s_d74bc0', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_c96c51', 'b_s_bd2dc1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'b_s_c96c51', 'b_s_bd2dc1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_cc1eb9', 'b_s_15c623');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cus_8d1b6b', 1, 0, 0)
(-2147483646, 'cus_8d1b6b', 1, 0, 0)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(1, 'a_s_d74bc0', 1, 4, 0)
*/

-- Prediction Query
WITH INV AS (SELECT I.INVOICE_ID, C.CUSTOMER_ID, C.CUSTOMER_NAME, I.PRICE FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID), CTCT AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, COUNT(DISTINCT T.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN T.CONTACT_NAME IN (SELECT DISTINCT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS T ON C.CUSTOMER_ID = T.USER_ID GROUP BY C.CUSTOMER_ID, C.CUSTOMER_NAME) SELECT INV.INVOICE_ID, INV.CUSTOMER_NAME, INV.PRICE, CTCT.CONTACTS_CNT, CTCT.TRUSTED_CONTACTS_CNT FROM INV JOIN CTCT ON INV.CUSTOMER_ID = CTCT.CUSTOMER_ID ORDER BY INVOICE_ID, INV.INVOICE_ID NULLS LAST, INV.CUSTOMER_NAME NULLS LAST, INV.PRICE NULLS LAST, CTCT.CONTACTS_CNT NULLS LAST, CTCT.TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cus_8d1b6b', 1, 0, 0)
(-2147483646, 'cus_8d1b6b', 1, 0, 0)
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(1, 'a_s_d74bc0', 1, 3, 0)
*/