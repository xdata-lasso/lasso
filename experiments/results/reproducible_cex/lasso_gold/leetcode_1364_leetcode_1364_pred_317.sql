-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1042, 'Barry Hensley', 'kwilson@example.org');
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1043, 'Amanda Miller', 'sarah35@example.org');
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1046, 'Amanda Miller', 'sarah35@example.org');
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1048, 'William Roman', 'contrerasangela@example.net');
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1049, 'Shawn Baker', 'newtoneric@example.com');
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1052, 'Shawn Baker', 'newtoneric@example.com');
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1042, 'randy47@example.com', '001-310-579-9118x38425');
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1042, 'justin78@example.net', '001-310-579-9118x38425');
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1048, 'jenniferharris@example.net', NULL);
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1048, 'barnold@example.net', NULL);
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1044, 1042, 1045);
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1047, NULL, 1045);
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1050, 1048, 1051);
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1053, NULL, 1051);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1044, 'Barry Hensley', 1045, 2, 0)
(1047, None, 1045, None, None)
(1050, 'William Roman', 1051, 0, 0)
(1053, None, 1051, None, None)
*/

-- Prediction Query
WITH TRUSTED_CONTACTS AS (SELECT T1.CUSTOMER_ID, COUNT(T2.USER_ID) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS T1 LEFT JOIN (SELECT USER_ID, CONTACT_NAME, CONTACT_EMAIL FROM CONTACTS WHERE (CONTACT_NAME, CONTACT_EMAIL) IN (SELECT CUSTOMER_NAME, EMAIL FROM CUSTOMERS)) AS T2 ON T1.CUSTOMER_ID = T2.USER_ID GROUP BY T1.CUSTOMER_ID), CUSTOMER_CONTACTS AS (SELECT T1.CUSTOMER_ID, T1.CUSTOMER_NAME, COUNT(T2.USER_ID) AS CONTACTS_CNT FROM CUSTOMERS AS T1 LEFT JOIN CONTACTS AS T2 ON T1.CUSTOMER_ID = T2.USER_ID GROUP BY T1.CUSTOMER_ID) SELECT T1.INVOICE_ID, T2.CUSTOMER_NAME, T1.PRICE, T2.CONTACTS_CNT, T3.TRUSTED_CONTACTS_CNT FROM INVOICES AS T1 LEFT JOIN CUSTOMER_CONTACTS AS T2 ON T1.USER_ID = T2.CUSTOMER_ID LEFT JOIN TRUSTED_CONTACTS AS T3 ON T1.USER_ID = T3.CUSTOMER_ID ORDER BY 1, T1.invoice_id NULLS LAST;

/*
Prediction Result:
(1044, 'Barry Hensley', 1045, 2, 0)
(1047, None, 1045, None, None)
(1050, 'William Roman', 1051, 2, 0)
(1053, None, 1051, None, None)
*/