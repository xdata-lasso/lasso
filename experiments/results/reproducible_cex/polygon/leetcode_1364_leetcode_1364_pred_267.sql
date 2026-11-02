-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (77, '36', '37');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, '39', '40');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (77, '40', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (76, 28, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (29, 77, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(29, '36', None, 0, 1)
(76, '39', None, 0, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT C.USER_ID, COUNT(DISTINCT CONTACT_EMAIL) AS CONTACTS_CNT, SUM(IIF(NOT C1.EMAIL IS NULL, 1, 0)) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C LEFT JOIN CUSTOMERS AS C1 ON C.CONTACT_EMAIL = C1.EMAIL GROUP BY C.USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(C1.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(C1.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = I.USER_ID LEFT JOIN CTE AS C1 ON C1.USER_ID = I.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(29, '36', None, 1, 1)
(76, '39', None, 0, 0)
*/