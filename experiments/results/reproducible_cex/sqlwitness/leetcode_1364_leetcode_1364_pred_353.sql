-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (-1, 'TRUSTED', 'NOT TRUSTED');
INSERT INTO customers (customer_id, customer_name, email) VALUES (-1, 'default1', 'default2'), (0, 'default1', 'default2'), (1, 'default2', 'default1'), (2, 'NOT TRUSTED', 'NOT TRUSTED');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (-1, 0, NULL), (1, NULL, 2), (0, 2, NULL), (2, -1, 1), (3, -1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'default1', None, 0, 0)
(0, 'NOT TRUSTED', None, 0, 0)
(1, None, 2, None, None)
(2, 'default1', 1, 1, 0)
(3, 'default1', 2, 1, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT USER_ID, CONTACT_NAME, IIF(CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS), 'TRUSTED', 'NOT TRUSTED') AS CREDIBILITY FROM CONTACTS), CTE1 AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, COUNT(CONTACT_NAME) AS CONTACTS_CNT, SUM(IIF(CREDIBILITY = 'TRUSTED', 1, 0)) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CTE ON CUSTOMER_ID = USER_ID GROUP BY CUSTOMER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN CTE1 ON USER_ID = CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(-1, 'default1', None, 0, 0)
(0, 'NOT TRUSTED', None, 0, 0)
(1, None, 2, None, None)
(2, 'default1', 1, 1, 1)
(3, 'default1', 2, 1, 1)
*/