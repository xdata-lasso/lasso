-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO contacts (user_id, contact_email, contact_name) VALUES (1, 'default1', NULL);
INSERT INTO customers (customer_id, customer_name, email) VALUES (-1, 'default2', 'default2'), (2, 'default1', 'default1'), (1, NULL, 'default1'), (3, 'default2', 'default1'), (0, NULL, NULL);
INSERT INTO invoices (invoice_id, user_id, price) VALUES (1, 2, 3), (0, 3, 2), (-1, 1, NULL), (2, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, None, 0, 1)
(0, 'default2', 2, 0, 0)
(1, 'default1', 3, 0, 0)
(2, 'default1', None, 0, 0)
*/

-- Prediction Query
WITH TRUST AS (SELECT CO.*, CASE WHEN NOT CU.EMAIL IS NULL THEN 1 ELSE 0 END AS TRUST_IND FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS CU ON CO.CONTACT_EMAIL = CU.EMAIL), CTE AS (SELECT CU.CUSTOMER_ID, CU.CUSTOMER_NAME, COUNT(CONTACT_EMAIL) AS CONTACTS_CNT, COALESCE(SUM(T.TRUST_IND), 0) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CU LEFT JOIN TRUST AS T ON CU.CUSTOMER_ID = T.USER_ID GROUP BY 1, 2) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CTE ON I.USER_ID = CTE.CUSTOMER_ID ORDER BY INVOICE_ID;

/*
Prediction Result:
(-1, None, None, 3, 3)
(0, 'default2', 2, 0, 0)
(1, 'default1', 3, 0, 0)
(2, 'default1', None, 0, 0)
*/