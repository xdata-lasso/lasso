-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_41282a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'A', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'c_s_41282a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'con_ca4f64', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'A', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'con_ca4f64', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'c_s_41282a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'c_s_41282a', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'A', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'con_ca4f64', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'A', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'con_ca4f64', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'A', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'con_ca4f64', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483604, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483603, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483602, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483601, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483600, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483599, 'con_ca4f64', 'con_d9dcbc');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483598, 'con_ca4f64', 'con_d9dcbc');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_d9dcbc', 'con_ca4f64');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_d9dcbc', 'a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'con_ca4f64');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'U', 'con_ca4f64');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '!', 'con_ca4f64');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'con_d9dcbc', 'con_ca4f64');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_de12a6', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_d9dcbc', 'C');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'Q', 'con_ca4f64');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'con_ca4f64');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'I', 'con_ca4f64');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483638, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483637, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483636, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483635, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483634, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483633, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483632, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483631, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483630, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483629, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'c_s_41282a', 1, 2, 1)
(-2147483646, 'c_s_41282a', 1, 2, 1)
(-2147483645, 'c_s_41282a', 1, 2, 1)
(-2147483644, 'c_s_41282a', 1, 2, 1)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-2147483642, 'cus_8d1b6b', 1, 0, 0)
(-2147483641, 'c_s_41282a', 1, 5, 1)
(-2147483640, 'c_s_41282a', 1, 2, 1)
(-2147483639, 'c_s_41282a', 1, 2, 1)
(-2147483638, 'cus_8d1b6b', 1, 0, 0)
(-2147483637, 'cus_8d1b6b', 1, 0, 0)
(-2147483636, 'c_s_41282a', 1, 5, 1)
(-2147483635, 'c_s_41282a', 1, 2, 1)
(-2147483634, 'c_s_41282a', 1, 2, 1)
(-2147483633, 'cus_8d1b6b', 1, 0, 0)
(-2147483632, 'cus_8d1b6b', 1, 0, 0)
(-2147483631, 'c_s_41282a', 1, 5, 1)
(-2147483630, 'c_s_41282a', 1, 2, 1)
(-2147483629, 'c_s_41282a', 1, 2, 1)
(1, 'c_s_41282a', 1, 2, 1)
(2, 'c_s_41282a', 1, 2, 1)
(3, 'c_s_41282a', 1, 2, 1)
*/

-- Prediction Query
WITH CONTACTS_CNT AS (SELECT USER_ID, COUNT(1) AS CONTACTS_CNT FROM CONTACTS GROUP BY 1), TRUSTED_CONTACTS_CNT AS (SELECT USER_ID, SUM((CASE WHEN CUSTOMER_NAME IS NULL THEN 0 ELSE 1 END)) AS TRUSTED_CONTACTS_CNT FROM CONTACTS LEFT JOIN CUSTOMERS ON CONTACTS.CONTACT_NAME = CUSTOMERS.CUSTOMER_NAME AND CONTACTS.CONTACT_EMAIL = CUSTOMERS.EMAIL GROUP BY 1) SELECT I.INVOICE_ID, C.CUSTOMER_NAME, I.PRICE, COALESCE(CC.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TCC.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I INNER JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CONTACTS_CNT AS CC ON C.CUSTOMER_ID = CC.USER_ID LEFT JOIN TRUSTED_CONTACTS_CNT AS TCC ON C.CUSTOMER_ID = TCC.USER_ID ORDER BY I.INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'c_s_41282a', 1, 2, 33)
(-2147483646, 'c_s_41282a', 1, 2, 33)
(-2147483645, 'c_s_41282a', 1, 2, 33)
(-2147483644, 'c_s_41282a', 1, 2, 33)
(-2147483643, 'cus_8d1b6b', 1, 0, 0)
(-2147483642, 'cus_8d1b6b', 1, 0, 0)
(-2147483641, 'c_s_41282a', 1, 5, 0)
(-2147483640, 'c_s_41282a', 1, 2, 33)
(-2147483639, 'c_s_41282a', 1, 2, 33)
(-2147483638, 'cus_8d1b6b', 1, 0, 0)
(-2147483637, 'cus_8d1b6b', 1, 0, 0)
(-2147483636, 'c_s_41282a', 1, 5, 0)
(-2147483635, 'c_s_41282a', 1, 2, 33)
(-2147483634, 'c_s_41282a', 1, 2, 33)
(-2147483633, 'cus_8d1b6b', 1, 0, 0)
(-2147483632, 'cus_8d1b6b', 1, 0, 0)
(-2147483631, 'c_s_41282a', 1, 5, 0)
(-2147483630, 'c_s_41282a', 1, 2, 33)
(-2147483629, 'c_s_41282a', 1, 2, 33)
(1, 'c_s_41282a', 1, 2, 33)
(2, 'c_s_41282a', 1, 2, 33)
(3, 'c_s_41282a', 1, 2, 33)
*/