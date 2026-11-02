-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'alice@example.com', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 100);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (2, NULL, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 0, 1)
(2, None, 200, None, None)
*/

-- Prediction Query
SELECT DISTINCT SUB1.INVOICE_ID, SUB1.CUSTOMER_NAME, SUB1.PRICE, SUB1.CONTACTS_CNT, COALESCE(SUB2.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM (SELECT INVOICE_ID, CUSTOMER_ID, CUSTOMER_NAME, PRICE, COUNT(CON.USER_ID) AS CONTACTS_CNT, EMAIL FROM INVOICES AS A LEFT JOIN CUSTOMERS AS CU ON A.USER_ID = CU.CUSTOMER_ID LEFT JOIN CONTACTS AS CON ON CU.CUSTOMER_ID = CON.USER_ID GROUP BY 1, 2, 3 ORDER BY 1, INVOICE_ID NULLS LAST, CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, EMAIL NULLS LAST) AS SUB1 LEFT JOIN (SELECT USER_ID, COUNT(CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS WHERE CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY 1) AS SUB2 ON SUB1.CUSTOMER_ID = SUB2.USER_ID ORDER BY 1, SUB1.INVOICE_ID NULLS LAST, SUB1.CUSTOMER_NAME NULLS LAST, SUB1.PRICE NULLS LAST, SUB1.CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
(2, None, 200, 0, 0)
*/