-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_name, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Contacts (user_id, contact_email, contact_name) VALUES (1, 'bob@example.com', NULL);
INSERT INTO Invoices (invoice_id, user_id, price) VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'Alice', 100, 0, 0)
*/

-- Prediction Query
WITH CONTACT_TB AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, COALESCE(COUNT(USER_ID), 0) AS CONTACTS_CNT FROM CUSTOMERS LEFT JOIN CONTACTS ON CUSTOMER_ID = USER_ID GROUP BY CUSTOMER_ID), TRUSTED_CONTACT_TB AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, COUNT(*) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS JOIN CONTACTS ON CUSTOMER_ID = USER_ID AND CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY CUSTOMER_ID), STATS_TB AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM CONTACT_TB AS C LEFT JOIN TRUSTED_CONTACT_TB AS T ON C.CUSTOMER_ID = T.CUSTOMER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN STATS_TB AS S ON I.USER_ID = S.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(1, 'Alice', 100, 1, 0)
*/