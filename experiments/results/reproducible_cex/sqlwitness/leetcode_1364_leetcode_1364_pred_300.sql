-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (0, 'default1', 'default1'), (2, 'default2', NULL), (0, 'default2', 'default1'), (2, 'default1', NULL);
INSERT INTO customers (customer_id, customer_name, email) VALUES (-1, 'default1', 'default1'), (0, NULL, 'default1'), (2, NULL, 'default2'), (1, 'default1', 'default2'), (3, 'default1', 'default2'), (4, NULL, 'default1'), (5, 'default1', 'default2'), (6, 'default2', 'default2');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (0, 2, NULL), (1, NULL, 1), (2, 2, 2), (-1, NULL, 1), (3, 6, 1), (4, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 1, None, None)
(0, None, None, 0, 2)
(1, None, 1, None, None)
(2, None, 2, 0, 2)
(3, 'default2', 1, 0, 0)
(4, None, None, 0, 2)
*/

-- Prediction Query
WITH T1 AS (SELECT USER_ID, COUNT(USER_ID) AS F1 FROM CONTACTS GROUP BY USER_ID), T2 AS (SELECT USER_ID, COUNT(USER_ID) AS F2 FROM CONTACTS AS CON INNER JOIN CUSTOMERS AS CUS ON CUS.CUSTOMER_NAME = CON.CONTACT_NAME AND CON.CONTACT_EMAIL = CUS.EMAIL GROUP BY USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(T1.F1, 0) AS CONTACTS_CNT, COALESCE(T2.F2, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = I.USER_ID LEFT JOIN T1 ON T1.USER_ID = I.USER_ID LEFT JOIN T2 ON T2.USER_ID = I.USER_ID ORDER BY INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(0, None, None, 2, 0)
(2, None, 2, 2, 0)
(3, 'default2', 1, 0, 0)
(4, None, None, 2, 0)
*/