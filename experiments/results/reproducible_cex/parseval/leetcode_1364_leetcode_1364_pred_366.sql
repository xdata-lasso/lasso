-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_117725', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'a_s_117725', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_a5b8d9', 'b_s_3428cb');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'b_s_a5b8d9', 'b_s_3428cb');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_dfc99d', 'b_s_1b1293');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'a_s_117725', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'a_s_117725', 1, 3, 0)
*/

-- Prediction Query
SELECT C.INVOICE_ID, D.CUSTOMER_NAME, C.PRICE, C.CONTACTS_CNT, C.TRUSTED_CONTACTS_CNT FROM (SELECT A.INVOICE_ID, A.PRICE, COALESCE(A.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(B.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT, A.USER_ID FROM (SELECT I.INVOICE_ID, I.USER_ID, I.PRICE, COALESCE(COUNT(CO.USER_ID), 0) AS CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CONTACTS AS CO ON CO.USER_ID = I.USER_ID GROUP BY I.INVOICE_ID ORDER BY I.INVOICE_ID, I.USER_ID NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST) AS A LEFT JOIN (SELECT USER_ID, SUM(CASE WHEN CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CONTACTS GROUP BY USER_ID) AS B ON A.USER_ID = B.USER_ID ORDER BY INVOICE_ID, A.INVOICE_ID NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST, A.USER_ID NULLS LAST) AS C JOIN CUSTOMERS AS D ON C.USER_ID = D.CUSTOMER_ID ORDER BY INVOICE_ID, D.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'a_s_117725', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'a_s_117725', 1, 4, 0)
*/