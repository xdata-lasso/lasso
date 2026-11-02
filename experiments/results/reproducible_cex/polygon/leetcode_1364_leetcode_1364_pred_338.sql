-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (30, '37', '38');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '40', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (30, '38', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (68, 30, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(68, '37', None, 0, 1)
*/

-- Prediction Query
SELECT T2.INVOICE_ID, C.CUSTOMER_NAME, T2.PRICE, T2.CONTACTS_CNT, T2.TRUSTED_CONTACTS_CNT FROM (SELECT I.INVOICE_ID, I.USER_ID, I.PRICE, COALESCE(T.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(T.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN (SELECT C1.USER_ID, COUNT(*) AS CONTACTS_CNT, SUM(IIF(C2.EMAIL IS NULL, 0, 1)) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C1 LEFT JOIN CUSTOMERS AS C2 ON C1.CONTACT_EMAIL = C2.EMAIL GROUP BY C1.USER_ID) AS T ON I.USER_ID = T.USER_ID) AS T2 INNER JOIN CUSTOMERS AS C ON T2.USER_ID = C.CUSTOMER_ID ORDER BY T2.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(68, '37', None, 1, 1)
*/