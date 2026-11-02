-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (33, 'TRUSTED42', 'NOT TRUSTED43');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (34, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (67, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(34, None, 1, None, None)
(67, None, 1, None, None)
*/

-- Prediction Query
WITH ALL_CONTACTS AS (SELECT USER_ID, CONTACT_NAME, CONTACT_EMAIL, 'TRUSTED' AS CATEGORY, 1 AS FLAG FROM CONTACTS WHERE (CONTACT_NAME, CONTACT_EMAIL) IN (SELECT DISTINCT CUSTOMER_NAME, EMAIL FROM CUSTOMERS) UNION SELECT USER_ID, CONTACT_NAME, CONTACT_EMAIL, 'NOT TRUSTED' AS CATEGORY, 0 AS FLAG FROM CONTACTS WHERE NOT (CONTACT_NAME, CONTACT_EMAIL) IN (SELECT DISTINCT CUSTOMER_NAME, EMAIL FROM CUSTOMERS)) SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COUNT(C2.USER_ID) AS CONTACTS_CNT, COALESCE(SUM(FLAG), 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C1 ON C1.CUSTOMER_ID = I.USER_ID LEFT JOIN ALL_CONTACTS AS C2 ON C1.CUSTOMER_ID = C2.USER_ID GROUP BY 1, 2, 3 ORDER BY 1 ASC, I.INVOICE_ID NULLS LAST, C1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(34, None, 1, 0, 0)
(67, None, 1, 0, 0)
*/