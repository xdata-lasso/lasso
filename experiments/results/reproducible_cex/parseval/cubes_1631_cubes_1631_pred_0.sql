-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: bank --
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1, 'ban_7e662a', -55602865, 'ban_c7869b', 'ban_992a99');

-- Inserting into table: customer --
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('lhs_badf25', 1, 'lhs_903ccb', 'lhs_bfc32f', 1, 1, 1, 'lhs_9abc7c');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('loa_ce1df7', 1, 'value', 'value', 1, 1, 1, 'value');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('lhs_c1dc71', 1, 'lhs_616bca', 'lhs_3cdccf', 1, 1, 1, 'lhs_0a4a05');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('A', 1, 'cus_47fcee', '1', 1072996612, 13244799, -1659388584, 'cus_2653a8');

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('l_4', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6', 'lhs_c1dc71', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7', 'lhs_c1dc71', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28', 'loa_ce1df7', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('A', 'lhs_badf25', '1', 'value', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state FROM customer AS LHS INNER JOIN (SELECT cust_id, COUNT(*) AS n FROM loan GROUP BY cust_id) AS RHS ON (LHS.branch_id = RHS.n AND LHS.cust_id = RHS.cust_id)) ORDER BY cust_name;

/*
Gold Result:
('lhs_903ccb',)
*/

-- Prediction Query
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id GROUP BY T1.cust_name HAVING COUNT(*) > 1;

/*
Prediction Result:
('lhs_616bca',)
('value',)
*/