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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default1', '1998', 'VYBER KARTOU', 'default1', 'VYBER KARTOU', 'default2', 1, 0, 1.0, 1, 1.0, 1.0, 1, 0, 0), (0, '1998', '%Y', '1998', 'VYBER KARTOU', 'default2', '1998', 0, 1, 0.0, 1, NULL, 0.0, 0, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 1, '1998', '2023-01-01'), (0, 1, '%Y', '1998-10-27'), (2, 0, '1998', '1998-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 0, 'VYBER KARTOU', '2023-01-01'), (0, 0, '1998', '1998-10-27'), (2, 0, 'VYBER KARTOU', '1998-10-27'), (3, 1, 'VYBER KARTOU', '1998-10-27'), (4, 0, 'default2', '2023-01-02'), (5, 1, 'default2', '1998-10-27'), (6, 1, 'default2', '2023-01-01'), (7, 1, 'default2', '2023-01-01'), (8, 0, 'default1', '2023-01-01'), (9, 0, '%Y', '2023-01-02'), (10, 1, '%Y', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (0, 2, '2023-01-01', '%Y', 'VYBER KARTOU', 1, 0, '%Y', '1998', 0), (1, 8, '2023-01-01', '1998', 'default1', 0, 0, 'default1', '1998', 1), (2, 2, '1998-10-27', 'default1', 'default2', 1, 1, 'default2', NULL, 1), (3, 4, '2023-01-01', 'VYBER KARTOU', 'default1', 0, 1, '1998', NULL, NULL), (4, 7, '1998-10-27', 'VYBER KARTOU', 'VYBER KARTOU', 0, 0, 'default1', 'default1', 0), (5, 7, '1998-10-27', 'VYBER KARTOU', '%Y', 1, 0, 'default2', 'default2', 1), (6, 8, '2023-01-01', '1998', 'VYBER KARTOU', 1, 1, 'default1', 'default1', 0), (7, 2, '2023-01-01', 'VYBER KARTOU', 'VYBER KARTOU', 0, 0, NULL, '1998', 1), (8, 7, '1998-10-27', 'VYBER KARTOU', 'default1', 1, 0, 'VYBER KARTOU', 'default2', 0), (9, 10, '1998-10-27', 'VYBER KARTOU', 'default2', 0, 0, 'VYBER KARTOU', 'VYBER KARTOU', 1), (10, 9, '2023-01-02', '1998', NULL, 0, 0, 'default1', 'default2', 1), (11, 8, '2023-01-02', '1998', NULL, 1, 1, 'default2', 'default2', 0);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 8, 2, '1998'), (1, 5, 2, 'default2'), (2, 5, 2, '%Y'), (3, 4, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1998' AND T1.operation = 'VYBER KARTOU' AND T1.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998');

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT T1.disp_id FROM disp AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE T2.operation = 'VYBER KARTOU' AND STRFTIME('%Y', T2.date) = '1998' GROUP BY T1.disp_id HAVING AVG(T2.amount) < (SELECT AVG(amount) FROM trans WHERE operation = 'VYBER KARTOU' AND STRFTIME('%Y', date) = '1998');

/*
Prediction Result:
*/