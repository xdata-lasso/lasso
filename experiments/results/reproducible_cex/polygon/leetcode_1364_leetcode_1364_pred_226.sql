-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (66, '78', NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, '41', '42');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (66, '29', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (66, '42', '40');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (31, 66, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, 66, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(30, '78', None, 1, 1)
(31, '78', None, 1, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, EMAIL, COUNT(C.USER_ID) AS CONTACTS_CNT FROM CUSTOMERS LEFT JOIN CONTACTS AS C ON C.USER_ID = CUSTOMER_ID GROUP BY CUSTOMER_ID, CUSTOMER_NAME, EMAIL), CTE2 AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, EMAIL, CONTACTS_CNT, COUNT(TC.USER_ID) AS TRUSTED_CONTACTS_CNT FROM CTE LEFT JOIN CONTACTS AS TC ON TC.USER_ID = CTE.CUSTOMER_ID AND TC.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY CUSTOMER_ID, CUSTOMER_NAME, EMAIL) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES INNER JOIN CTE2 ON CUSTOMER_ID = USER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(30, '78', None, 2, 1)
(31, '78', None, 2, 1)
*/