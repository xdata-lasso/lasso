-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (1, NULL, NULL);
INSERT INTO invoices (invoice_id, user_id, price) VALUES (-1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, None, 1, None, None)
*/

-- Prediction Query
SELECT INVOICE_ID, A.CUSTOMER_NAME, PRICE, CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM (SELECT INVOICE_ID, CUSTOMER_ID, CUSTOMER_NAME, PRICE, COUNT(CONTACT_EMAIL) AS CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CUS ON I.USER_ID = CUS.CUSTOMER_ID LEFT JOIN CONTACTS AS CON ON CUS.CUSTOMER_ID = CON.USER_ID GROUP BY INVOICE_ID ORDER BY INVOICE_ID, CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST) AS A LEFT JOIN (SELECT USER_ID, CUSTOMER_NAME, COUNT(EMAIL) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CON LEFT JOIN CUSTOMERS AS CUS ON CON.CONTACT_EMAIL = CUS.EMAIL GROUP BY USER_ID) AS B ON A.CUSTOMER_ID = B.USER_ID;

/*
Prediction Result:
(-1, None, 1, 0, 0)
*/