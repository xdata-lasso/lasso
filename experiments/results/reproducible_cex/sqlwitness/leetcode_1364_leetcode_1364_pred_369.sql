-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (3, 'default1', 'default2'), (0, 'default2', 'default2'), (0, 'default1', NULL), (3, 'default2', 'default1');
INSERT INTO customers (customer_id, customer_name, email) VALUES (1, 'default2', 'default2'), (3, NULL, NULL), (0, NULL, NULL);
INSERT INTO invoices (invoice_id, user_id, price) VALUES (0, 0, NULL), (3, 3, 3), (-1, NULL, 2), (2, NULL, 2), (1, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 2, None, None)
(0, None, None, 1, 1)
(1, None, 3, 2, 1)
(2, None, 2, None, None)
(3, None, 3, 2, 1)
*/

-- Prediction Query
WITH TRUST AS (SELECT CUSTOMER_ID AS CUST_ID, CUSTOMER_NAME, SUM(CASE WHEN CUSTOMER_ID IN (SELECT USER_ID FROM CUSTOMERS) THEN 1 ELSE 0 END) AS CONTACTS_CNT, COALESCE(SUM(CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END), 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS LEFT JOIN CONTACTS ON CONTACTS.USER_ID = CUSTOMERS.CUSTOMER_ID GROUP BY 1, 2) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM TRUST JOIN INVOICES ON INVOICES.USER_ID = TRUST.CUST_ID ORDER BY 1, INVOICES.invoice_id NULLS LAST;

/*
Prediction Result:
(0, None, None, 2, 1)
(1, None, 3, 2, 1)
(3, None, 3, 2, 1)
*/