-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_5cd817', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'c_s_5cd817', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_2340e2', 'con_f63596');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_9829fe', 'con_cad989');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_8eca36', 'con_aa02f9');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_2340e2', 'con_f63596');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_9829fe', 'con_cad989');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_8eca36', 'con_aa02f9');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_2340e2', 'con_f63596');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_9829fe', 'con_cad989');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_8eca36', 'con_aa02f9');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', NULL);

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'c_s_5cd817', 1, 0, 0)
(0, 'c_s_5cd817', 1, 0, 0)
(1, 'c_s_5cd817', 1, 3, 0)
(2, 'c_s_5cd817', 1, 3, 0)
(3, 'c_s_5cd817', 1, 3, 0)
*/

-- Prediction Query
WITH T AS (SELECT *, COUNT(*) AS CNT, SUM(IIF(CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS), 1, 0)) AS TRUSTED_CNT FROM CONTACTS GROUP BY USER_ID) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(T.CNT, 0) AS CONTACTS_CNT, COALESCE(T.TRUSTED_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN T ON I.USER_ID = T.USER_ID LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'c_s_5cd817', 1, 1, 0)
(0, 'c_s_5cd817', 1, 1, 0)
(1, 'c_s_5cd817', 1, 3, 0)
(2, 'c_s_5cd817', 1, 3, 0)
(3, 'c_s_5cd817', 1, 3, 0)
*/