-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO invoices (invoice_id, user_id, price) VALUES (2, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(2, None, 2, None, None)
*/

-- Prediction Query
WITH CONTACTS_LKP AS (SELECT CT.*, CASE WHEN NOT CUST_EMAILS.EMAIL IS NULL THEN 1 ELSE 0 END AS IS_TRUSTED FROM CONTACTS AS CT LEFT JOIN (SELECT EMAIL FROM CUSTOMERS GROUP BY EMAIL) AS CUST_EMAILS ON CT.CONTACT_EMAIL = CUST_EMAILS.EMAIL), CONTACT_INFO AS (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT, SUM(IS_TRUSTED) AS TRUSTED_CONTACTS_CNT FROM CONTACTS_LKP GROUP BY USER_ID) SELECT I.INVOICE_ID, CT.CUSTOMER_NAME, I.PRICE, COALESCE(CI.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(CI.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS CT ON I.USER_ID = CT.CUSTOMER_ID LEFT JOIN CONTACT_INFO AS CI ON I.USER_ID = CI.USER_ID ORDER BY INVOICE_ID, CT.customer_id NULLS LAST;

/*
Prediction Result:
*/