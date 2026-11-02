-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c1__181f32', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'm_s_c109f3', 'm_s_d1aac5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, NULL, 'm_s_559d19');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'm_s_39ab4c', 'm_s_559d19');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (9, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (6, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (8, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'm_s_d1aac5', 'm_s_c109f3');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'm_s_559d19', 'm_s_39ab4c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'm_s_559d19', 'm_s_39ab4c');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483646, 'A', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (9, 'A', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 3, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (4, 9, 247012447);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (7, 5, 1610062532);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(1, 'c1__181f32', 1, 1, 1)
(2, 'c1__181f32', 1, 1, 1)
(3, 'cus_8d1b6b', 247012447, 1, 1)
(4, 'cus_8d1b6b', 247012447, 2, 1)
(7, 'cus_8d1b6b', 1610062532, 0, 0)
*/

-- Prediction Query
SELECT I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE, COUNT(M.CONTACT_EMAIL) AS CONTACTS_CNT, SUM(CASE WHEN NOT C2.CUSTOMER_NAME IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C1 ON I.USER_ID = C1.CUSTOMER_ID LEFT JOIN CONTACTS AS M ON C1.CUSTOMER_ID = M.USER_ID LEFT JOIN CUSTOMERS AS C2 ON M.CONTACT_NAME = C2.CUSTOMER_NAME AND M.CONTACT_EMAIL = C2.EMAIL GROUP BY I.INVOICE_ID, C1.CUSTOMER_NAME, I.PRICE ORDER BY I.INVOICE_ID, C1.CUSTOMER_NAME NULLS LAST, I.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(1, 'c1__181f32', 1, 22, 22)
(2, 'c1__181f32', 1, 22, 22)
(3, 'cus_8d1b6b', 247012447, 1, 1)
(4, 'cus_8d1b6b', 247012447, 2, 1)
(7, 'cus_8d1b6b', 1610062532, 0, 0)
*/