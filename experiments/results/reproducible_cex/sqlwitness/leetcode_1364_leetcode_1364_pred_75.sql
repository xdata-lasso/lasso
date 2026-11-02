-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO invoices (invoice_id, user_id, price) VALUES (0, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(0, None, 1, None, None)
*/

-- Prediction Query
WITH C1 AS (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME, COUNT(B.CONTACT_EMAIL) AS CONTACTS_CNT, SUM(CASE WHEN B.CONTACT_EMAIL IN (SELECT A.EMAIL FROM CUSTOMERS AS A) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID GROUP BY 1) SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, C1.CONTACTS_CNT, C1.TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN C1 ON I.USER_ID = C1.CUSTOMER_ID ORDER BY 1, I.invoice_id NULLS LAST;

/*
Prediction Result:
*/