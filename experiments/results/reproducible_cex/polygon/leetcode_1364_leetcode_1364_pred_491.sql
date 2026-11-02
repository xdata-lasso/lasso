-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (73, NULL, '44');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (82, NULL, '47');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (73, '47', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (68, 82, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (69, 73, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(68, None, 1, 0, 0)
(69, None, None, 0, 1)
*/

-- Prediction Query
SELECT INVOICE_ID, A.CUSTOMER_NAME, A.PRICE, B.CONTACTS_CNT, B.TRUSTED_CONTACTS_CNT FROM (SELECT INVOICE_ID, C.CUSTOMER_NAME, C.CUSTOMER_ID, I.PRICE FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID) AS A LEFT JOIN (SELECT CUS.CUSTOMER_ID, COALESCE(COUNT(CON.CONTACT_NAME), 0) AS CONTACTS_CNT, SUM(CASE WHEN CONTACT_NAME IN (SELECT DISTINCT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CUS LEFT JOIN CONTACTS AS CON ON CUS.CUSTOMER_ID = CON.USER_ID GROUP BY CUS.CUSTOMER_ID) AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID ORDER BY INVOICE_ID, A.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, B.CONTACTS_CNT NULLS LAST, B.TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(68, None, 1, 0, 0)
(69, None, None, 0, 0)
*/