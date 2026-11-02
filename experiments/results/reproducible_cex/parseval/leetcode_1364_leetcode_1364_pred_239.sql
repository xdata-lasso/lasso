-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_eb4af2', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'a_s_eb4af2', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_d7c94f', 'b_s_74fd0c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'b_s_d7c94f', 'b_s_74fd0c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_a6a2bd', 'b_s_e95d7f');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483646, 'a_s_eb4af2', 1, 0, 0)
(-2147483645, 'a_s_eb4af2', 1, 0, 0)
(-2147483644, 'a_s_eb4af2', 1, 0, 0)
(0, 'a_s_eb4af2', 1, 0, 0)
(1, 'a_s_eb4af2', 1, 3, 0)
*/

-- Prediction Query
WITH CONTACTCNT AS (SELECT CUST.CUSTOMER_ID AS CUSTOMER_ID, COALESCE(COUNT(CONTACT.CONTACT_EMAIL), 0) AS CONTACTS_CNT FROM CUSTOMERS AS CUST LEFT JOIN CONTACTS AS CONTACT ON CUST.CUSTOMER_ID = CONTACT.USER_ID GROUP BY CUSTOMER_ID), TRUSTCONTACTCNT AS (SELECT CUST.CUSTOMER_ID AS CUSTOMER_ID, COALESCE(COUNT(CONTACT.CONTACT_EMAIL), 0) AS CONTACTS_CNT FROM CUSTOMERS AS CUST LEFT JOIN CONTACTS AS CONTACT ON CUST.CUSTOMER_ID = CONTACT.USER_ID AND CONTACT.CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) GROUP BY CUSTOMER_ID) SELECT INVO.INVOICE_ID AS INVOICE_ID, CUST.CUSTOMER_NAME AS CUSTOMER_NAME, COALESCE(SUM(INVO.PRICE), 0) AS PRICE, SUM(CONTACTCNT.CONTACTS_CNT) AS CONTACTS_CNT, SUM(TRUSTCONTACTCNT.CONTACTS_CNT) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CUST JOIN INVOICES AS INVO ON INVO.USER_ID = CUST.CUSTOMER_ID JOIN CONTACTCNT AS CONTACTCNT ON CONTACTCNT.CUSTOMER_ID = CUST.CUSTOMER_ID JOIN TRUSTCONTACTCNT AS TRUSTCONTACTCNT ON TRUSTCONTACTCNT.CUSTOMER_ID = CUST.CUSTOMER_ID GROUP BY CUST.CUSTOMER_ID, INVOICE_ID ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-2147483646, 'a_s_eb4af2', 1, 0, 0)
(-2147483645, 'a_s_eb4af2', 1, 0, 0)
(-2147483644, 'a_s_eb4af2', 1, 0, 0)
(0, 'a_s_eb4af2', 1, 0, 0)
(1, 'a_s_eb4af2', 1, 4, 0)
*/