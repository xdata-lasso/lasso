-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, 'default2'), (10001, 'default1'), (9999, NULL), (1, 'unique_3'), (10000, 'unique_4'), (2, 'unique_5'), (3, 'unique_6');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (9999, 1, 10001, '2023-01-02'), (10000, 10000, 10000, '2023-01-02'), (10001, 10001, 9999, NULL), (0, 10000, 0, '2023-01-02'), (1, 10000, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_3', 10001)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS INNER JOIN TRANSACTIONS USING (ACCOUNT) GROUP BY NAME HAVING BALANCE >= 10000;

/*
Prediction Result:
('unique_3', 10001)
('unique_4', 10000)
*/