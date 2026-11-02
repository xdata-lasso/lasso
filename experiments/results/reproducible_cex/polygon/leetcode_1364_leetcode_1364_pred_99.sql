-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (32, '43', NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (34, '46', '47');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (34, '33', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (35, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(35, None, None, None, None)
*/

-- Prediction Query
WITH T1 AS (SELECT USER_ID, COUNT(DISTINCT CONTACT_NAME) AS CONTACT_CNT FROM CONTACTS AS C GROUP BY 1), T2 AS (SELECT USER_ID, COUNT(DISTINCT CONTACT_NAME) AS TRUSTED_CONTACT_CNT FROM CONTACTS AS C WHERE CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY 1) SELECT DISTINCT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(T1.CONTACT_CNT, 0) AS CONTACTS_CNT, COALESCE(T2.TRUSTED_CONTACT_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN T1 ON I.USER_ID = T1.USER_ID LEFT JOIN T2 ON I.USER_ID = T2.USER_ID ORDER BY INVOICE_ID, I.INVOICE_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(35, None, None, 0, 0)
*/