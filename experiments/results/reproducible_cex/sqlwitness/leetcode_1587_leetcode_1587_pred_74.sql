-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, 'default1'), (9999, NULL), (10000, 'default2'), (10001, 'unique_3'), (0, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, 10001, 9999, NULL), (0, NULL, 10001, NULL), (9999, 9999, 1, NULL), (10000, 4, 0, NULL), (10001, 9999, 10000, '2023-01-02'), (2, 0, 0, '2023-01-02'), (3, 9999, 10000, '2023-01-02'), (4, 0, 9999, NULL), (5, 4, 1, NULL), (6, 2, 9999, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 20001)
*/

-- Prediction Query
SELECT A.NAME, A.BALANCE FROM (SELECT NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS AS T LEFT JOIN USERS AS U ON U.ACCOUNT = T.ACCOUNT GROUP BY T.ACCOUNT) AS A WHERE A.BALANCE > 10000;

/*
Prediction Result:
(None, 10001)
(None, 20001)
*/