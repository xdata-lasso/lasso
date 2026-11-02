-- Schema DDL
CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, code TEXT(10) CHECK (LENGTH(code) = 5));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Accounts (account_id, code) VALUES (1, 'ABCDE');
INSERT INTO Accounts (account_id, code) VALUES (2, 'abcde');
INSERT INTO Accounts (account_id, code) VALUES (3, 'ABCDD');
INSERT INTO Accounts (account_id, code) VALUES (4, 'ABCDF');
INSERT INTO Accounts (account_id, code) VALUES (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Accounts WHERE code = 'ABCDE';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT account_id FROM Accounts WHERE code = 'VWXYZ';

/*
Prediction Result:
*/