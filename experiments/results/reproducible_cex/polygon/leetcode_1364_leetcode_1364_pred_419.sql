-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (27, '34', '35');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (26, '38', '39');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (27, '39', '36');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (27, '35', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (59, 27, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (60, 27, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(59, '34', 1, 1, 2)
(60, '34', 2, 1, 2)
*/

-- Prediction Query
SELECT C.INVOICE_ID, A.CUSTOMER_NAME, C.PRICE, COUNT(B.USER_ID) AS CONTACTS_CNT, COUNT(D.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS C JOIN CUSTOMERS AS A ON A.CUSTOMER_ID = C.USER_ID LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID LEFT JOIN CUSTOMERS AS D ON B.CONTACT_EMAIL = D.EMAIL GROUP BY C.INVOICE_ID ORDER BY C.INVOICE_ID, A.CUSTOMER_NAME NULLS LAST, C.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(59, '34', 1, 2, 2)
(60, '34', 2, 2, 2)
*/