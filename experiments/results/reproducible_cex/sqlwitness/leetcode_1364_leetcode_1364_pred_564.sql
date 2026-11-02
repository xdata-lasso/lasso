-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (1, 'default2', NULL);
INSERT INTO customers (customer_id, customer_name, email) VALUES (2, NULL, 'default1'), (0, 'default1', 'default1'), (1, 'default2', 'default1'), (-1, 'default2', NULL), (3, 'default2', NULL), (4, NULL, 'default1'), (5, 'default2', NULL), (6, NULL, 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (0, 4, 1), (2, 0, 2), (-1, -1, 2), (1, 1, 1), (3, 5, NULL), (4, 1, 1), (5, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'default2', 2, 0, 0)
(0, None, 1, 0, 0)
(1, 'default2', 1, 0, 0)
(2, 'default1', 2, 0, 0)
(3, 'default2', None, 0, 0)
(4, 'default2', 1, 0, 0)
(5, 'default2', 1, 0, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES JOIN (SELECT CUSTOMERS.CUSTOMER_ID AS USER_ID, CUSTOMERS.CUSTOMER_NAME AS CUSTOMER_NAME, COUNT(TRUSTEDCUSTOMERS.TRUSTED_STATE) AS CONTACTS_CNT, COUNT(IIF(TRUSTEDCUSTOMERS.TRUSTED_STATE = TRUE, TRUE, NULL)) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS LEFT JOIN (SELECT CONTACTS.USER_ID AS CUSTOMER_ID, IIF(CUSTOMERS.CUSTOMER_ID IS NULL, FALSE, TRUE) AS TRUSTED_STATE FROM CONTACTS LEFT JOIN CUSTOMERS ON (CONTACTS.CONTACT_NAME = CUSTOMERS.CUSTOMER_NAME AND CONTACTS.CONTACT_EMAIL = CUSTOMERS.EMAIL)) AS TRUSTEDCUSTOMERS USING (CUSTOMER_ID) GROUP BY CUSTOMERS.CUSTOMER_ID) AS COUNTEDCUSTOMERS USING (USER_ID) ORDER BY INVOICE_ID ASC;

/*
Prediction Result:
(-1, 'default2', 2, 0, 0)
(0, None, 1, 0, 0)
(1, 'default2', 1, 1, 0)
(2, 'default1', 2, 0, 0)
(3, 'default2', None, 0, 0)
(4, 'default2', 1, 1, 0)
(5, 'default2', 1, 0, 0)
*/