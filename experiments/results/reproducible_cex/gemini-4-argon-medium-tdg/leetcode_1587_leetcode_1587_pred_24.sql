-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Users (account, name) VALUES (1, 'Ivan');
INSERT INTO Users (account, name) VALUES (2, NULL);
INSERT INTO Users (account, name) VALUES (3, NULL);
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (401, 1, 12000, '2023-04-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (402, 1, NULL, '2023-04-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (403, 2, 11000, '2023-04-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (404, 3, 15000, '2023-04-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (405, NULL, 50000, '2023-04-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Ivan', 12000)
(None, 11000)
(None, 15000)
*/

-- Prediction Query
SELECT B.NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS AS A LEFT JOIN USERS AS B ON A.ACCOUNT = B.ACCOUNT GROUP BY A.ACCOUNT HAVING BALANCE > 10000;

/*
Prediction Result:
(None, 50000)
('Ivan', 12000)
(None, 11000)
(None, 15000)
*/