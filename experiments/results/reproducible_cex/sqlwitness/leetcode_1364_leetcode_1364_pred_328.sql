-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (-1, 'default2', 'default2'), (0, 'default1', 'default2'), (1, 'default2', 'default1'), (2, 'default1', 'default1'), (-1, 'default1', 'default1'), (1, 'default1', 'default1'), (0, 'default2', 'default1');
INSERT INTO customers (customer_id, customer_name, email) VALUES (1, 'default1', 'default2'), (0, 'default2', 'default2'), (2, NULL, 'default1'), (-1, 'default2', 'default1'), (3, 'default2', 'default2'), (4, 'default1', NULL), (5, NULL, 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (1, 1, 1), (-1, 2, 1), (0, 2, 2), (2, NULL, 1), (3, NULL, 1), (4, 5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 1, 1, 1)
(0, None, 2, 1, 1)
(1, 'default1', 1, 2, 2)
(2, None, 1, None, None)
(3, None, 1, None, None)
(4, None, 2, 0, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT C1.CUSTOMER_ID, C1.CUSTOMER_NAME, COUNT(DISTINCT C2.CONTACT_EMAIL) AS CONTACTS_CNT, SUM(CASE WHEN NOT C3.EMAIL IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C1 LEFT JOIN CONTACTS AS C2 ON C1.CUSTOMER_ID = C2.USER_ID LEFT JOIN CUSTOMERS AS C3 ON C3.EMAIL = C2.CONTACT_EMAIL GROUP BY 1) SELECT INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, C.CONTACTS_CNT, C.TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CTE AS C ON I.USER_ID = C.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(-1, None, 1, 1, 3)
(0, None, 2, 1, 3)
(1, 'default1', 1, 2, 6)
(2, None, 1, None, None)
(3, None, 1, None, None)
(4, None, 2, 0, 0)
*/