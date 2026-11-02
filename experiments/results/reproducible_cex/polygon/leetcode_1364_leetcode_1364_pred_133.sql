-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (57, NULL, NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (28, NULL, '37');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (28, '59', '60');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (28, '29', '60');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (58, 57, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (61, 28, 7915);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(58, None, None, 0, 0)
(61, None, 7915, 2, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, MAX(C.CUSTOMER_NAME) AS CUSTOMER_NAME, MAX(I.PRICE) AS PRICE, COUNT(DISTINCT A.CONTACT_NAME) AS CONTACTS_CNT, COALESCE(COUNT(CASE WHEN A.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN C.CUSTOMER_NAME END), 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS AS A ON C.CUSTOMER_ID = A.USER_ID GROUP BY 1 ORDER BY 1, I.INVOICE_ID NULLS LAST, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(58, None, None, 0, 0)
(61, None, 7915, 1, 0)
*/