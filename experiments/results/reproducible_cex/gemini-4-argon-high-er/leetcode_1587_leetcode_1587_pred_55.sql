-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Users (account, name) VALUES (1, NULL);
INSERT INTO Users (account, name) VALUES (2, NULL);
INSERT INTO Users (account, name) VALUES (3, 'Bob');
INSERT INTO Users (account, name) VALUES (4, 'Alice');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (1, 1, 6000, '2023-01-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (2, 2, 6000, '2023-01-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (3, 3, 20000, '2023-01-03');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (4, 4, 20000, '2023-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Bob', 20000)
('Alice', 20000)
*/

-- Prediction Query
SELECT A.NAME, SUM(B.AMOUNT) AS BALANCE FROM USERS AS A JOIN TRANSACTIONS AS B ON A.ACCOUNT = B.ACCOUNT GROUP BY A.NAME HAVING SUM(B.AMOUNT) > 10000 ORDER BY A.NAME, BALANCE NULLS LAST;

/*
Prediction Result:
(None, 12000)
('Alice', 20000)
('Bob', 20000)
*/