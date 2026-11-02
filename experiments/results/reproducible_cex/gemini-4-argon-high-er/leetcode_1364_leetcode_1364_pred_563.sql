-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, NULL, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, None, 10, None, None)
*/

-- Prediction Query
WITH TC AS (SELECT USER_ID, COUNT(1) AS TRUSTED_CONTACTS_CNT FROM CONTACTS WHERE EXISTS(SELECT 1 FROM CUSTOMERS WHERE CUSTOMERS.EMAIL = CONTACTS.CONTACT_EMAIL) GROUP BY USER_ID), C_CNT AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT OUTER JOIN CUSTOMERS AS CUST ON I.USER_ID = CUST.CUSTOMER_ID LEFT OUTER JOIN C_CNT ON I.USER_ID = C_CNT.USER_ID LEFT OUTER JOIN TC ON I.USER_ID = TC.USER_ID ORDER BY 1, I.invoice_id NULLS LAST, CUST.customer_id NULLS LAST;

/*
Prediction Result:
(1, None, 10, 0, 0)
*/