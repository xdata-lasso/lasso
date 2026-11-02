-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, 'default2'), (10001, 'default1'), (10000, NULL), (9999, 'unique_3'), (0, 'unique_4');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, NULL, NULL, '2023-01-02'), (9999, 9999, 9999, NULL), (10000, 0, 10001, NULL), (10001, NULL, 0, '2023-01-02'), (1, 10001, 9999, '2023-01-02'), (2, 9999, 9999, '2023-01-02'), (3, 10001, 10001, '2023-01-01'), (4, 0, 10000, '2023-01-01'), (5, 9999, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_4', 20001)
('unique_3', 19998)
('default1', 20000)
*/

-- Prediction Query
SELECT N.NAME, SUM(A.AMOUNT) AS BALANCE FROM USERS AS N JOIN TRANSACTIONS AS A ON N.ACCOUNT = A.ACCOUNT GROUP BY N.NAME HAVING BALANCE > 10000 ORDER BY BALANCE DESC, N.NAME NULLS LAST;

/*
Prediction Result:
('unique_4', 20001)
('default1', 20000)
('unique_3', 19998)
*/