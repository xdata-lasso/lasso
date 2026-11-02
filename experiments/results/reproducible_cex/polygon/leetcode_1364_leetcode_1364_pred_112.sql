-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (30, NULL, NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (30, '32', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (30, '31', '42');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (51, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (59, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(51, None, 1, None, None)
(59, None, 1, None, None)
*/

-- Prediction Query
SELECT A.INVOICE_ID, A.CUSTOMER_NAME, A.PRICE, (CASE WHEN A.CONTACTS_CNT IS NULL THEN 0 ELSE A.CONTACTS_CNT END) AS CONTACTS_CNT, (CASE WHEN B.TRUSTED_CONTACTS_CNT IS NULL THEN 0 ELSE B.TRUSTED_CONTACTS_CNT END) AS TRUSTED_CONTACTS_CNT FROM (SELECT INVOICE_ID, CUSTOMER_ID, CUSTOMER_NAME, PRICE, COUNT(DISTINCT CONTACTS.CONTACT_EMAIL) AS CONTACTS_CNT FROM INVOICES INNER JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN CONTACTS ON CUSTOMERS.CUSTOMER_ID = CONTACTS.USER_ID GROUP BY INVOICE_ID, CUSTOMER_ID, CUSTOMER_NAME, PRICE) AS A LEFT JOIN (SELECT INVOICE_ID, CUSTOMER_ID, CUSTOMER_NAME, PRICE, COUNT(DISTINCT CONTACTS.CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES INNER JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN CONTACTS ON CUSTOMERS.CUSTOMER_ID = CONTACTS.USER_ID WHERE CONTACTS.CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS) GROUP BY INVOICE_ID, CUSTOMER_ID, CUSTOMER_NAME, PRICE) AS B ON A.INVOICE_ID = B.INVOICE_ID AND A.CUSTOMER_ID = B.CUSTOMER_ID ORDER BY A.INVOICE_ID, A.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
*/