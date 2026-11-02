-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (2, 'Bob', 'bob@example.com');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'bob@example.com', 'WrongName');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 1, 1)
*/

-- Prediction Query
SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM (SELECT CTE1.INVOICE_ID, CTE1.CUSTOMER_ID, CTE1.CUSTOMER_NAME, CTE1.PRICE, CTE2.CONTACTS_CNT FROM (SELECT CU.CUSTOMER_ID, CU.CUSTOMER_NAME, COUNT(CO.USER_ID) AS CONTACTS_CNT FROM CUSTOMERS AS CU LEFT JOIN CONTACTS AS CO ON CU.CUSTOMER_ID = CO.USER_ID GROUP BY 1, 2) AS CTE2 LEFT JOIN (SELECT I.INVOICE_ID, CU.CUSTOMER_ID, CU.CUSTOMER_NAME, I.PRICE FROM CUSTOMERS AS CU LEFT JOIN INVOICES AS I ON CU.CUSTOMER_ID = I.USER_ID) AS CTE1 ON CTE1.CUSTOMER_ID = CTE2.CUSTOMER_ID) AS CTE3 LEFT JOIN (SELECT USER_ID, COUNT(CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY 1) AS CTE4 ON CTE3.CUSTOMER_ID = CTE4.USER_ID WHERE NOT INVOICE_ID IS NULL ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
*/