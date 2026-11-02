-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (31, '56', '42');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (31, '30', '40');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (31, '42', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (55, 31, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (32, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(32, None, 1, None, None)
(55, '56', 1, 1, 1)
*/

-- Prediction Query
SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COUNT(DISTINCT CT.CONTACT_EMAIL) AS CONTACTS_CNT, COUNT(DISTINCT CT2.CONTACT_EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS AS CT ON I.USER_ID = CT.USER_ID LEFT JOIN (SELECT DISTINCT CONTACT_EMAIL FROM CONTACTS WHERE CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS)) AS CT2 ON CT.CONTACT_EMAIL = CT2.CONTACT_EMAIL GROUP BY 1, 2, 3 ORDER BY 1, INVOICE_ID NULLS LAST, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(32, None, 1, 0, 0)
(55, '56', 1, 2, 1)
*/