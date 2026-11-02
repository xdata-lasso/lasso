-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_cdc9bc', 'b_s_303ad8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'm_s_06e5bc', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_340427', 'a_s_cdc9bc');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_1d74c7', 'a_s_cdc9bc');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-1, 'a_s_cdc9bc', 1, 2, 0)
(0, 'a_s_cdc9bc', 1, 2, 0)
(1, 'a_s_cdc9bc', 1, 2, 0)
(2, 'a_s_cdc9bc', 1, 2, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT * FROM CONTACTS AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_NAME = B.CUSTOMER_NAME) SELECT A.INVOICE_ID, M.CUSTOMER_NAME, A.PRICE, COALESCE(B.CNT, 0) AS CONTACTS_CNT, COALESCE(C.CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A LEFT JOIN CUSTOMERS AS M ON A.USER_ID = M.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, COUNT(*) AS CNT FROM CTE GROUP BY USER_ID) AS B ON A.USER_ID = B.USER_ID LEFT JOIN (SELECT USER_ID, COUNT(*) AS CNT FROM CTE WHERE NOT CUSTOMER_ID IS NULL GROUP BY USER_ID) AS C ON B.USER_ID = C.USER_ID ORDER BY INVOICE_ID, M.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483645, 'cus_8d1b6b', 1, 0, 0)
(-2147483644, 'cus_8d1b6b', 1, 0, 0)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-1, 'a_s_cdc9bc', 1, 2, 2)
(0, 'a_s_cdc9bc', 1, 2, 2)
(1, 'a_s_cdc9bc', 1, 2, 2)
(2, 'a_s_cdc9bc', 1, 2, 2)
*/