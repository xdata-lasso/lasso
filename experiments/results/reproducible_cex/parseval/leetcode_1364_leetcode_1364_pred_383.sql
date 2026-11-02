-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'cus_0058a4', 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'cus_85c954', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'cus_0058a4', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (0, 'cus_85c954', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'cus_0058a4', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483642, 'cus_0058a4', 'c_s_969225');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'cus_0058a4', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'cus_0058a4', 'c_s_969225');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'cus_0058a4', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-1, 'cus_85c954', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'cus_0058a4', 'c_s_969225');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'cus_0058a4', 'A');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'cus_0058a4', 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'cus_0058a4', 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'cus_0058a4', 'c_s_969225');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'cus_0058a4', 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'cus_0058a4', 'c_s_969225');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'cus_0058a4', 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'cus_0058a4', 'c_s_969225');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'cus_0058a4', 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, NULL, 'c_s_de65e8');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'cus_8d1b6b', 'cus_1b98f1');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_de65e8', 'c_s_e7ca63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483644, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, '@', 'c_s_e7ca63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'E', 'c_s_89975a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'C', 'c_s_e7ca63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483646, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'c_s_de65e8', 'c_s_e7ca63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'c_s_f317cc', 'c_s_89975a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'c_s_969225', 'c_s_4fa4b8');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483643, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (0, 'a', 'c_s_e7ca63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483637, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, '@', 'c_s_e7ca63');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483636, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-1, 'I', 'c_s_4fa4b8');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483631, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483629, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483639, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_f317cc', 'c_s_89975a');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'c_s_969225', 'c_s_4fa4b8');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483626, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483630, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483623, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483642, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483621, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483617, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483614, 'con_66ebd7', NULL);

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483618, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483633, 'con_66ebd7', 'con_54a98e');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483607, 'con_66ebd7', 'con_54a98e');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (0, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 0, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (2, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (3, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'cus_85c954', 1, 4, 2)
(-2147483646, 'cus_85c954', 1, 4, 2)
(-2147483645, 'cus_8d1b6b', 1, 1, 0)
(-2147483644, 'cus_85c954', 1, 4, 2)
(-2147483643, 'cus_8d1b6b', 1, 1, 0)
(-2147483641, 'cus_85c954', 1, 5, 0)
(0, 'cus_85c954', 1, 5, 0)
(1, 'cus_85c954', 1, 4, 2)
(2, 'cus_85c954', 1, 4, 2)
(3, 'cus_85c954', 1, 4, 2)
*/

-- Prediction Query
SELECT I.INVOICE_ID, CUS0.CUSTOMER_NAME, I.PRICE, COALESCE(TEMP.CONTACTS_CNT, 0) AS CONTACTS_CNT, COALESCE(TEMP.TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN CUSTOMERS AS CUS0 ON I.USER_ID = CUS0.CUSTOMER_ID LEFT JOIN (SELECT C.USER_ID, COUNT(C.CONTACT_NAME) AS CONTACTS_CNT, COUNT(CUS.CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS C LEFT JOIN CUSTOMERS AS CUS ON C.CONTACT_EMAIL = CUS.EMAIL GROUP BY C.USER_ID) AS TEMP ON I.USER_ID = TEMP.USER_ID ORDER BY I.INVOICE_ID, CUS0.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'cus_85c954', 1, 24, 12)
(-2147483646, 'cus_85c954', 1, 24, 12)
(-2147483645, 'cus_8d1b6b', 1, 1, 0)
(-2147483644, 'cus_85c954', 1, 24, 12)
(-2147483643, 'cus_8d1b6b', 1, 1, 0)
(-2147483641, 'cus_85c954', 1, 5, 0)
(0, 'cus_85c954', 1, 5, 0)
(1, 'cus_85c954', 1, 24, 12)
(2, 'cus_85c954', 1, 24, 12)
(3, 'cus_85c954', 1, 24, 12)
*/