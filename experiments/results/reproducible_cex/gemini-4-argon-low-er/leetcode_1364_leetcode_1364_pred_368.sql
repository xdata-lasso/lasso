-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'alice@example.com', 'SameName');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'other@example.com', 'SameName');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 2, 1)
*/

-- Prediction Query
WITH BASELINE AS (SELECT I.INVOICE_ID, CUS.CUSTOMER_NAME, CUS.CUSTOMER_ID, I.PRICE FROM INVOICES AS I INNER JOIN CUSTOMERS AS CUS ON I.USER_ID = CUS.CUSTOMER_ID), CONTACTS_BASELINE AS (SELECT USER_ID, COUNT(DISTINCT CONTACT_NAME) AS NUM_CONTACT FROM CONTACTS GROUP BY USER_ID), TRUSTED_CONTACTS_BASELINE AS (SELECT USER_ID, COUNT(DISTINCT CONTACT_NAME) AS TRUSTED_NUM_CONTACT FROM CONTACTS WHERE CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY USER_ID) SELECT B.INVOICE_ID, B.CUSTOMER_NAME, B.PRICE, COALESCE(CB.NUM_CONTACT, 0) AS CONTACTS_CNT, COALESCE(TCB.TRUSTED_NUM_CONTACT, 0) AS TRUSTED_CONTACTS_CNT FROM BASELINE AS B LEFT JOIN CONTACTS_BASELINE AS CB ON B.CUSTOMER_ID = CB.USER_ID LEFT JOIN TRUSTED_CONTACTS_BASELINE AS TCB ON CB.USER_ID = TCB.USER_ID ORDER BY INVOICE_ID, B.INVOICE_ID NULLS LAST, B.CUSTOMER_NAME NULLS LAST, B.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 100, 1, 1)
*/