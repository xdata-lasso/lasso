-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (-1, 'default2', NULL), (0, 'default1', 'default1'), (1, 'default2', NULL), (2, 'default1', 'default1'), (0, 'default2', 'default1');
INSERT INTO customers (customer_id, customer_name, email) VALUES (0, 'default2', 'default2'), (2, 'default2', 'default2'), (1, 'default2', 'default2'), (-1, NULL, 'default1'), (3, 'default1', NULL), (4, 'default2', 'default1'), (5, NULL, 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (2, 5, NULL), (1, -1, 2), (-1, 1, 2), (0, 1, 2), (3, 1, 2), (4, 0, NULL), (5, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'default2', 2, 0, 1)
(0, 'default2', 2, 0, 1)
(1, None, 2, 0, 1)
(2, None, None, 0, 0)
(3, 'default2', 2, 0, 1)
(4, 'default2', None, 2, 2)
(5, 'default2', 1, 0, 1)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COALESCE(C2.CNT, 0) AS CONTACTS_CNT, COALESCE(C2.CNT1, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C1 ON C1.CUSTOMER_ID = I.USER_ID LEFT JOIN (SELECT CONTACT_NAME, USER_ID, COUNT(DISTINCT CONTACT_NAME) AS CNT, SUM(IIF(CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS), 1, 0)) AS CNT1 FROM CONTACTS GROUP BY USER_ID) AS C2 ON C1.CUSTOMER_ID = C2.USER_ID ORDER BY I.INVOICE_ID, C1.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'default2', 2, 0, 0)
(0, 'default2', 2, 0, 0)
(1, None, 2, 0, 0)
(2, None, None, 0, 0)
(3, 'default2', 2, 0, 0)
(4, 'default2', None, 1, 2)
(5, 'default2', 1, 0, 0)
*/