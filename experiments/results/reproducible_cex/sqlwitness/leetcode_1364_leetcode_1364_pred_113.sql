-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (-1, NULL, 'default1');
INSERT INTO invoices (invoice_id, user_id, price) VALUES (2, -1, NULL), (0, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(0, None, 1, None, None)
(2, None, None, 0, 0)
*/

-- Prediction Query
SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COALESCE(C.CONTACT_CNT, 0) AS CONTACTS_CNT, COALESCE(D.TRUSTED_CONTACT_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A INNER JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, COUNT(*) AS CONTACT_CNT FROM CONTACTS GROUP BY 1) AS C ON A.USER_ID = C.USER_ID LEFT JOIN (SELECT USER_ID, COUNT(*) AS TRUSTED_CONTACT_CNT FROM CONTACTS AS E INNER JOIN CUSTOMERS AS F ON E.CONTACT_NAME = F.CUSTOMER_NAME GROUP BY 1) AS D ON A.USER_ID = D.USER_ID ORDER BY 1, A.invoice_id NULLS LAST, B.customer_id NULLS LAST;

/*
Prediction Result:
(2, None, None, 0, 0)
*/