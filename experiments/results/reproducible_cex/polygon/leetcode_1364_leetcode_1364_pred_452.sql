-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (83, NULL, '47');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (39, NULL, '51');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (83, '38', '48');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (39, '37', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (68, 39, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(68, None, 1, 0, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN (SELECT T1.CUSTOMER_ID, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM (SELECT CUSTOMER_ID, COUNT(CON.CONTACT_EMAIL) AS CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS CON ON C.CUSTOMER_ID = CON.USER_ID GROUP BY 1) AS T1 JOIN (SELECT CUSTOMER_ID, COUNT(CON2.CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C LEFT JOIN CONTACTS AS CON2 ON C.CUSTOMER_ID = CON2.USER_ID AND CON2.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY 1) AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID) AS X ON I.USER_ID = X.CUSTOMER_ID ORDER BY INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(68, None, 1, 1, 0)
*/