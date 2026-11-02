-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'bob@example.com', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 0, 0)
*/

-- Prediction Query
SELECT T2.INVOICE_ID, T2.CUSTOMER_NAME, T2.PRICE, COALESCE(COUNT(T2.USER_ID), 0) AS CONTACTS_CNT, COALESCE(SUM(T2.TRUSTED), 0) AS TRUSTED_CONTACTS_CNT FROM (SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, T1.TRUSTED, T1.USER_ID FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, CONTACT_NAME, CASE WHEN CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUSTED FROM CONTACTS) AS T1 ON C.CUSTOMER_ID = T1.USER_ID) AS T2 GROUP BY T2.INVOICE_ID, T2.CUSTOMER_NAME, T2.PRICE ORDER BY T2.INVOICE_ID ASC, T2.CUSTOMER_NAME NULLS LAST, T2.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
*/