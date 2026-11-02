-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_f2b522', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'G', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'c_s_f2b522', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'ct__fd3018', 'C');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'c_s_f2b522', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'O', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'ct__fd3018', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (5, 'c_s_f2b522', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'O', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'ct__fd3018', 'Q');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'O', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'ct__fd3018', '_');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'G', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'ct__fd3018', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'ct__fd3018', 'ct__317593');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, 'ct__fd3018', 'ct__317593');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__317593', 'ct__fd3018');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'ct__317593', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'A', 'ct__fd3018');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'ct__fd3018');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'ct__317593', 'A');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'ct__317593', 'ct__fd3018');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'A', 'ct__fd3018');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'ct__fd3018');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483638, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483637, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483636, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483635, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483634, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483633, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483632, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483631, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483630, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483629, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'c_s_f2b522', 1, 1, 1)
(-2147483646, 'c_s_f2b522', 1, 3, 1)
(-2147483645, 'c_s_f2b522', 1, 3, 1)
(-2147483644, 'c_s_f2b522', 1, 3, 1)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-2147483642, 'c_s_f2b522', 1, 1, 1)
(-2147483641, 'c_s_f2b522', 1, 3, 1)
(-2147483640, 'c_s_f2b522', 1, 3, 1)
(-2147483639, 'cus_8d1b6b', 1, 0, 0)
(-2147483638, 'c_s_f2b522', 1, 3, 1)
(-2147483637, 'c_s_f2b522', 1, 3, 1)
(-2147483636, 'c_s_f2b522', 1, 3, 1)
(-2147483635, 'cus_8d1b6b', 1, 0, 0)
(-2147483634, 'c_s_f2b522', 1, 3, 1)
(-2147483633, 'c_s_f2b522', 1, 3, 1)
(-2147483632, 'c_s_f2b522', 1, 1, 1)
(-2147483631, 'c_s_f2b522', 1, 1, 1)
(-2147483630, 'c_s_f2b522', 1, 1, 1)
(-2147483629, 'c_s_f2b522', 1, 1, 1)
(1, 'c_s_f2b522', 1, 1, 1)
*/

-- Prediction Query
WITH CTE1 AS (SELECT CT.USER_ID, COUNT(*) AS CONTACT_CNT, SUM(CASE WHEN NOT C.CUSTOMER_ID IS NULL THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CT LEFT OUTER JOIN CUSTOMERS AS C ON CT.CONTACT_NAME = C.CUSTOMER_NAME AND CT.CONTACT_EMAIL = C.EMAIL GROUP BY CT.USER_ID) SELECT I.INVOICE_ID AS INVOICE_ID, C.CUSTOMER_NAME AS CUSTOMER_NAME, I.PRICE AS PRICE, COALESCE(CTE1.CONTACT_CNT, 0) AS CONTACTS_CNT, COALESCE(CTE1.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT OUTER JOIN CTE1 ON C.CUSTOMER_ID = CTE1.USER_ID ORDER BY INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'c_s_f2b522', 1, 28, 28)
(-2147483646, 'c_s_f2b522', 1, 3, 0)
(-2147483645, 'c_s_f2b522', 1, 3, 0)
(-2147483644, 'c_s_f2b522', 1, 3, 0)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-2147483642, 'c_s_f2b522', 1, 28, 28)
(-2147483641, 'c_s_f2b522', 1, 3, 0)
(-2147483640, 'c_s_f2b522', 1, 3, 0)
(-2147483639, 'cus_8d1b6b', 1, 0, 0)
(-2147483638, 'c_s_f2b522', 1, 3, 0)
(-2147483637, 'c_s_f2b522', 1, 3, 0)
(-2147483636, 'c_s_f2b522', 1, 3, 0)
(-2147483635, 'cus_8d1b6b', 1, 0, 0)
(-2147483634, 'c_s_f2b522', 1, 3, 0)
(-2147483633, 'c_s_f2b522', 1, 3, 0)
(-2147483632, 'c_s_f2b522', 1, 28, 28)
(-2147483631, 'c_s_f2b522', 1, 28, 28)
(-2147483630, 'c_s_f2b522', 1, 28, 28)
(-2147483629, 'c_s_f2b522', 1, 28, 28)
(1, 'c_s_f2b522', 1, 28, 28)
*/