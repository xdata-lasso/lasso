-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (34, '43', '44');
INSERT INTO "Customers" ("customer_id", "customer_name", "email") VALUES (33, NULL, '48');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (34, '44', '45');
INSERT INTO "Contacts" ("user_id", "contact_email", "contact_name") VALUES (34, '48', '46');
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (35, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(35, None, None, None, None)
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, COALESCE(COUNT(B.CONTACT_EMAIL), 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID WHERE B.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY 1) SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COUNT(C.CONTACT_EMAIL) AS CONTACTS_CNT, COALESCE(D.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN CONTACTS AS C ON B.CUSTOMER_ID = C.USER_ID LEFT JOIN CTE AS D ON B.CUSTOMER_ID = D.CUSTOMER_ID GROUP BY 1, 2 ORDER BY INVOICE_ID, A.INVOICE_ID NULLS LAST, B.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(35, None, None, 0, 0)
*/