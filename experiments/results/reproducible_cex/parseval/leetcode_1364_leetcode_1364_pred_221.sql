-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'b', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, '1', '#');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, '1', '#');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, '1', '#');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'A', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'A', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'A', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, '!', '$');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, '!', '$');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, '!', '$');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, '@', '?');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, '@', '?');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, '@', '?');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'A', '0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'A', '0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'A', '0');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, '!', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, '!', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, '!', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, '!', 'W');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, '!', 'W');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, '!', 'W');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483592, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483591, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483590, 'cus_8d1b6b', NULL);

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483589, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483588, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483587, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483586, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483585, NULL, 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483584, NULL, 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483583, NULL, 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483582, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483581, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483580, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483579, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483578, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483577, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483576, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483575, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483574, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483573, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483572, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483571, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483570, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483569, 'ema_5773b7', 'con_01f1e6');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483568, 'ema_5773b7', 'con_01f1e6');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_01f1e6', 'con_f38a86');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'X');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '?', 'Y');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '#', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '1', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '$', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'A', '`');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', '@');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '"', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, '0', '1');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'r', 'k');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'W', '!');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'g', '#');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_da081c', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-1, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 5, 3)
(1, 'cus_8d1b6b', 1, 5, 3)
*/

-- Prediction Query
SELECT INVOICES.INVOICE_ID, CUSTOMERS.CUSTOMER_NAME, INVOICES.PRICE, COUNT(CONTACT_NAME) AS CONTACTS_CNT, COUNT(EMAILS.EMAIL) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS INVOICES LEFT JOIN CUSTOMERS AS CUSTOMERS ON INVOICES.USER_ID = CUSTOMERS.CUSTOMER_ID LEFT JOIN CONTACTS AS CONTACTS ON INVOICES.USER_ID = CONTACTS.USER_ID LEFT JOIN CUSTOMERS AS EMAILS ON EMAILS.EMAIL = CONTACTS.CONTACT_EMAIL GROUP BY INVOICES.INVOICE_ID, INVOICES.PRICE, CUSTOMERS.CUSTOMER_NAME ORDER BY INVOICE_ID, INVOICES.INVOICE_ID NULLS LAST, CUSTOMERS.CUSTOMER_NAME NULLS LAST, INVOICES.PRICE NULLS LAST, CONTACTS_CNT NULLS LAST, TRUSTED_CONTACTS_CNT NULLS LAST;

/*
Prediction Result:
(-1, 'cus_8d1b6b', 1, 0, 0)
(0, 'cus_8d1b6b', 1, 65, 63)
(1, 'cus_8d1b6b', 1, 65, 63)
*/