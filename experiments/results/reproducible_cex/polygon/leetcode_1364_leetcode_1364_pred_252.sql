-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '38', '39');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, '40', '41');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(30, None, 1, None, None)
*/

-- Prediction Query
WITH CTE AS (SELECT C.USER_ID, COUNT(C.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN CUST.CUSTOMER_NAME IS NULL THEN 0 ELSE 1 END) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C LEFT JOIN CUSTOMERS AS CUST ON C.CONTACT_NAME = CUST.CUSTOMER_NAME GROUP BY 1) SELECT I.INVOICE_ID, CUST.CUSTOMER_NAME, I.PRICE, COALESCE(CTE.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(CTE.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CUST ON I.USER_ID = CUST.CUSTOMER_ID LEFT JOIN CTE ON CTE.USER_ID = I.USER_ID ORDER BY 1 ASC, I.invoice_id NULLS LAST, CUST.customer_id NULLS LAST;

/*
Prediction Result:
(30, None, 1, 0, 0)
*/