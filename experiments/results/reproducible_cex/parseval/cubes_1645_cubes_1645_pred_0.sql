-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: bank --
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (-2147483648, 'ban_7e662a', -55602865, 'ban_c7869b', 'ban_992a99');

-- Inserting into table: customer --
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('cus_37882e', -2147483648, 'cus_2696b1', 'cus_6bc9f0', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('A', -2147483648, 'cus_2696b1', 'cus_6bc9f0', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C', -2147483648, 'cus_2696b1', 'cus_66836e', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('?', -2147483648, 'value', 'saving', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_', -2147483648, 'cus_47fcee', NULL, -1726781632, 247012447, -1980249628, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('/', -2147483648, NULL, 'cus_6bc9f0', 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cust_name" FROM "customer" WHERE ("acc_type" <> 'saving') ORDER BY cust_name, customer.cust_id NULLS LAST;

/*
Gold Result:
(None,)
('cus_2696b1',)
('cus_2696b1',)
('cus_2696b1',)
*/

-- Prediction Query
SELECT cust_name FROM customer EXCEPT SELECT cust_name FROM customer WHERE acc_type = 'saving';

/*
Prediction Result:
(None,)
('cus_2696b1',)
('cus_47fcee',)
*/