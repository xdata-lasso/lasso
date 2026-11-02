-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (71, '36', '37');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (69, '38', '39');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (69, '29', '38');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (68, 69, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (70, 71, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(68, '38', None, 1, 0)
(70, '36', None, 0, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COALESCE(ABC.CT, 0) AS CONTACTS_CNT, COALESCE(ABC.TCT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN (SELECT USER_ID, COUNT(CONTACT_NAME) AS CT, SUM(TRUST) AS TCT FROM (SELECT USER_ID, (CONTACT_NAME), CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUST FROM CUSTOMERS AS C INNER JOIN CONTACTS AS CT ON C.CUSTOMER_ID = CT.USER_ID) AS A GROUP BY 1) AS ABC ON I.USER_ID = ABC.USER_ID INNER JOIN CUSTOMERS AS C1 ON C1.CUSTOMER_ID = I.USER_ID ORDER BY 1, I.invoice_id NULLS LAST, C1.customer_id NULLS LAST;

/*
Prediction Result:
(68, '38', None, 1, 1)
(70, '36', None, 0, 0)
*/