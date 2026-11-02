-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (1, 'Alice', 'dup@test.com');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (2, 'Bob', 'dup@test.com');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'dup@test.com', 'ContactBob');
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
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COUNT(DISTINCT CC.CONTACT_EMAIL) AS CONTACTS_CNT, SUM(CASE WHEN C2.CUSTOMER_ID IS NULL THEN 0 ELSE 1 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS AS CC ON C.CUSTOMER_ID = CC.USER_ID LEFT JOIN CUSTOMERS AS C2 ON CC.CONTACT_EMAIL = C2.EMAIL GROUP BY 1, 2, 3 ORDER BY INVOICE_ID, I.INVOICE_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 2)
*/