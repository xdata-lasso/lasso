-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Users (account, name) VALUES (1, 'Frank');
INSERT INTO Users (account, name) VALUES (2, 'Grace');
INSERT INTO Users (account, name) VALUES (3, 'Heidi');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (301, 1, 7000, '2023-03-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (302, 1, 7000, '2023-03-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (303, 2, 12000, '2023-03-03');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (304, 2, NULL, '2023-03-04');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (305, NULL, 20000, '2023-03-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Frank', 14000)
('Grace', 12000)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS AS T LEFT JOIN USERS AS U USING (ACCOUNT) GROUP BY ACCOUNT HAVING BALANCE > 10000;

/*
Prediction Result:
(None, 20000)
('Frank', 14000)
('Grace', 12000)
*/