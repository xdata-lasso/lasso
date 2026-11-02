-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_dbba44', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, '_', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'c_s_7579bd', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'O', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'c_s_7579bd', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'O', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'c_s_7579bd', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'O', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'c_s_7579bd', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'O', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'c_s_7579bd', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483597, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483596, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483595, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483594, 'c_s_7579bd', 'c_s_a79467');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483593, 'c_s_7579bd', 'c_s_a79467');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_a79467', 'c_s_7579bd');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a', 'c_s_7579bd');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'c_s_7579bd');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (5, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'c_s_a79467', 'c_s_7579bd');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'c_s_a79467', 'c_s_7579bd');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'c_s_7579bd');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '!', 'c_s_7579bd');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483637, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483638, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483636, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483635, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483633, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483634, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'c_s_dbba44', 1, 6, 1)
(-2147483645, 'c_s_dbba44', 1, 6, 1)
(-2147483644, 'c_s_dbba44', 1, 6, 1)
(-2147483643, 'cus_8d1b6b', 1, 1, 1)
(-2147483641, 'c_s_dbba44', 1, 6, 1)
(-2147483640, 'c_s_dbba44', 1, 6, 1)
(-2147483639, 'cus_8d1b6b', 1, 1, 1)
(-2147483638, 'cus_8d1b6b', 1, 0, 0)
(-2147483637, 'c_s_dbba44', 1, 6, 1)
(-2147483636, 'c_s_dbba44', 1, 6, 1)
(-2147483635, 'c_s_dbba44', 1, 6, 1)
(-2147483634, 'c_s_dbba44', 1, 6, 1)
(-2147483633, 'c_s_dbba44', 1, 6, 1)
(0, 'c_s_dbba44', 1, 6, 1)
(1, 'c_s_dbba44', 1, 6, 1)
(2, 'c_s_dbba44', 1, 6, 1)
*/

-- Prediction Query
WITH CTE1 AS (SELECT USER_ID, COUNT(CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C INNER JOIN CUSTOMERS AS O ON C.CONTACT_NAME = O.CUSTOMER_NAME AND C.CONTACT_EMAIL = O.EMAIL GROUP BY USER_ID), CTE2 AS (SELECT INVOICE_ID, COUNT(C.USER_ID) AS CONTACTS_CNT FROM INVOICES AS I INNER JOIN CONTACTS AS C ON I.USER_ID = C.USER_ID GROUP BY INVOICE_ID) SELECT I.INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CTE2 ON I.INVOICE_ID = CTE2.INVOICE_ID LEFT JOIN CTE1 ON CTE1.USER_ID = I.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'c_s_dbba44', 1, 6, 40)
(-2147483645, 'c_s_dbba44', 1, 6, 40)
(-2147483644, 'c_s_dbba44', 1, 6, 40)
(-2147483643, 'cus_8d1b6b', 1, 1, 40)
(-2147483641, 'c_s_dbba44', 1, 6, 40)
(-2147483640, 'c_s_dbba44', 1, 6, 40)
(-2147483639, 'cus_8d1b6b', 1, 1, 40)
(-2147483638, 'cus_8d1b6b', 1, 0, 0)
(-2147483637, 'c_s_dbba44', 1, 6, 40)
(-2147483636, 'c_s_dbba44', 1, 6, 40)
(-2147483635, 'c_s_dbba44', 1, 6, 40)
(-2147483634, 'c_s_dbba44', 1, 6, 40)
(-2147483633, 'c_s_dbba44', 1, 6, 40)
(0, 'c_s_dbba44', 1, 6, 40)
(1, 'c_s_dbba44', 1, 6, 40)
(2, 'c_s_dbba44', 1, 6, 40)
*/