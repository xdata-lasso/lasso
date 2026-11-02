-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_8d56c1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'c_s_8d56c1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'A', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'c_s_743e53', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'A', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'c_s_743e53', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'c_s_8d56c1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'c_s_8d56c1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'A', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'c_s_743e53', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'A', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'c_s_8d56c1', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'c_s_743e53', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'A', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'c_s_743e53', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'c_s_743e53', 'c_s_e9c93a');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'c_s_743e53', 'c_s_e9c93a');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_e9c93a', 'c_s_743e53');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'c_s_e9c93a', '1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'A', 'c_s_743e53');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'E', 'c_s_743e53');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'c_s_743e53');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'C', 'c_s_743e53');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'c_s_e9c93a', 'c_s_743e53');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'c_s_e9c93a', 'c_s_743e53');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'A', 'c_s_743e53');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'c_s_743e53');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'c_s_e9c93a', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'C', 'c_s_743e53');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, -1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, -1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'c_s_8d56c1', 1, 5, 1)
(0, 'c_s_8d56c1', 1, 5, 1)
(1, 'c_s_8d56c1', 1, 1, 1)
(2, 'c_s_8d56c1', 1, 1, 1)
(3, 'c_s_8d56c1', 1, 1, 1)
*/

-- Prediction Query
WITH T AS (SELECT C.USER_ID, COUNT(*) AS CONTACTS_CNT, COUNT(CM.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C LEFT JOIN CUSTOMERS AS CM ON C.CONTACT_NAME = CM.CUSTOMER_NAME AND C.CONTACT_EMAIL = CM.EMAIL GROUP BY C.USER_ID) SELECT INVOICE_ID, C.CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN T ON I.USER_ID = T.USER_ID INNER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = I.USER_ID ORDER BY INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'c_s_8d56c1', 1, 5, 0)
(0, 'c_s_8d56c1', 1, 5, 0)
(1, 'c_s_8d56c1', 1, 27, 27)
(2, 'c_s_8d56c1', 1, 27, 27)
(3, 'c_s_8d56c1', 1, 27, 27)
*/