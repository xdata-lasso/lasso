-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_cf53db', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'a_s_cf53db', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_904da8', 'b_s_9a2e30');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'b_s_904da8', 'b_s_9a2e30');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_474d73', 'b_s_7efb63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', 'con_54a98e');

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
(-1, 'a_s_cf53db', 1, 0, 0)
(0, 'a_s_cf53db', 1, 0, 0)
(1, 'a_s_cf53db', 1, 4, 0)
*/

-- Prediction Query
SELECT INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, A.CONTACTS_CNT, COALESCE(B.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_NAME, COUNT(USER_ID) AS CONTACTS_CNT FROM CUSTOMERS AS CU LEFT JOIN CONTACTS AS CO ON CU.CUSTOMER_ID = CO.USER_ID GROUP BY CUSTOMER_NAME) AS A ON C.CUSTOMER_NAME = A.CUSTOMER_NAME LEFT JOIN (SELECT CUSTOMER_NAME, COUNT(*) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS CU LEFT JOIN CONTACTS AS CO ON CU.CUSTOMER_ID = CO.USER_ID WHERE CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY CUSTOMER_NAME) AS B ON A.CUSTOMER_NAME = B.CUSTOMER_NAME ORDER BY INVOICE_ID ASC, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'a_s_cf53db', 1, 4, 0)
(0, 'a_s_cf53db', 1, 4, 0)
(1, 'a_s_cf53db', 1, 4, 0)
*/