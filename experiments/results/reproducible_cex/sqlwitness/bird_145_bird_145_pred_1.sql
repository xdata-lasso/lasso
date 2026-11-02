-- Schema DDL
CREATE TABLE account (account_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, district_id INTEGER DEFAULT 0 NOT NULL, frequency TEXT NOT NULL, date DATE NOT NULL, FOREIGN KEY (district_id) REFERENCES district (district_id));

CREATE TABLE card (card_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, disp_id INTEGER NOT NULL, type TEXT NOT NULL, issued DATE NOT NULL, FOREIGN KEY (disp_id) REFERENCES disp (disp_id));

CREATE TABLE client (client_id INTEGER NOT NULL PRIMARY KEY, gender TEXT NOT NULL, birth_date DATE NOT NULL, district_id INTEGER NOT NULL, FOREIGN KEY (district_id) REFERENCES district (district_id));

CREATE TABLE disp (disp_id INTEGER NOT NULL PRIMARY KEY, client_id INTEGER NOT NULL, account_id INTEGER NOT NULL, type TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id), FOREIGN KEY (client_id) REFERENCES client (client_id));

CREATE TABLE district (district_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, A2 TEXT NOT NULL, A3 TEXT NOT NULL, A4 TEXT NOT NULL, A5 TEXT NOT NULL, A6 TEXT NOT NULL, A7 TEXT NOT NULL, A8 INTEGER NOT NULL, A9 INTEGER NOT NULL, A10 REAL NOT NULL, A11 INTEGER NOT NULL, A12 REAL NULL, A13 REAL NOT NULL, A14 INTEGER NOT NULL, A15 INTEGER NULL, A16 INTEGER NOT NULL);

CREATE TABLE loan (loan_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER NOT NULL, date DATE NOT NULL, amount INTEGER NOT NULL, duration INTEGER NOT NULL, payments REAL NOT NULL, status TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

CREATE TABLE "order" (order_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER NOT NULL, bank_to TEXT NOT NULL, account_to INTEGER NOT NULL, amount REAL NOT NULL, k_symbol TEXT NOT NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

CREATE TABLE trans (trans_id INTEGER DEFAULT 0 NOT NULL PRIMARY KEY, account_id INTEGER DEFAULT 0 NOT NULL, date DATE NOT NULL, type TEXT NOT NULL, operation TEXT NULL, amount INTEGER NOT NULL, balance INTEGER NOT NULL, k_symbol TEXT NULL, bank TEXT NULL, account INTEGER NULL, FOREIGN KEY (account_id) REFERENCES account (account_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default2', 'default1', 'default2', '1998', '1998-01-01', '1998-12-31', 0, 1, 0.0, 1, NULL, 1.0, 0, NULL, 1), (1, 'VYBER KARTOU', '%Y', '1998', '1998-12-31', 'default1', '1998', 1, 1, 1.0, 1, NULL, 0.0, 0, NULL, 1), (2, 'default1', '1998-12-31', 'default1', 'VYBER KARTOU', 'VYBER KARTOU', '%Y', 0, 0, 1.0, 1, NULL, 0.0, 1, NULL, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 0, 'default2', '2023-01-02'), (0, 0, '1998', '1998-12-31'), (2, 1, '1998-01-01', '1999-01-01'), (3, 2, 'VYBER KARTOU', '1998-12-30'), (4, 2, '%Y', '1998-10-27'), (5, 1, 'VYBER KARTOU', '1998-12-31'), (6, 2, 'default2', '1998-01-01'), (7, 2, 'default1', '1998-01-01'), (8, 0, '1998-01-01', '2023-01-01'), (9, 0, '1998-12-31', '1999-01-01'), (10, 0, 'default1', '1998-10-27');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 8, '1997-12-31', 'default2', 'default2', 1, 1, NULL, '1998-12-31', 0), (0, 8, '1997-12-31', '1998', 'default1', 1, 0, '1998-12-31', 'default2', NULL), (2, 3, '1998-12-30', '1998-01-01', NULL, 0, 0, 'default1', '1998-01-01', 0), (3, 1, '2023-01-02', '1998-12-31', NULL, 0, 1, 'VYBER KARTOU', '1998-01-01', 1), (4, 5, '1998-12-30', '1998-12-31', 'VYBER KARTOU', 0, 0, '1998-12-31', '%Y', 1), (5, 1, '1998-12-31', 'default1', '1998', 0, 1, '1998-01-01', NULL, NULL), (6, 1, '1998-12-30', 'default1', 'default2', 1, 0, '1998-12-31', 'default1', 1), (7, 7, '1998-12-30', 'default2', '1998-01-01', 0, 0, 'default2', '1998-12-31', 1), (8, 5, '1998-12-31', '1998-12-31', 'default2', 1, 0, '1998', 'VYBER KARTOU', 0), (9, 0, '1998-01-02', '1998-01-01', 'default1', 1, 1, '1998-01-01', '1998-01-01', 1), (10, 7, '1997-12-31', 'VYBER KARTOU', '1998-12-31', 1, 0, '1998', 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1998' AND T1.operation = 'VYBER KARTOU' AND T1.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998');

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT account_id FROM trans WHERE operation = 'VYBER KARTOU' AND date BETWEEN '1998-01-01' AND '1998-12-31' AND amount < (SELECT AVG(amount) FROM trans WHERE operation = 'VYBER KARTOU' AND date BETWEEN '1998-01-01' AND '1998-12-31');

/*
Prediction Result:
*/