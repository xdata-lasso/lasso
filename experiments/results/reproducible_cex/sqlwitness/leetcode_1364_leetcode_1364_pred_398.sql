-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (2, 'default2', 'default1');
INSERT INTO customers (customer_id, customer_name, email) VALUES (2, 'default2', NULL), (0, NULL, 'default1'), (-1, 'default2', 'default2'), (1, 'default1', NULL), (3, NULL, 'default2'), (4, 'default1', 'default2');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (-1, 3, 2), (2, 2, NULL), (0, 3, 1), (1, 0, NULL), (3, 0, 1), (4, 3, 2), (5, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 2, 0, 0)
(0, None, 1, 0, 0)
(1, None, None, 0, 0)
(2, 'default2', None, 1, 1)
(3, None, 1, 0, 0)
(4, None, 2, 0, 0)
(5, None, None, 0, 0)
*/

-- Prediction Query
WITH TEMP AS (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME, COUNT(B.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN NOT C.EMAIL IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID LEFT JOIN CUSTOMERS AS C ON B.CONTACT_EMAIL = C.EMAIL GROUP BY 1) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN TEMP AS B ON A.USER_ID = B.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(-1, None, 2, 0, 0)
(0, None, 1, 0, 0)
(1, None, None, 0, 0)
(2, 'default2', None, 3, 3)
(3, None, 1, 0, 0)
(4, None, 2, 0, 0)
(5, None, None, 0, 0)
*/