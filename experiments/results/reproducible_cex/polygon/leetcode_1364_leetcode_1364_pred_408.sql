-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (60, '68', '37');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '40', '41');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '30', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (60, '41', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (66, 60, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (67, 60, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(66, '68', 1, 0, 1)
(67, '68', None, 0, 1)
*/

-- Prediction Query
WITH CC AS (SELECT USER_ID, COUNT(*) AS NUMBER FROM CONTACTS GROUP BY USER_ID), TC AS (SELECT USER_ID, SUM(CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TCO FROM CONTACTS GROUP BY USER_ID), TEMP AS (SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, A.USER_ID FROM INVOICES AS A INNER JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID) SELECT A.INVOICE_ID, A.CUSTOMER_NAME, A.PRICE, CASE WHEN B.NUMBER IS NULL THEN 0 ELSE B.NUMBER END AS CONTACTS_CNT, CASE WHEN C.TCO IS NULL THEN 0 ELSE C.TCO END AS TRUSTED_CONTACTS_CNT FROM TEMP AS A LEFT JOIN CC AS B ON A.USER_ID = B.USER_ID LEFT JOIN TC AS C ON A.USER_ID = C.USER_ID ORDER BY INVOICE_ID, A.INVOICE_ID NULLS LAST, A.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(66, '68', 1, 1, 0)
(67, '68', None, 1, 0)
*/