-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, 'default2'), (10000, 'default1'), (9999, NULL), (10001, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, 0, NULL, '2023-01-01'), (10001, 10000, NULL, '2023-01-01'), (10000, 10001, 10001, '2023-01-01'), (9999, 10000, 9999, '2023-01-02'), (0, 0, 9999, '2023-01-02'), (2, 9999, 10001, NULL), (3, 10001, 0, '2023-01-02'), (4, 0, 1, '2023-01-01'), (5, 0, 1, '2023-01-01'), (6, 9999, 0, '2023-01-01'), (7, 10000, 0, '2023-01-02'), (8, 10000, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default2', 10001)
(None, 10001)
('unique_3', 10001)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U INNER JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY U.ACCOUNT HAVING SUM(AMOUNT) > 10000 ORDER BY SUM(AMOUNT) DESC, NAME NULLS LAST, BALANCE NULLS LAST;

/*
Prediction Result:
('default2', 10001)
('unique_3', 10001)
(None, 10001)
*/