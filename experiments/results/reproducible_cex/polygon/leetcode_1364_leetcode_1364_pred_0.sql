-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (37, '45', NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (34, '49', '35');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (37, '36', NULL);
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (37, '35', NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (69, 37, NULL);
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (38, 37, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(38, '45', None, 0, 1)
(69, '45', None, 0, 1)
*/

-- Prediction Query
SELECT A.INVOICE_ID, A.CUSTOMER_NAME, A.PRICE, A.CONTACTS_CNT, COALESCE(B.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM (SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COUNT(CO.CONTACT_NAME) AS CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS AS CO ON I.USER_ID = CO.USER_ID GROUP BY I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE) AS A LEFT JOIN (SELECT I.INVOICE_ID, COUNT(C.CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CONTACTS AS C ON I.USER_ID = C.USER_ID WHERE C.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY I.INVOICE_ID) AS B ON A.INVOICE_ID = B.INVOICE_ID ORDER BY A.INVOICE_ID, A.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, A.CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(38, '45', None, 0, 0)
(69, '45', None, 0, 0)
*/