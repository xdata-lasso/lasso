-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'bob@example.com', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (101, 1, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(101, 'Alice', 50, 0, 0)
*/

-- Prediction Query
WITH TRUSTED_CONTACT AS (SELECT USER_ID, CONTACT_NAME, CONTACT_EMAIL, IIF((SELECT COUNT(1) FROM CUSTOMERS AS C WHERE CT.CONTACT_EMAIL = C.EMAIL) > 0, 1, 0) AS TRUSTED FROM CONTACTS AS CT) SELECT INV.INVOICE_ID, CUST.CUSTOMER_NAME, INV.PRICE, COUNT(CNT.CONTACT_EMAIL) AS CONTACTS_CNT, COALESCE(SUM(CNT.TRUSTED), 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS INV LEFT JOIN CUSTOMERS AS CUST ON INV.USER_ID = CUST.CUSTOMER_ID LEFT JOIN TRUSTED_CONTACT AS CNT ON CUST.CUSTOMER_ID = CNT.USER_ID GROUP BY 1, 2, 3 ORDER BY INVOICE_ID, INV.INVOICE_ID NULLS LAST, CUST.CUSTOMER_NAME NULLS LAST, INV.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(101, 'Alice', 50, 1, 0)
*/