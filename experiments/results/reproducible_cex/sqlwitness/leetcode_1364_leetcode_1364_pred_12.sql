-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (0, 'default2', 'default1'), (1, 'default1', NULL), (-1, 'default1', NULL), (1, 'default2', 'default1');
INSERT INTO customers (customer_id, customer_name, email) VALUES (2, 'default1', 'default1'), (3, 'default1', 'default2'), (-1, 'default1', 'default1'), (1, 'default2', 'default2'), (4, NULL, 'default1'), (0, 'default1', NULL), (5, 'default1', NULL), (6, 'default2', NULL), (7, 'default2', 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (3, 7, 3), (-1, 7, 4), (1, 7, NULL), (0, 0, NULL), (2, 1, NULL), (4, 4, NULL), (5, 5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'default2', 4, 0, 0)
(0, 'default1', None, 1, 1)
(1, 'default2', None, 0, 0)
(2, 'default2', None, 1, 2)
(3, 'default2', 3, 0, 0)
(4, None, None, 0, 0)
(5, 'default1', None, 0, 0)
*/

-- Prediction Query
SELECT C.INVOICE_ID, A.CUSTOMER_NAME, C.PRICE, COUNT(B.USER_ID) AS CONTACTS_CNT, SUM(CASE WHEN B.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A JOIN INVOICES AS C ON A.CUSTOMER_ID = C.USER_ID LEFT JOIN CONTACTS AS B ON B.USER_ID = C.USER_ID GROUP BY 1, 2, 3 ORDER BY 1, C.INVOICE_ID NULLS LAST, A.CUSTOMER_NAME NULLS LAST, C.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'default2', 4, 0, 0)
(0, 'default1', None, 1, 1)
(1, 'default2', None, 0, 0)
(2, 'default2', None, 2, 2)
(3, 'default2', 3, 0, 0)
(4, None, None, 0, 0)
(5, 'default1', None, 0, 0)
*/