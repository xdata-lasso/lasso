-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (1, 'default2', 'default1'), (0, NULL, NULL);
INSERT INTO invoices (invoice_id, user_id, price) VALUES (0, 0, 2), (-1, 1, 2), (1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'default2', 2, 0, 0)
(0, None, 2, 0, 0)
(1, None, None, None, None)
*/

-- Prediction Query
WITH CONTACTS_BY_USER AS (SELECT USER_ID, COUNT(1) AS CONTACTS_CNT, COUNT(CU.EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C LEFT JOIN CUSTOMERS AS CU ON C.CONTACT_EMAIL = CU.EMAIL GROUP BY 1) SELECT INVOICE_ID, CU.CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID LEFT JOIN CONTACTS_BY_USER AS U ON U.USER_ID = I.USER_ID ORDER BY 1, I.invoice_id NULLS LAST, CU.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'default2', 2, 0, 0)
(0, None, 2, 0, 0)
(1, None, None, 0, 0)
*/