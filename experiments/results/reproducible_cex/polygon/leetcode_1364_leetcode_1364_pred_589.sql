-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, NULL, NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (43, NULL, '42');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (43, '29', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (43, '42', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (31, 43, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, 43, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(30, None, 1, 0, 1)
(31, None, None, 0, 1)
*/

-- Prediction Query
SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, SUM(CASE WHEN NOT CONT.USER_ID IS NULL THEN 1 ELSE 0 END) AS CONTACTS_CNT, SUM(CASE WHEN NOT CONT.USER_ID IS NULL AND CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS INV LEFT JOIN CUSTOMERS AS CUST ON INV.USER_ID = CUST.CUSTOMER_ID LEFT JOIN CONTACTS AS CONT ON CUST.CUSTOMER_ID = CONT.USER_ID GROUP BY INVOICE_ID ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(30, None, 1, 2, 1)
(31, None, None, 2, 1)
*/