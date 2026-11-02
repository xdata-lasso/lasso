-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (0, NULL, 'default2');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (0, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(0, None, 1, None, None)
*/

-- Prediction Query
WITH T1 AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, COUNT(CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS C2 ON C.CUSTOMER_ID = C2.USER_ID GROUP BY 1, 2), T2 AS (SELECT I.INVOICE_ID, T1.CUSTOMER_NAME, I.PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN T1 ON I.USER_ID = T1.CUSTOMER_ID) SELECT * FROM T2 ORDER BY 1;

/*
Prediction Result:
*/