-- Schema DDL
CREATE TABLE CUSTOMERS (CUSTOMER_ID INTEGER PRIMARY KEY, CUSTOMER_NAME TEXT(255), EMAIL TEXT(255));

CREATE TABLE CONTACTS (USER_ID INTEGER, CONTACT_EMAIL TEXT(255), CONTACT_NAME TEXT(255), PRIMARY KEY (USER_ID, CONTACT_EMAIL), FOREIGN KEY (USER_ID) REFERENCES CUSTOMERS (CUSTOMER_ID));

CREATE TABLE INVOICES (INVOICE_ID INTEGER PRIMARY KEY, USER_ID INTEGER, PRICE INTEGER, FOREIGN KEY (USER_ID) REFERENCES CUSTOMERS (CUSTOMER_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483648, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (1, 'b_s_0c1c58', 'cus_4f99c5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483646, 'b_s_a8e57a', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483645, 'b_s_a8e57a', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483644, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (4, 'b_s_0c1c58', 'cus_4f99c5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (2, 'cus_801daf', 'cus_4f99c5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (3, 'cus_801daf', 'cus_4f99c5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483640, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483639, 'b_s_a8e57a', '_');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483638, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483637, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483636, 'b_s_a8e57a', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483635, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483634, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483633, 'b_s_a8e57a', 'O');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483632, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483631, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483630, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483629, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483628, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483627, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483626, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483625, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483624, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483623, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483622, 'b_s_a8e57a', 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483621, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483620, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483619, NULL, 'cus_4f99c5');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483618, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483617, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483616, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483615, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483614, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483613, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483612, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483611, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483610, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483609, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483608, NULL, 'a_s_991e87');

INSERT INTO "customers" ("customer_id", "customer_name", "email") VALUES (-2147483607, NULL, 'a_s_991e87');

-- Inserting into table: contacts --
INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_991e87', 'a_s_b32001');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'A', 'a_s_b32001');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'C', 'a_s_2a1b58');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, '@', 'a_s_875104');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'B', 'a_s_2a1b58');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (2, 'a_s_991e87', 'a_s_b32001');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483646, 'a_s_991e87', 'a_s_b32001');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483644, 'a_s_991e87', 'a_s_2a1b58');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (4, 'a_s_991e87', 'a_s_875104');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483639, 'a_s_991e87', 'a_s_b32001');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483645, 'a_s_991e87', 'a_s_2a1b58');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483640, 'a_s_991e87', 'a_s_875104');

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (-2147483623, 'con_36293f', NULL);

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_d22ad2', NULL);

INSERT INTO "contacts" ("user_id", "contact_email", "contact_name") VALUES (1, 'a_s_8de193', NULL);

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (1, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483647, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483646, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483645, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483644, -2147483644, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483643, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483642, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483641, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483640, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483639, 3, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483638, -2147483638, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483637, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483636, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483635, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483634, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483633, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483632, 1, 1);

INSERT INTO "invoices" ("invoice_id", "user_id", "price") VALUES (-2147483631, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT INVOICE_ID, T.CUSTOMER_NAME, PRICE, CONTACTS_CNT, TRUSTED_CONTACTS_CNT FROM INVOICES AS I LEFT JOIN (SELECT A.CUSTOMER_ID, CUSTOMER_NAME, COUNT(CONTACT_NAME) AS CONTACTS_CNT, SUM(CASE WHEN CONTACT_EMAIL IN (SELECT EMAIL FROM CUSTOMERS) THEN 1 ELSE 0 END) AS TRUSTED_CONTACTS_CNT FROM CUSTOMERS AS A LEFT JOIN CONTACTS AS B ON A.CUSTOMER_ID = B.USER_ID GROUP BY A.CUSTOMER_ID, CUSTOMER_NAME) AS T ON I.USER_ID = T.CUSTOMER_ID ORDER BY 1, I.invoice_id NULLS LAST;

/*
Gold Result:
(-2147483647, 'b_s_0c1c58', 1, 5, 1)
(-2147483646, 'b_s_0c1c58', 1, 5, 1)
(-2147483645, 'cus_801daf', 1, 0, 0)
(-2147483644, 'b_s_a8e57a', 1, 1, 1)
(-2147483643, 'b_s_0c1c58', 1, 5, 1)
(-2147483642, 'cus_801daf', 1, 0, 0)
(-2147483641, 'b_s_0c1c58', 1, 5, 1)
(-2147483640, 'b_s_0c1c58', 1, 5, 1)
(-2147483639, 'cus_801daf', 1, 0, 0)
(-2147483638, 'b_s_a8e57a', 1, 0, 0)
(-2147483637, 'b_s_0c1c58', 1, 5, 1)
(-2147483636, 'b_s_0c1c58', 1, 5, 1)
(-2147483635, 'b_s_0c1c58', 1, 5, 1)
(-2147483634, 'b_s_0c1c58', 1, 5, 1)
(-2147483633, 'b_s_0c1c58', 1, 5, 1)
(-2147483632, 'b_s_0c1c58', 1, 5, 1)
(-2147483631, 'b_s_0c1c58', 1, 5, 1)
(1, 'b_s_0c1c58', 1, 5, 1)
*/

-- Prediction Query
WITH CONTACTTYPES AS (SELECT A.USER_ID, COUNT(A.CONTACT_NAME) AS CONTACTS, COUNT(B.CUSTOMER_NAME) AS TRUSTED_CONTACTS FROM CONTACTS AS A LEFT JOIN CUSTOMERS AS B ON A.CONTACT_EMAIL = B.EMAIL GROUP BY A.USER_ID) SELECT A.INVOICE_ID, B.CUSTOMER_NAME, A.PRICE, COALESCE(C.CONTACTS, 0) AS CONTACTS_CNT, COALESCE(C.TRUSTED_CONTACTS, 0) AS TRUSTED_CONTACTS_CNT FROM INVOICES AS A JOIN CUSTOMERS AS B ON A.USER_ID = B.CUSTOMER_ID LEFT JOIN CONTACTTYPES AS C ON A.USER_ID = C.USER_ID ORDER BY INVOICE_ID, B.customer_id NULLS LAST;

/*
Prediction Result:
(-2147483647, 'b_s_0c1c58', 1, 36, 18)
(-2147483646, 'b_s_0c1c58', 1, 36, 18)
(-2147483645, 'cus_801daf', 1, 0, 0)
(-2147483644, 'b_s_a8e57a', 1, 32, 18)
(-2147483643, 'b_s_0c1c58', 1, 36, 18)
(-2147483642, 'cus_801daf', 1, 0, 0)
(-2147483641, 'b_s_0c1c58', 1, 36, 18)
(-2147483640, 'b_s_0c1c58', 1, 36, 18)
(-2147483639, 'cus_801daf', 1, 0, 0)
(-2147483638, 'b_s_a8e57a', 1, 0, 0)
(-2147483637, 'b_s_0c1c58', 1, 36, 18)
(-2147483636, 'b_s_0c1c58', 1, 36, 18)
(-2147483635, 'b_s_0c1c58', 1, 36, 18)
(-2147483634, 'b_s_0c1c58', 1, 36, 18)
(-2147483633, 'b_s_0c1c58', 1, 36, 18)
(-2147483632, 'b_s_0c1c58', 1, 36, 18)
(-2147483631, 'b_s_0c1c58', 1, 36, 18)
(1, 'b_s_0c1c58', 1, 36, 18)
*/