-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (0, 'default1', 'default1'), (0, 'default2', NULL), (2, 'default1', NULL);
INSERT INTO customers (customer_id, customer_name, email) VALUES (0, 'default2', NULL), (1, NULL, 'default2'), (2, 'default1', 'default1'), (-1, 'default2', 'default1'), (3, 'default2', 'default1'), (4, 'default2', 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (2, 3, 2), (-1, NULL, 1), (1, 3, 2), (0, -1, NULL), (3, 0, NULL), (4, 4, 2), (5, NULL, NULL), (6, 4, 1), (7, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 1, None, None)
(0, 'default2', None, 0, 0)
(1, 'default2', 2, 0, 0)
(2, 'default2', 2, 0, 0)
(3, 'default2', None, 1, 2)
(4, 'default2', 2, 0, 0)
(5, None, None, None, None)
(6, 'default2', 1, 0, 0)
(7, 'default2', None, 0, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, COUNT(CONTACT_NAME) AS CONTACTS_CNT, SUM(IIF(CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS), 1, 0)) AS TRUSTED_CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(CTE.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(CTE.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CTE ON I.USER_ID = CTE.USER_ID ORDER BY 1, I.invoice_id NULLS LAST, C.customer_id NULLS LAST;

/*
Prediction Result:
(0, 'default2', None, 0, 0)
(1, 'default2', 2, 0, 0)
(2, 'default2', 2, 0, 0)
(3, 'default2', None, 1, 2)
(4, 'default2', 2, 0, 0)
(6, 'default2', 1, 0, 0)
(7, 'default2', None, 0, 0)
*/