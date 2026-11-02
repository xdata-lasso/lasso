-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (1, 'default1', 'default1'), (2, 'default2', NULL), (0, NULL, NULL);
INSERT INTO invoices (invoice_id, user_id, price) VALUES (2, NULL, NULL), (0, NULL, NULL), (-1, 0, 1), (1, 2, 2), (3, 1, 2), (4, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 1, 0, 0)
(0, None, None, None, None)
(1, 'default2', 2, 0, 0)
(2, None, None, None, None)
(3, 'default1', 2, 0, 0)
(4, None, 1, 0, 0)
*/

-- Prediction Query
SELECT DISTINCT INVOICE_ID, CUSTOMER_NAME AS CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COUNT(CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN (SELECT USER_ID, COUNT(DISTINCT CONTACT_EMAIL) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID) AS C ON I.USER_ID = C.USER_ID LEFT JOIN (SELECT CU.CUSTOMER_ID, CUSTOMER_NAME, CONTACT_EMAIL FROM CUSTOMERS AS CU LEFT JOIN (SELECT USER_ID, CONTACT_EMAIL FROM CONTACTS WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS)) AS CC ON CU.CUSTOMER_ID = CC.USER_ID) AS B ON B.CUSTOMER_ID = I.USER_ID GROUP BY INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, None, 1, 0, 0)
(0, None, None, 0, 0)
(1, 'default2', 2, 0, 0)
(2, None, None, 0, 0)
(3, 'default1', 2, 0, 0)
(4, None, 1, 0, 0)
*/