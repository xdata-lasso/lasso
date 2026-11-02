-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (27, NULL, '59');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (26, '35', '36');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (27, '36', '35');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (27, '59', '34');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (56, 27, 2);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (57, 27, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(56, None, 2, 2, 2)
(57, None, 1, 2, 2)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COUNT(DISTINCT CO.CONTACT_EMAIL) AS CONTACTS_CNT, COUNT(DISTINCT C2.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = I.USER_ID LEFT JOIN CONTACTS AS CO ON C.CUSTOMER_ID = CO.USER_ID LEFT JOIN CUSTOMERS AS C2 ON CO.CONTACT_NAME = C2.CUSTOMER_NAME AND CO.CONTACT_EMAIL = C2.EMAIL GROUP BY 1, 2, 3 ORDER BY 1, I.INVOICE_ID NULLS LAST, C.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(56, None, 2, 2, 1)
(57, None, 1, 2, 1)
*/