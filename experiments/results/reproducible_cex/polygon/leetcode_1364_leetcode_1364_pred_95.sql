-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (26, '35', '34');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (24, '35', '36');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (26, '25', '35');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (24, '36', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (27, 24, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (77, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(27, '35', None, 0, 1)
(77, None, 1, None, None)
*/

-- Prediction Query
WITH SUMMARY AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT, SUM(IIF(NOT CUSTOMER_NAME IS NULL, 1, 0)) AS TRUSTED_CONTACTS_CNT FROM CONTACTS LEFT JOIN CUSTOMERS ON CONTACTS.CONTACT_NAME = CUSTOMERS.CUSTOMER_NAME GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN SUMMARY ON INVOICES.USER_ID = SUMMARY.USER_ID ORDER BY INVOICE_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(27, '35', None, 0, 0)
(77, None, 1, 0, 0)
*/