-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: bank --
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (-2147483648, 'ban_7e662a', -55602865, 'ban_c7869b', 'ban_992a99');

-- Inserting into table: customer --
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('c_1', -2147483648, 'cus_47fcee', '1', 1, -59984348, -664303813, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('cus_793f96', -2147483648, 'value', 'value', 0, 1, 100, 'cus_0bd6b5');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('A', -2147483648, 'cus_47fcee', '1', 1, -1726781632, 247012447, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C', -2147483648, 'cus_47fcee', '1', 1, -106629402, 1871297066, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('_', -2147483648, 'cus_47fcee', '1', 0, 89267185, 100, 'cus_0bd6b5');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('c_3', -2147483648, 'cus_47fcee', '1', 0, 1744686505, 100, 'cus_0bd6b5');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('c_7', -2147483648, 'cus_47fcee', '1', 1, 1160656988, -992890117, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('c_8', -2147483648, 'cus_47fcee', '1', 1, 1219478689, -1670923962, NULL);

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('c_9', -2147483648, 'cus_47fcee', '1', NULL, 1908028688, 2122220075, 'cus_2653a8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT acc_bal AS sum_acc_bal_, state FROM customer WHERE (credit_score >= 100 OR credit_score >= acc_bal) ORDER BY sum_acc_bal_, customer.cust_id NULLS LAST;

/*
Gold Result:
(None, 'cus_2653a8')
(0, 'cus_0bd6b5')
(0, 'cus_0bd6b5')
(0, 'cus_0bd6b5')
(1, 'cus_2653a8')
(1, 'cus_2653a8')
*/

-- Prediction Query
SELECT SUM(acc_bal), state FROM customer WHERE credit_score > 100 GROUP BY state;

/*
Prediction Result:
(2, 'cus_2653a8')
*/