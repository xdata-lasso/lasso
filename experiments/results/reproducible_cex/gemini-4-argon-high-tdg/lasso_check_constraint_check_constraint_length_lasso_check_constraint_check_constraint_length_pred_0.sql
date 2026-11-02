-- Schema DDL
CREATE TABLE Accounts (account_id INTEGER PRIMARY KEY, code TEXT(10) CHECK (LENGTH(code) = 5));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Accounts (account_id, code) VALUES (10, 'ABCDD');
INSERT INTO Accounts (account_id, code) VALUES (20, 'ABCDE');
INSERT INTO Accounts (account_id, code) VALUES (30, 'ABCDF');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM Accounts WHERE code = 'ABCDE';

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT account_id FROM Accounts WHERE code = 'VWXYZ';

/*
Prediction Result:
*/