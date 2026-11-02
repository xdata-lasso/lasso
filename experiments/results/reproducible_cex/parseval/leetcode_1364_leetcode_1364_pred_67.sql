-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_1fd523', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'a_s_1fd523', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_de487b', 'b_s_4f033e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'b_s_de487b', 'b_s_4f033e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_7e07fa', 'b_s_54cdce');

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
(-1, 'a_s_1fd523', 1, 0, 0)
(0, 'a_s_1fd523', 1, 0, 0)
(1, 'a_s_1fd523', 1, 3, 0)
*/

-- Prediction Query
SELECT TMP.INVOICE_ID, CUSTOMERS.CUSTOMER_NAME, TMP.PRICE, TMP.CONTACTS_CNT, TMP.TRUSTED_CONTACTS_CNT FROM (SELECT INVOICE_ID, PRICE, USER_ID, COALESCE(COUNT(DISTINCT CONTACT_EMAIL), 0) AS CONTACTS_CNT, SUM(CASE WHEN CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES LEFT JOIN CONTACTS USING (USER_ID) GROUP BY INVOICE_ID) AS TMP INNER JOIN CUSTOMERS ON TMP.USER_ID = CUSTOMERS.CUSTOMER_ID ORDER BY INVOICE_ID, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'a_s_1fd523', 1, 0, 0)
(0, 'a_s_1fd523', 1, 0, 0)
(1, 'a_s_1fd523', 1, 4, 0)
*/