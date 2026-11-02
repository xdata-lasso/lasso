-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, NULL, '39');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (31, '70', '41');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (31, '41', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (31, '30', '40');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (71, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (68, 31, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(68, '70', None, 1, 1)
(71, None, 1, None, None)
*/

-- Prediction Query
WITH TRUSTED AS (SELECT COALESCE(COUNT(CONTACT_NAME), 0) AS TRUSTED_CONTACTS_CNT, USER_ID FROM CONTACTS WHERE CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COUNT(C.USER_ID) AS CONTACTS_CNT, COALESCE(T.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CONTACTS AS C ON C.USER_ID = I.USER_ID LEFT JOIN CUSTOMERS AS CU ON I.USER_ID = CU.CUSTOMER_ID LEFT JOIN TRUSTED AS T ON T.USER_ID = I.USER_ID GROUP BY INVOICE_ID, CUSTOMER_NAME, PRICE ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(68, '70', None, 2, 0)
(71, None, 1, 0, 0)
*/