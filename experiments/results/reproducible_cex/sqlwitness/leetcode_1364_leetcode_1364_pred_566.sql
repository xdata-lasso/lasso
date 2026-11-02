-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name, email) VALUES (-1, 'default1', 'default2');
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
SELECT I.INVOICE_ID AS INVOICE_ID, C.CUSTOMER_NAME AS CUSTOMER_NAME, I.PRICE AS PRICE, COALESCE(S.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(S.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, COUNT(*) AS CONTACTS_CNT, SUM(TRUSTED_CONTACT) AS TRUSTED_CONTACTS_CNT FROM (SELECT CONT.USER_ID AS USER_ID, CONT.CONTACT_EMAIL AS CONTACT_EMAIL, NOT CUST.CUSTOMER_ID IS NULL AS TRUSTED_CONTACT FROM CONTACTS AS CONT LEFT JOIN CUSTOMERS AS CUST ON CONT.CONTACT_EMAIL = CUST.EMAIL) AS T GROUP BY USER_ID) AS S ON I.USER_ID = S.USER_ID ORDER BY INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
*/