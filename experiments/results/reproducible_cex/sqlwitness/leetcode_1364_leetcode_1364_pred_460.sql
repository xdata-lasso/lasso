-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (2, 'default1', 'default1');
INSERT INTO customers (customer_id, customer_name, email) VALUES (2, 'default2', 'default1'), (0, 'default2', NULL), (-1, 'default2', 'default2'), (1, NULL, 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (1, 2, NULL), (2, NULL, 1), (-1, 2, 2), (0, -1, 1), (3, 0, 1), (4, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'default2', 2, 1, 1)
(0, 'default2', 1, 0, 0)
(1, 'default2', None, 1, 1)
(2, None, 1, None, None)
(3, 'default2', 1, 0, 0)
(4, 'default2', 1, 0, 0)
*/

-- Prediction Query
WITH T AS (SELECT INVOICE_ID, PRICE, INVOICES.USER_ID, CUSTOMER_NAME, EMAIL FROM INVOICES LEFT JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID), T1 AS (SELECT USER_ID, COUNT(*) AS TOTAL_CONTACT FROM CONTACTS GROUP BY 1), T2 AS (SELECT USER_ID, COUNT(CONTACT_EMAIL) AS TOTAL_TRUSTED FROM CONTACTS WHERE CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY 1) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(TOTAL_CONTACT, 0) AS CONTACTS_CNT, COALESCE(TOTAL_TRUSTED, 0) AS TRUSTED_CONTACTS_CNT FROM T LEFT JOIN T1 ON T1.USER_ID = T.USER_ID LEFT JOIN T2 ON T2.USER_ID = T1.USER_ID ORDER BY 1, INVOICE_ID NULLS LAST, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'default2', 2, 1, 1)
(0, 'default2', 1, 0, 0)
(1, 'default2', None, 1, 1)
(2, None, 1, 0, 0)
(3, 'default2', 1, 0, 0)
(4, 'default2', 1, 0, 0)
*/