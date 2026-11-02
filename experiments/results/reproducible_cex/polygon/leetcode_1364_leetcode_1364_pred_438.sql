-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (74, NULL, '38');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (65, NULL, '42');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (65, '38', '39');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (65, '42', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, 65, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (29, 74, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(29, None, 1, 0, 0)
(30, None, None, 1, 2)
*/

-- Prediction Query
WITH CUSTOMER AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, COUNT(DISTINCT CO.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN CO.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS CO ON C.CUSTOMER_ID = CO.USER_ID GROUP BY C.CUSTOMER_ID, C.CUSTOMER_NAME) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, C.CONTACTS_CNT, C.TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMER AS C ON I.USER_ID = C.CUSTOMER_ID ORDER BY I.INVOICE_ID;

/*
Prediction Result:
(29, None, 1, 0, 0)
(30, None, None, 1, 0)
*/