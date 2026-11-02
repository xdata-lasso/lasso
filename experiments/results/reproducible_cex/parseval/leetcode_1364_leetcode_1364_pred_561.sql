-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_1bfc7e', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, '#', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, '#', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'c_s_1bfc7e', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, '@', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, '@', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, '#', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, '#', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, '(', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, '(', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'Q', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'Q', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'Q', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'Q', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, '@', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, '@', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, '"', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, '"', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, '@', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, '@', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, '@', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, '@', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, ')', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, ')', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, '(', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, '(', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'A', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'A', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, '#', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, '#', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, '!', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483592, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483591, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483590, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483589, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483588, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483587, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483586, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483585, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483584, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483583, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483582, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483581, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483580, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483579, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483578, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483577, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483576, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483575, 'co__1ae032', 'co__9c9c82');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483574, 'co__1ae032', 'co__9c9c82');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_61c729');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__9c9c82', 'co__1ae032');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__612ee2', 'co__ec72f3');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'co__96c0ea', 'co__fc38ac');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', 'con_61c729');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'co__9c9c82', '#');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'co__612ee2', '&');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'co__96c0ea', 'co__fc38ac');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', '#');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'E', ')');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'I', 'Q');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_de12a6', 'con_61c729');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'co__9c9c82', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'co__612ee2', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'co__96c0ea', 'co__fc38ac');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'Q', '"');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'co__fc38ac');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483586, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'c_s_1bfc7e', 1, 9, 1)
(-1, 'c_s_1bfc7e', 1, 9, 1)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'c_s_1bfc7e', 1, 9, 1)
(3, 'c_s_1bfc7e', 1, 9, 1)
*/

-- Prediction Query
WITH CUST_INFO AS (SELECT I.INVOICE_ID, C.CUSTOMER_NAME, C.CUSTOMER_ID, I.PRICE FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID), TOTAL_CONTACTS AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1), TRUSTED_CONTACTS AS (SELECT CO.USER_ID, COUNT(CO.CONTACT_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CO JOIN CUSTOMERS AS C ON CO.CONTACT_NAME = C.CUSTOMER_NAME AND CO.CONTACT_EMAIL = C.EMAIL GROUP BY 1) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM CUST_INFO LEFT JOIN TOTAL_CONTACTS ON CUST_INFO.CUSTOMER_ID = TOTAL_CONTACTS.USER_ID LEFT JOIN TRUSTED_CONTACTS ON CUST_INFO.CUSTOMER_ID = TRUSTED_CONTACTS.USER_ID ORDER BY INVOICE_ID, CUSTOMER_NAME NULLS LAST, PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-2147483647, 'c_s_1bfc7e', 1, 9, 29)
(-1, 'c_s_1bfc7e', 1, 9, 29)
(0, 'cus_8d1b6b', 1, 0, 0)
(1, 'c_s_1bfc7e', 1, 9, 29)
(3, 'c_s_1bfc7e', 1, 9, 29)
*/