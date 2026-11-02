-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (2, 'default2', 'default1'), (0, 'default2', 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (0, NULL, NULL), (2, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(0, None, None, None, None)
(2, 'default2', None, 0, 0)
*/

-- Prediction Query
WITH T1 AS (SELECT USER_ID, COUNT(DISTINCT CONTACT_NAME) AS C1 FROM CONTACTS GROUP BY USER_ID), T2 AS (SELECT A.USER_ID, COUNT(DISTINCT A.CONTACT_NAME) AS C2 FROM CONTACTS AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_NAME = B.CUSTOMER_NAME WHERE NOT B.CUSTOMER_NAME IS NULL GROUP BY A.USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(T1.C1, 0) AS CONTACTS_CNT, COALESCE(T2.C2, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN T1 ON I.USER_ID = T1.USER_ID LEFT JOIN T2 ON I.USER_ID = T2.USER_ID LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(0, None, None, 0, 0)
(2, 'default2', None, 0, 0)
*/