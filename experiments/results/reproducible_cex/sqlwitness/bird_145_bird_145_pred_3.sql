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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default1', 'VYBER KARTOU', 'default1', '1998', '%Y', '1998', 1, 12, 11.0, 11, 12.0, 1.0, 1, 11, 1), (0, '1998', 'default2', 'default1', 'VYBER KARTOU', 'VYBER KARTOU', '%Y', 1, 11, 1.0, 12, NULL, 1.0, 13, 13, 12), (12, '%Y', 'default1', '%Y', 'default2', 'default1', 'default1', 11, 1, 12.0, 1, 1.0, 11.0, 11, 0, 0), (13, '%Y', 'default1', 'default1', 'default2', 'default2', 'default1', 11, 0, 11.0, 1, NULL, 12.0, 0, 11, 13), (11, 'default2', '%Y', 'default1', '%Y', 'default1', 'VYBER KARTOU', 0, 0, 11.0, 13, 11.0, 1.0, 13, NULL, 12), (2, 'VYBER KARTOU', 'default2', 'default1', 'VYBER KARTOU', 'default2', '1998', 0, 12, 13.0, 0, 11.0, 0.0, 11, 12, 12), (3, 'default1', 'default1', 'VYBER KARTOU', 'default1', 'VYBER KARTOU', 'default2', 12, 12, 11.0, 12, NULL, 1.0, 13, 0, 13), (4, '%Y', '%Y', 'default1', 'default2', 'VYBER KARTOU', 'default1', 11, 12, 1.0, 11, 12.0, 13.0, 1, 0, 11), (5, '%Y', 'default1', 'default1', '1998', 'default2', 'default1', 11, 1, 12.0, 1, 11.0, 0.0, 12, NULL, 13), (6, '1998', '1998', 'VYBER KARTOU', '1998', '1998', '1998', 11, 13, 13.0, 13, 1.0, 12.0, 11, 0, 11), (7, 'default1', '%Y', '1998', 'VYBER KARTOU', 'default2', '1998', 13, 1, 1.0, 12, 1.0, 0.0, 1, 11, 0), (8, 'VYBER KARTOU', '1998', '%Y', 'default1', '%Y', 'default2', 0, 12, 1.0, 1, 0.0, 13.0, 11, NULL, 1), (9, 'default1', 'default1', '1998', 'VYBER KARTOU', '1998', '%Y', 11, 1, 11.0, 13, 13.0, 0.0, 13, 13, 11);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (13, 3, 'VYBER KARTOU', '2023-01-01'), (0, 4, '%Y', '2023-01-02'), (11, 2, '%Y', '1998-10-27'), (1, 6, 'VYBER KARTOU', '2023-01-01'), (12, 8, '%Y', '1998-10-27'), (2, 4, 'default2', '1998-10-27'), (3, 7, '1998', '1998-10-27'), (4, 1, '1998', '1998-10-27'), (5, 13, '%Y', '2023-01-01'), (6, 5, '1998', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 5, '1998-10-27', 'default1', 'VYBER KARTOU', 0, 12, '%Y', 'default1', 12), (12, 0, '1998-10-27', 'default1', 'default1', 11, 12, NULL, '1998', NULL), (11, 13, '1998-10-27', '%Y', '%Y', 12, 1, '1998', 'VYBER KARTOU', 13), (13, 0, '1998-10-27', '1998', 'default2', 0, 12, 'default1', '1998', 0), (0, 1, '2023-01-01', 'VYBER KARTOU', 'VYBER KARTOU', 0, 11, '1998', 'default2', 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1998' AND T1.operation = 'VYBER KARTOU' AND T1.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998');

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT account_id FROM trans WHERE STRFTIME('%Y', date) = '1998' AND operation = 'VYBER KARTOU' GROUP BY account_id HAVING SUM(amount) < (SELECT CAST(SUM(amount) AS REAL) / 12 FROM trans WHERE STRFTIME('%Y', date) = '1998' AND operation = 'VYBER KARTOU');

/*
Prediction Result:
*/