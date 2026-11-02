-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (-1, 'default2', 'default2'), (2, 'default1', 'default2');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (2, 2, 2), (0, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(0, None, 1, None, None)
(2, 'default1', 2, 0, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, SUM(CASE WHEN T.USER_ID IS NULL THEN 0 ELSE 1 END) AS CONTACTS_CNT, SUM(CASE WHEN T.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS T ON C.CUSTOMER_ID = T.USER_ID GROUP BY C.CUSTOMER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, C.CONTACTS_CNT, C.TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CTE AS C ON I.USER_ID = C.CUSTOMER_ID ORDER BY I.INVOICE_ID;

/*
Prediction Result:
(2, 'default1', 2, 0, 0)
*/