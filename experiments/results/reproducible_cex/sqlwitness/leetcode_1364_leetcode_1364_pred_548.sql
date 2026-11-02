-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (2, 'default2', NULL), (-1, 'default2', NULL), (0, 'default1', 'default1'), (2, 'default1', 'default2'), (-1, 'default1', NULL), (1, 'default1', 'default1'), (0, 'default2', 'default1');
INSERT INTO customers (customer_id, customer_name, email) VALUES (1, NULL, NULL), (0, 'default1', 'default2'), (-1, 'default1', 'default1'), (2, NULL, 'default2'), (3, NULL, 'default2'), (4, 'default2', NULL), (5, 'default1', NULL);
INSERT INTO invoices (invoice_id, user_id, price) VALUES (2, 2, NULL), (-1, NULL, 2), (0, 5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 2, None, None)
(0, 'default1', 1, 0, 0)
(2, None, None, 1, 2)
*/

-- Prediction Query
SELECT INVOICE_ID, CUSTOMER_NAME, ROUND(PRICE, 0) AS PRICE, COUNT(DISTINCT CONTACT_EMAIL) AS CONTACTS_CNT, SUM(IIF(CONTACT_EMAIL IN (SELECT DISTINCT EMAIL FROM CUSTOMERS), 1, 0)) AS TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN CUSTOMERS ON USER_ID = CUSTOMER_ID LEFT JOIN CONTACTS USING (USER_ID) GROUP BY INVOICE_ID ORDER BY 1, INVOICE_ID NULLS LAST, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, None, 2.0, 0, 0)
(0, 'default1', 1.0, 0, 0)
(2, None, None, 2, 2)
*/