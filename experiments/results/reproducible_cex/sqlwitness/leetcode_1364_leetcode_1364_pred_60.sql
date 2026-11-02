-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (0, NULL, 'default2'), (-1, NULL, 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, None, 1, None, None)
*/

-- Prediction Query
SELECT T1.INVOICE_ID, T2.CUSTOMER_NAME, T1.PRICE, COUNT(T3.USER_ID) AS CONTACTS_CNT, COUNT(T4.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS T1 INNER JOIN CUSTOMERS AS T2 ON T2.CUSTOMER_ID = T1.USER_ID LEFT JOIN CONTACTS AS T3 ON T3.USER_ID = T2.CUSTOMER_ID LEFT JOIN CUSTOMERS AS T4 ON T4.EMAIL = T3.CONTACT_EMAIL GROUP BY T1.INVOICE_ID, T2.CUSTOMER_NAME, T1.PRICE ORDER BY T1.INVOICE_ID, T2.CUSTOMER_NAME NULLS LAST, T1.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
*/