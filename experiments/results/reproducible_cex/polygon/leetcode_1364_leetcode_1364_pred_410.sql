-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, NULL, '39');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (72, '38', '39');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (72, '39', '65');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (61, NULL, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (30, 72, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(30, '38', 1, 1, 1)
(61, None, None, None, None)
*/

-- Prediction Query
WITH TEMP AS (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME, COUNT(B.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN NOT C.EMAIL IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID LEFT JOIN CUSTOMERS AS C ON B.CONTACT_EMAIL = C.EMAIL GROUP BY 1) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN TEMP AS B ON A.USER_ID = B.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(30, '38', 1, 2, 2)
(61, None, None, None, None)
*/