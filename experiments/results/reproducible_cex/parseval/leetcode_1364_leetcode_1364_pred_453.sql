-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_1a7da9', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'a_s_1a7da9', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_e810d9', 'b_s_a018e4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'b_s_e810d9', 'b_s_a018e4');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_f31265', 'b_s_29c3c1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'a_s_1a7da9', 1, 0, 0)
(0, 'a_s_1a7da9', 1, 0, 0)
(1, 'a_s_1a7da9', 1, 3, 0)
*/

-- Prediction Query
WITH A1 AS (SELECT I.INVOICE_ID, CU.CUSTOMER_NAME, I.PRICE FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = I.USER_ID), A2 AS (SELECT CU.CUSTOMER_NAME, CU.CUSTOMER_ID, COALESCE(COUNT(CO.USER_ID), 0) AS CONTACTS_CNT FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = CO.USER_ID GROUP BY CO.USER_ID), A3 AS (SELECT CU.CUSTOMER_NAME, CU.CUSTOMER_ID, COALESCE(COUNT(CO.USER_ID), 0) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CO LEFT JOIN CUSTOMERS AS CU ON CU.CUSTOMER_ID = CO.USER_ID WHERE CO.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY CO.USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM A1 LEFT JOIN A2 USING (CUSTOMER_NAME) LEFT JOIN A3 USING (CUSTOMER_NAME) ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'a_s_1a7da9', 1, 4, 0)
(0, 'a_s_1a7da9', 1, 4, 0)
(1, 'a_s_1a7da9', 1, 4, 0)
*/