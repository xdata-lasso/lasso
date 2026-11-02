-- Schema DDL
CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, code TEXT(10) CHECK (LENGTH(code) = 5));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Accounts (account_id, code) VALUES (1, 'ABCDE');
INSERT INTO Accounts (account_id, code) VALUES (2, 'ABCDE');
INSERT INTO Accounts (account_id, code) VALUES (3, 'abcde');
INSERT INTO Accounts (account_id, code) VALUES (4, 'ABCDX');
INSERT INTO Accounts (account_id, code) VALUES (5, 'XBCDE');
INSERT INTO Accounts (account_id, code) VALUES (6, 'ABCD ');
INSERT INTO Accounts (account_id, code) VALUES (7, 'BCDEA');
INSERT INTO Accounts (account_id, code) VALUES (8, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Accounts WHERE code = 'ABCDE';

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT account_id FROM Accounts WHERE code = 'VWXYZ';

/*
Prediction Result:
*/