-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (0, 'default1', 'default1'), (2, 'default1', 'default2'), (-1, 'default1', NULL), (1, 'default1', NULL), (0, 'default2', NULL);
INSERT INTO customers (customer_id, customer_name, email) VALUES (1, 'default2', 'default2'), (2, 'default1', NULL), (0, NULL, NULL), (-1, NULL, 'default1'), (3, NULL, 'default2'), (4, 'default1', NULL), (5, NULL, NULL);
INSERT INTO invoices (invoice_id, user_id, price) VALUES (-1, -1, NULL), (2, 4, NULL), (0, 4, 2), (1, 4, 2), (3, -1, NULL), (4, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, None, 0, 1)
(0, 'default1', 2, 0, 0)
(1, 'default1', 2, 0, 0)
(2, 'default1', None, 0, 0)
(3, None, None, 0, 1)
(4, None, None, 0, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, COUNT(B.USER_ID) AS CONTACTS_CNT, COALESCE(SUM(CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS)), 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID GROUP BY CUSTOMER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN CTE AS B ON A.USER_ID = B.CUSTOMER_ID ORDER BY 1, A.invoice_id NULLS LAST;

/*
Prediction Result:
(-1, None, None, 1, 1)
(0, 'default1', 2, 0, 0)
(1, 'default1', 2, 0, 0)
(2, 'default1', None, 0, 0)
(3, None, None, 1, 1)
(4, None, None, 0, 0)
*/