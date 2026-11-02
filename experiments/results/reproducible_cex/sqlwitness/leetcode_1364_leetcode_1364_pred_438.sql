-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO invoices (invoice_id, user_id, price) VALUES (0, NULL, NULL), (-1, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 2, None, None)
(0, None, None, None, None)
*/

-- Prediction Query
SELECT T3.INVOICE_ID, T5.CUSTOMER_NAME, T3.PRICE, COALESCE(T4.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(T4.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS T3 LEFT JOIN (SELECT T1.USER_ID, COUNT(T1.CONTACT_NAME) AS CONTACTS_CNT, COUNT(IIF(NOT T2.CUSTOMER_NAME IS NULL, 1, NULL)) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS T1 LEFT JOIN CUSTOMERS AS T2 ON T1.CONTACT_NAME = T2.CUSTOMER_NAME GROUP BY T1.USER_ID ORDER BY USER_ID, T1.USER_ID NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST) AS T4 ON T3.USER_ID = T4.USER_ID LEFT JOIN CUSTOMERS AS T5 ON T5.CUSTOMER_ID = T3.USER_ID ORDER BY T3.INVOICE_ID, T5.customer_id NULLS LAST;

/*
Prediction Result:
(-1, None, 2, 0, 0)
(0, None, None, 0, 0)
*/