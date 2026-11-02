-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Users (account, name) VALUES (1, 'Niaj');
INSERT INTO Users (account, name) VALUES (2, 'Olivia');
INSERT INTO Users (account, name) VALUES (3, 'Peggy');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (1, 1, 9999, '2020-05-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (2, 1, 0, '2020-05-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (3, 2, 10000, '2020-05-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (4, 2, 0, '2020-05-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (5, 3, 10001, '2020-05-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (6, 3, NULL, '2020-05-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (7, NULL, 50000, '2020-05-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Peggy', 10001)
*/

-- Prediction Query
SELECT * FROM (SELECT USERS.NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS LEFT JOIN USERS ON USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY TRANSACTIONS.ACCOUNT) AS T1 WHERE BALANCE > 10000;

/*
Prediction Result:
(None, 50000)
('Peggy', 10001)
*/