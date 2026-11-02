-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (56, NULL, NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (24, '34', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (56, '26', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (56, '25', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (27, 24, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (55, 56, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(27, '34', None, 0, 0)
(55, None, 1, 0, 0)
*/

-- Prediction Query
SELECT T1.INVOICE_ID, T2.CUSTOMER_NAME, T1.PRICE, COUNT(T3.USER_ID) AS CONTACTS_CNT, COALESCE(SUM(T3.TRUSTED), 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS T1 INNER JOIN CUSTOMERS AS T2 ON T1.USER_ID = T2.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, CONTACT_NAME, CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUSTED FROM CONTACTS) AS T3 ON T3.USER_ID = T2.CUSTOMER_ID GROUP BY T1.INVOICE_ID ORDER BY T1.INVOICE_ID, T2.CUSTOMER_NAME NULLS LAST, T1.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(27, '34', None, 0, 0)
(55, None, 1, 2, 0)
*/