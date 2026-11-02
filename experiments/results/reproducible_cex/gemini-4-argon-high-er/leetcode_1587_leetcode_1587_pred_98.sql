-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Users (account, name) VALUES (1, 'Alice');
INSERT INTO Users (account, name) VALUES (2, NULL);
INSERT INTO Users (account, name) VALUES (3, NULL);
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (1, 1, 15000, '2020-01-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (2, 2, 6000, '2020-01-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (3, 3, 6000, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Alice', 15000)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS S JOIN TRANSACTIONS AS T ON S.ACCOUNT = T.ACCOUNT GROUP BY 1 HAVING SUM(AMOUNT) > 10000;

/*
Prediction Result:
(None, 12000)
('Alice', 15000)
*/