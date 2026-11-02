-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (2, 'default1', 'default2');
INSERT INTO customers (customer_id, customer_name, email) VALUES (1, 'default1', 'default2'), (0, NULL, 'default1'), (-1, 'default2', 'default1'), (2, NULL, 'default1'), (3, 'default2', NULL), (4, 'default2', 'default1'), (5, 'default1', 'default2'), (6, 'default1', NULL);
INSERT INTO invoices (invoice_id, user_id, price) VALUES (0, -1, 1), (2, 5, 1), (1, -1, NULL), (-1, 2, NULL), (3, -1, 2), (4, 5, NULL), (5, 1, 2), (6, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, None, 1, 1)
(0, 'default2', 1, 0, 0)
(1, 'default2', None, 0, 0)
(2, 'default1', 1, 0, 0)
(3, 'default2', 2, 0, 0)
(4, 'default1', None, 0, 0)
(5, 'default1', 2, 0, 0)
(6, None, None, None, None)
*/

-- Prediction Query
WITH COMBINED AS (SELECT C1.CUSTOMER_ID, C1.CUSTOMER_NAME, COUNT(C2.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN C2.CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C1 LEFT JOIN CONTACTS AS C2 ON C1.CUSTOMER_ID = C2.USER_ID GROUP BY C1.CUSTOMER_ID, C1.CUSTOMER_NAME) SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COUNT(C2.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN C2.CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C1 ON I.USER_ID = C1.CUSTOMER_ID LEFT JOIN CONTACTS AS C2 ON C1.CUSTOMER_ID = C2.USER_ID GROUP BY I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE ORDER BY INVOICE_ID, I.INVOICE_ID NULLS LAST, C1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, None, None, 1, 1)
(0, 'default2', 1, 0, 0)
(1, 'default2', None, 0, 0)
(2, 'default1', 1, 0, 0)
(3, 'default2', 2, 0, 0)
(4, 'default1', None, 0, 0)
(5, 'default1', 2, 0, 0)
*/