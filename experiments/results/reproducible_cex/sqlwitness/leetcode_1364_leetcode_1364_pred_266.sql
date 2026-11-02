-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (0, 'default1', 'default2'), (2, 'default2', NULL), (0, 'default2', NULL), (1, 'default2', 'default2');
INSERT INTO customers (customer_id, customer_name, email) VALUES (-1, 'default1', 'default2'), (1, 'default2', NULL), (0, NULL, 'default2'), (2, NULL, 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (2, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(2, None, 1, 0, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT INVOICE_ID, CUSTOMER_NAME, CUSTOMER_ID, PRICE, CONTACT_EMAIL FROM INVOICES INNER JOIN CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN CONTACTS ON CUSTOMERS.CUSTOMER_ID = CONTACTS.USER_ID) SELECT A.INVOICE_ID, A.CUSTOMER_NAME, A.PRICE, COALESCE(COUNT(CONTACT_EMAIL), 0) AS CONTACTS_CNT, COUNT(B.CUSTOMER_ID) AS TRUSTED_CONTACTS_CNT FROM CTE AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_EMAIL = B.EMAIL GROUP BY 1, A.CUSTOMER_ID ORDER BY 1, A.INVOICE_ID NULLS LAST, A.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(2, None, 1, 2, 2)
*/