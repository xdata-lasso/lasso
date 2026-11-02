-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (-1, NULL, 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (2, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(2, None, 1, None, None)
*/

-- Prediction Query
WITH T1 AS (SELECT INVOICE_ID, CUSTOMER_ID, CUSTOMER_NAME, PRICE FROM INVOICES AS A LEFT JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID), T2 AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS RELATES, COUNT(CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 END) AS TRUSTS FROM CONTACTS GROUP BY USER_ID) SELECT INVOICE_ID, T1.CUSTOMER_NAME, PRICE, COALESCE(RELATES, 0) AS CONTACTS_CNT, COALESCE(TRUSTS, 0) AS TRUSTED_CONTACTS_CNT FROM T1 LEFT JOIN T2 ON T1.CUSTOMER_ID = T2.USER_ID ORDER BY INVOICE_ID, T1.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(2, None, 1, 0, 0)
*/