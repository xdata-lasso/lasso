-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (23, NULL, '33');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (56, NULL, '33');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (23, '33', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (23, '24', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (55, 56, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (25, 23, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(25, None, None, 0, 1)
(55, None, None, 0, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, CUSTOMERS.CUSTOMER_NAME, PRICE, COALESCE(COUNT(CONTACT_EMAIL), 0) AS CONTACTS_CNT, SUM(CASE WHEN NOT C.CUSTOMER_ID IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES INNER JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN CONTACTS ON CUSTOMERS.CUSTOMER_ID = CONTACTS.USER_ID LEFT JOIN CUSTOMERS AS C ON CONTACTS.CONTACT_EMAIL = C.EMAIL GROUP BY INVOICE_ID, CUSTOMERS.CUSTOMER_ID ORDER BY 1, INVOICE_ID NULLS LAST, CUSTOMERS.CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(25, None, None, 3, 2)
(55, None, None, 0, 0)
*/