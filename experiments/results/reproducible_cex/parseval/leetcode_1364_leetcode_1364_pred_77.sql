-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_f34463', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'a_s_f34463', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_631171', 'b_s_22c67b');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'b_s_631171', 'b_s_22c67b');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_617f31', 'b_s_b23580');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', 'con_54a98e');

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
(-1, 'a_s_f34463', 1, 0, 0)
(0, 'a_s_f34463', 1, 0, 0)
(1, 'a_s_f34463', 1, 4, 0)
*/

-- Prediction Query
WITH CONTACT_STATS AS (SELECT X.USER_ID, COUNT(DISTINCT X.CONTACT_NAME) AS CONTACTS_CNT, COUNT(DISTINCT B.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS X LEFT JOIN CUSTOMERS AS B ON X.CONTACT_NAME = B.CUSTOMER_NAME GROUP BY 1) SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COALESCE(C.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(C.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN CONTACT_STATS AS C ON A.USER_ID = C.USER_ID ORDER BY 1, A.invoice_id NULLS LAST, B.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'a_s_f34463', 1, 0, 0)
(0, 'a_s_f34463', 1, 0, 0)
(1, 'a_s_f34463', 1, 3, 0)
*/