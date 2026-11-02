-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (27, NULL, NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (63, NULL, NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (27, '29', '36');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (27, '28', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (62, 63, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (59, 27, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(59, None, 1, 1, 0)
(62, None, None, 0, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(COUNT(CO.USER_ID), 0) AS CONTACTS_CNT, COALESCE(SUM(CASE WHEN CO.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END), 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C INNER JOIN INVOICES AS I ON C.CUSTOMER_ID = I.USER_ID LEFT JOIN CONTACTS AS CO ON C.CUSTOMER_ID = CO.USER_ID GROUP BY I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE ORDER BY I.INVOICE_ID, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(59, None, 1, 2, 0)
(62, None, None, 0, 0)
*/