-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: bank --
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1, 'ban_7e662a', -55602865, 'ban_c7869b', 'ban_992a99');

-- Inserting into table: customer --
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('lhs_2e66f8', 1, 'lhs_a27d15', 'lhs_1b9271', 1, 1, 1, 'lhs_20bb9c');

INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('lhs_542950', 1, 'lhs_c2a606', 'lhs_679d46', 1, 1, 1, 'lhs_2447fd');

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value', 'lhs_2e66f8', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1', 'lhs_2e66f8', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2', 'lhs_2e66f8', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3', 'lhs_2e66f8', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4', 'lhs_2e66f8', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5', 'lhs_2e66f8', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27', 'lhs_2e66f8', '1', 'value', 1);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32', 'lhs_2e66f8', '1', 'value', NULL);

INSERT INTO "loan" ("loan_id", "cust_id", "branch_id", "loan_type", "amount") VALUES ('value_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_16_17_18_19_20_21_22_23_24_25_26_27_28_29_30_31_32_33', 'lhs_2e66f8', '1', 'value', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name, acc_type FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state, RHS.sumamount AS sumamount FROM customer AS LHS INNER JOIN (SELECT cust_id, SUM(amount) AS sumamount FROM loan WHERE (amount <> 5000) GROUP BY cust_id) AS RHS ON (LHS.cust_id = RHS.cust_id)) ORDER BY cust_name, acc_type NULLS LAST;

/*
Gold Result:
('lhs_a27d15', 'lhs_1b9271')
*/

-- Prediction Query
SELECT T1.cust_name, T1.acc_type FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id GROUP BY T1.cust_name HAVING SUM(T2.amount) > 5000;

/*
Prediction Result:
*/