-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'b_s_6c8c92', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'c_s_3a925f', 'c_s_a0a318');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, NULL, 'c_s_c90333');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'c_s_310350', 'c_s_c90333');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_a0a318', 'c_s_3a925f');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'c_s_c90333', 'c_s_310350');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'c_s_c90333', 'c_s_310350');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'con_de12a6', 'c_s_3a925f');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483624, 'con_de12a6', 'c_s_3a925f');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 3, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (4, 9, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (7, -2147483646, 1871297066);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'b_s_6c8c92', 1, 1, 1)
(2, 'b_s_6c8c92', 1, 1, 1)
(3, 'cus_8d1b6b', 247012447, 1, 1)
(4, 'cus_8d1b6b', 247012447, 1, 1)
(7, 'c_s_3a925f', 1871297066, 0, 0)
*/

-- Prediction Query
SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COUNT(C.CONTACT_NAME) AS CONTACTS_CNT, COUNT(CASE WHEN NOT D.CUSTOMER_NAME IS NULL THEN C.CONTACT_NAME ELSE NULL END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN CONTACTS AS C ON B.CUSTOMER_ID = C.USER_ID LEFT JOIN CUSTOMERS AS D ON C.CONTACT_NAME = D.CUSTOMER_NAME AND C.CONTACT_EMAIL = D.EMAIL GROUP BY A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE ORDER BY A.INVOICE_ID, B.CUSTOMER_NAME NULLS LAST, A.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'b_s_6c8c92', 1, 24, 24)
(2, 'b_s_6c8c92', 1, 24, 24)
(3, 'cus_8d1b6b', 247012447, 1, 1)
(4, 'cus_8d1b6b', 247012447, 1, 1)
(7, 'c_s_3a925f', 1871297066, 0, 0)
*/