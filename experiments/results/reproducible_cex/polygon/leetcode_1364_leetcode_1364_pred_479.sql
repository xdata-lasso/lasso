-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (39, NULL, '41');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (29, '37', '38');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (29, '27', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (28, 29, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(28, '37', None, 0, 0)
*/

-- Prediction Query
WITH CUSTOMER_CONTACTS AS (SELECT C2.USER_ID, COUNT(*) AS TOTAL, SUM(IIF(C.CUSTOMER_ID IS NULL, 0, 1)) AS TRUST FROM CONTACTS AS C2 LEFT JOIN CUSTOMERS AS C ON C.EMAIL = C2.CONTACT_EMAIL GROUP BY C2.USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(CC.TOTAL, 0) AS CONTACTS_CNT, COALESCE(CC.TRUST, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = I.USER_ID LEFT JOIN CUSTOMER_CONTACTS AS CC ON CC.USER_ID = I.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(28, '37', None, 1, 0)
*/