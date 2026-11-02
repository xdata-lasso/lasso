-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (0, 'default2', NULL), (2, NULL, NULL);
INSERT INTO invoices (invoice_id, user_id, price) VALUES (-1, NULL, 1), (1, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 1, None, None)
(1, 'default2', None, 0, 0)
*/

-- Prediction Query
WITH TMP AS (SELECT A.USER_ID, COUNT(A.CONTACT_EMAIL) AS CONTACTS_CNT, COUNT(B.EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_EMAIL = B.EMAIL GROUP BY USER_ID) SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, CASE WHEN C.CONTACTS_CNT IS NULL THEN 0 ELSE C.CONTACTS_CNT END AS CONTACTS_CNT, CASE WHEN C.TRUSTED_CONTACTS_CNT IS NULL THEN 0 ELSE C.TRUSTED_CONTACTS_CNT END AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN TMP AS C ON A.USER_ID = C.USER_ID ORDER BY A.INVOICE_ID, B.customer_id NULLS LAST;

/*
Prediction Result:
(1, 'default2', None, 0, 0)
*/