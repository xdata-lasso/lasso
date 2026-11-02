-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: bank --
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1, 'ban_7e662a', -55602865, 'ban_c7869b', 'ban_992a99');

-- Inserting into table: customer --
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('cus_618a4c', 1, 'cus_2dabd1', 'cus_6e4eae', 1, 1, 1, 'cus_501081');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('cus_08ff1e', 1, 'cus_d0eb07', 'cus_2cba0f', 1, 1, 1, 'cus_4e33ba');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('!', 1, '"', '1', -921145356, 1258409369, -1981402255, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('0', 1, '!', '1', 247012447, -1980249628, -734455130, 'cus_2653a8');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('value', 1, 'q_1_4dfe20', 'q_1_05e461', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('value_1', 1, 'q_1_4dfe20', 'q_1_05e461', 1, 1, 1, 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name, acc_type, acc_bal FROM (SELECT * FROM (SELECT * FROM customer ORDER BY cust_name DESC, customer.cust_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('q_1_4dfe20', 'q_1_05e461', 1)
*/

-- Prediction Query
SELECT cust_name, acc_type, acc_bal FROM customer ORDER BY credit_score DESC, customer.cust_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('cus_d0eb07', 'cus_2cba0f', 1)
*/