-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'a_s_a8ca0a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'a_s_a8ca0a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_27c163', 'b_s_877337');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'b_s_27c163', 'b_s_877337');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'b_s_296a0c', 'b_s_0b9791');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_bfbc20', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'a_s_a8ca0a', 1, 0, 0)
(-2147483646, 'a_s_a8ca0a', 1, 0, 0)
(-2147483645, 'a_s_a8ca0a', 1, 0, 0)
(-2147483644, 'a_s_a8ca0a', 1, 0, 0)
(-2147483643, 'a_s_a8ca0a', 1, 0, 0)
(1, 'a_s_a8ca0a', 1, 4, 0)
*/

-- Prediction Query
SELECT A.INVOICE_ID, CUSTOMER_NAME, PRICE, CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM (SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COUNT(DISTINCT (CO.CONTACT_NAME)) AS CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS AS CO ON CO.USER_ID = C.CUSTOMER_ID GROUP BY INVOICE_ID, CUSTOMER_NAME, PRICE ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST) AS A LEFT JOIN (SELECT INVOICE_ID, COUNT(DISTINCT (C.CONTACT_NAME)) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CONTACTS AS C ON C.USER_ID = I.USER_ID WHERE C.CONTACT_NAME IN (SELECT DISTINCT (CUSTOMER_NAME) FROM CUSTOMERS) GROUP BY INVOICE_ID) AS B ON A.INVOICE_ID = B.INVOICE_ID;

/*
Prediction Result:
(-2147483647, 'a_s_a8ca0a', 1, 0, 0)
(-2147483646, 'a_s_a8ca0a', 1, 0, 0)
(-2147483645, 'a_s_a8ca0a', 1, 0, 0)
(-2147483644, 'a_s_a8ca0a', 1, 0, 0)
(-2147483643, 'a_s_a8ca0a', 1, 0, 0)
(1, 'a_s_a8ca0a', 1, 3, 0)
*/