-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Invoices" ("invoice_id", "user_id", "price") VALUES (37, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(37, None, None, None, None)
*/

-- Prediction Query
WITH ALLCONTACTS AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID), TRUSTEDCONTACTS AS (SELECT C.USER_ID, COALESCE(COUNT(CUS.CUSTOMER_ID), 0) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C LEFT JOIN CUSTOMERS AS CUS ON C.CONTACT_NAME = CUS.CUSTOMER_NAME GROUP BY C.USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(AC.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TC.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN ALLCONTACTS AS AC ON AC.USER_ID = I.USER_ID LEFT JOIN TRUSTEDCONTACTS AS TC ON TC.USER_ID = I.USER_ID ORDER BY 1 ASC, I.invoice_id NULLS LAST, C.customer_id NULLS LAST;

/*
Prediction Result:
*/