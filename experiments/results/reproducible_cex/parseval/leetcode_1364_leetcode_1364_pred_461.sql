-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_79320d', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, '"', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'con_630bad', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'con_630bad', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_630bad');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483641, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483648, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', 'con_177999');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483631, 'con_de12a6', 'con_177999');

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
(-1, 'cus_8d1b6b', 1, 1, 0)
(0, 'cus_8d1b6b', 1, 1, 0)
(1, 'cus_79320d', 1, 1, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, CUST.CUSTOMER_NAME, INVOICE.PRICE, COUNT(C.USER_ID) AS CONTACTS_CNT, COALESCE(SUM(C.TRUSTED), 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS INVOICE JOIN CUSTOMERS AS CUST ON INVOICE.USER_ID = CUST.CUSTOMER_ID LEFT JOIN (SELECT USER_ID, CONTACT_NAME, CASE WHEN CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) THEN 1 ELSE 0 END AS TRUSTED FROM CONTACTS) AS C ON CUST.CUSTOMER_ID = C.USER_ID GROUP BY 1, 2, 3 ORDER BY 1, INVOICE_ID NULLS LAST, CUST.CUSTOMER_NAME NULLS LAST, INVOICE.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 1, 1)
(0, 'cus_8d1b6b', 1, 1, 1)
(1, 'cus_79320d', 1, 1, 0)
*/