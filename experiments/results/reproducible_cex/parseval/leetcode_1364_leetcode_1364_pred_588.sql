-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_a20a21', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'a_s_a20a21', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_790747', 'b_s_2bada7');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'b_s_790747', 'b_s_2bada7');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_a38fb5', 'b_s_84e136');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'a_s_a20a21', 1, 0, 0)
(0, 'a_s_a20a21', 1, 0, 0)
(1, 'a_s_a20a21', 1, 3, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT CO.*, IIF(COUNT(CU.EMAIL) > 0, 1, 0) AS IS_TRUSTED FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS CU ON CO.CONTACT_EMAIL = CU.EMAIL GROUP BY CO.USER_ID, CO.CONTACT_NAME, CO.CONTACT_EMAIL) SELECT I.INVOICE_ID, CU.CUSTOMER_NAME, I.PRICE, COUNT(CTE.CONTACT_EMAIL) AS CONTACTS_CNT, COALESCE(SUM(CTE.IS_TRUSTED), 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = I.USER_ID LEFT JOIN CTE ON CTE.USER_ID = CU.CUSTOMER_ID GROUP BY I.INVOICE_ID, CU.CUSTOMER_NAME, I.PRICE ORDER BY I.INVOICE_ID, CU.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'a_s_a20a21', 1, 0, 0)
(0, 'a_s_a20a21', 1, 0, 0)
(1, 'a_s_a20a21', 1, 4, 0)
*/