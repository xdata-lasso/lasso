-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (30, '40', '41');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '44', '45');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (30, '45', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '31', '43');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (32, NULL, 1);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (75, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(32, None, 1, None, None)
(75, None, None, None, None)
*/

-- Prediction Query
WITH C AS (SELECT USER_ID, COUNT(*) AS CNT FROM CONTACTS GROUP BY 1), D AS (SELECT USER_ID, COUNT(*) AS CNT FROM CONTACTS WHERE CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY 1) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(C.CNT, 0) AS CONTACTS_CNT, COALESCE(D.CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN C ON B.CUSTOMER_ID = C.USER_ID LEFT JOIN D ON B.CUSTOMER_ID = D.USER_ID ORDER BY 1, A.invoice_id NULLS LAST, B.customer_id NULLS LAST;

/*
Prediction Result:
(32, None, 1, 0, 0)
(75, None, None, 0, 0)
*/