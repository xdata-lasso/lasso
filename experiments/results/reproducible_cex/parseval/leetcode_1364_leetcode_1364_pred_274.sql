-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255), "email" TEXT(255));

CREATE TABLE "Contacts" ("user_id" INTEGER, "contact_email" TEXT(255), "contact_name" TEXT(255), PRIMARY KEY ("user_id", "contact_email"), FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_id" INTEGER PRIMARY KEY, "user_id" INTEGER, "price" INTEGER, FOREIGN KEY ("user_id") REFERENCES "Customers" ("customer_id"), CHECK ("price" > 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'c_s_f408ef', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483647, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'O', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'ct__c21451', 'G');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'O', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483643, 'ct__c21451', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'c_s_f408ef', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483641, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_8d1b6b', 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'Q', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'ct__c21451', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'G', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'ct__c21451', 'I');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'O', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'ct__c21451', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, NULL, 'cus_1b98f1');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483606, 'ct__c21451', 'ct__293944');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483605, 'ct__c21451', 'ct__293944');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'ct__293944', 'ct__c21451');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'ct__c21451');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'ct__c21451');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'ct__c21451');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'ct__293944', 'ct__c21451');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (3, 'ct__293944', 'ct__c21451');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483638, 'con_de12a6', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483638, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483637, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483636, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483635, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483634, 2, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483633, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483632, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483631, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483630, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483629, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483628, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483627, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483626, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_id, t.customer_name, price, contacts_cnt, trusted_contacts_cnt FROM Invoices AS I LEFT JOIN (SELECT a.customer_id, customer_name, COUNT(contact_name) AS contacts_cnt, SUM(CASE WHEN contact_email IN (SELECT email FROM customers) THEN 1 ELSE 0 END) AS trusted_contacts_cnt FROM Customers AS a LEFT JOIN Contacts AS b ON a.customer_id = b.user_id GROUP BY a.customer_id, customer_name) AS t ON I.user_id = t.customer_id ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'c_s_f408ef', 1, 4, 1)
(-2147483646, 'c_s_f408ef', 1, 4, 1)
(-2147483645, 'c_s_f408ef', 1, 4, 1)
(-2147483644, 'c_s_f408ef', 1, 4, 1)
(-2147483643, 'cus_8d1b6b', 1, 1, 1)
(-2147483642, 'cus_8d1b6b', 1, 1, 1)
(-2147483641, 'c_s_f408ef', 1, 4, 1)
(-2147483640, 'c_s_f408ef', 1, 4, 1)
(-2147483639, 'cus_8d1b6b', 1, 1, 1)
(-2147483638, 'cus_8d1b6b', 1, 1, 1)
(-2147483637, 'c_s_f408ef', 1, 4, 1)
(-2147483636, 'c_s_f408ef', 1, 4, 1)
(-2147483635, 'cus_8d1b6b', 1, 1, 1)
(-2147483634, 'cus_8d1b6b', 1, 1, 1)
(-2147483633, 'c_s_f408ef', 1, 4, 1)
(-2147483632, 'c_s_f408ef', 1, 4, 1)
(-2147483631, 'c_s_f408ef', 1, 4, 1)
(-2147483630, 'c_s_f408ef', 1, 4, 1)
(-2147483629, 'c_s_f408ef', 1, 4, 1)
(-2147483628, 'c_s_f408ef', 1, 4, 1)
(-2147483627, 'c_s_f408ef', 1, 4, 1)
(-2147483626, 'c_s_f408ef', 1, 4, 1)
(1, 'c_s_f408ef', 1, 4, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT USER_ID, COUNT(CONTACT_NAME) AS CONTACT_CNT, COUNT(CUSTOMER_NAME) AS TRUSTED_CONTACTS_CNT FROM CONTACTS AS CT LEFT JOIN CUSTOMERS AS CM ON CONTACT_NAME = CUSTOMER_NAME AND CONTACT_EMAIL = EMAIL GROUP BY USER_ID) SELECT INVOICE_ID, CUSTOMER_NAME, PRICE, COALESCE(CONTACT_CNT, 0) AS CONTACTS_CNT, COALESCE(TRUSTED_CONTACTS_CNT, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS I JOIN CUSTOMERS AS C ON I.USER_ID = C.CUSTOMER_ID LEFT JOIN CTE ON I.USER_ID = CTE.USER_ID ORDER BY INVOICE_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'c_s_f408ef', 1, 32, 29)
(-2147483646, 'c_s_f408ef', 1, 32, 29)
(-2147483645, 'c_s_f408ef', 1, 32, 29)
(-2147483644, 'c_s_f408ef', 1, 32, 29)
(-2147483643, 'cus_8d1b6b', 1, 29, 29)
(-2147483642, 'cus_8d1b6b', 1, 29, 29)
(-2147483641, 'c_s_f408ef', 1, 32, 29)
(-2147483640, 'c_s_f408ef', 1, 32, 29)
(-2147483639, 'cus_8d1b6b', 1, 29, 29)
(-2147483638, 'cus_8d1b6b', 1, 29, 29)
(-2147483637, 'c_s_f408ef', 1, 32, 29)
(-2147483636, 'c_s_f408ef', 1, 32, 29)
(-2147483635, 'cus_8d1b6b', 1, 29, 29)
(-2147483634, 'cus_8d1b6b', 1, 29, 29)
(-2147483633, 'c_s_f408ef', 1, 32, 29)
(-2147483632, 'c_s_f408ef', 1, 32, 29)
(-2147483631, 'c_s_f408ef', 1, 32, 29)
(-2147483630, 'c_s_f408ef', 1, 32, 29)
(-2147483629, 'c_s_f408ef', 1, 32, 29)
(-2147483628, 'c_s_f408ef', 1, 32, 29)
(-2147483627, 'c_s_f408ef', 1, 32, 29)
(-2147483626, 'c_s_f408ef', 1, 32, 29)
(1, 'c_s_f408ef', 1, 32, 29)
*/