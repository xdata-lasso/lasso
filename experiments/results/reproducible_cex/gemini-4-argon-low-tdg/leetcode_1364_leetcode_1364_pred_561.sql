-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'NoInvoiceCust', 'noinv@example.com');
INSERT INTO Customers (customer_id, customer_name, email) VALUES (2, 'MultiInvoiceCust', 'multi@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'multi@example.com', 'MultiInvoiceCust');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (2, 'noinv@example.com', 'NoInvoiceCust');
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (5, 2, 100);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (2, 2, 100);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (9, NULL, 250);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(2, 'MultiInvoiceCust', 100, 1, 1)
(5, 'MultiInvoiceCust', 100, 1, 1)
(9, None, 250, None, None)
*/

-- Prediction Query
WITH COMBINED AS (SELECT C1.CUSTOMER_ID, C1.CUSTOMER_NAME, COUNT(C2.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN C2.CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS C1 LEFT JOIN CONTACTS AS C2 ON C1.CUSTOMER_ID = C2.USER_ID GROUP BY C1.CUSTOMER_ID, C1.CUSTOMER_NAME) SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COUNT(C2.CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN C2.CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C1 ON I.USER_ID = C1.CUSTOMER_ID LEFT JOIN CONTACTS AS C2 ON C1.CUSTOMER_ID = C2.USER_ID GROUP BY I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE ORDER BY INVOICE_ID, I.INVOICE_ID NULLS LAST, C1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(2, 'MultiInvoiceCust', 100, 1, 1)
(5, 'MultiInvoiceCust', 100, 1, 1)
*/