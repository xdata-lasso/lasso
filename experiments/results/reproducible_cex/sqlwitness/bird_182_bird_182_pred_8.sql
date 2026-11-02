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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', '1974', '1976', 'default2', 'SIPO', '1976', 1, 1, 0.0, 4001, 1.0, 4001.0, 1, 4000, 4000), (4000, 'SIPO', '%Y', '1974', '%Y', '1976', 'default1', 4001, 4000, 3999.0, 4001, 4000.0, 4001.0, 4000, 4000, 3999), (4001, 'default2', '1976', 'M', '1974', 'default2', '1974', 3999, 4000, 1.0, 3999, 3999.0, 4001.0, 0, 0, 4001), (0, 'M', '1974', '%Y', 'default1', 'default1', 'SIPO', 3999, 3999, 4000.0, 1, 4001.0, 4000.0, 1, 4001, 0), (3999, '1976', '1974', '%Y', 'default2', 'M', 'default1', 3999, 3999, 4001.0, 0, 1.0, 0.0, 3999, 3999, 0), (2, '1976', 'SIPO', '%Y', '1974', '1974', '1976', 1, 4001, 0.0, 4001, 0.0, 1.0, 4001, 4001, 0), (3, '1974', '1976', 'SIPO', 'default1', 'default2', 'default1', 0, 4000, 4001.0, 4000, 4000.0, 4001.0, 4001, 4001, 0), (4, '1974', 'default1', 'SIPO', '%Y', '1976', 'SIPO', 1, 1, 1.0, 4001, 0.0, 3999.0, 4001, 4001, 3999), (5, 'M', '1976', 'SIPO', 'default1', '1974', 'default1', 1, 0, 3999.0, 3999, 4000.0, 3999.0, 3999, 3999, 0), (6, 'M', '%Y', 'M', 'default1', 'M', 'default2', 4000, 1, 1.0, 4001, 3999.0, 0.0, 3999, 3999, 4000), (7, 'SIPO', '1976', '%Y', 'default2', '1976', 'default1', 3999, 3999, 3999.0, 3999, 4001.0, 4001.0, 4001, 3999, 1), (8, '1976', '%Y', '1976', '1976', 'SIPO', 'M', 0, 4000, 3999.0, 3999, 0.0, 4001.0, 3999, 0, 4001), (9, 'default2', 'M', 'M', '%Y', '1976', 'M', 4001, 4000, 4000.0, 0, 1.0, 1.0, 1, 4000, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (4001, 3999, '1974', '2023-01-02'), (3999, 4001, 'M', '1974-10-27'), (4000, 5, 'M', '1976-10-27'), (0, 3999, 'SIPO', '2023-01-02'), (1, 9, 'default1', '1974-10-27'), (2, 3999, '%Y', '1974-10-27'), (3, 4, 'M', '1974-10-27'), (4, 4000, '1976', '2023-01-01'), (5, 8, 'M', '1974-10-27'), (6, 6, 'M', '2023-01-01'), (7, 2, 'SIPO', '1976-10-27'), (8, 2, 'SIPO', '2023-01-01'), (9, 9, '1974', '1974-10-27'), (10, 9, 'default1', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (4000, 5, '1974', '2023-01-02'), (1, 2, 'M', '1974-10-27'), (3999, 6, 'SIPO', '2023-01-01'), (4001, 5, 'default2', '1976-10-27'), (0, 4001, 'M', '2023-01-01'), (2, 6, 'SIPO', '1974-10-27'), (3, 6, '%Y', '1974-10-27'), (4, 8, '1974', '1976-10-27'), (5, 7, 'default1', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (0, 0, '2023-01-01', '1974', '1976', 4001, 1, '1974', '1976', NULL), (1, 4, '2023-01-01', '%Y', NULL, 1, 1, 'SIPO', 'M', 3999), (4001, 3999, '1976-10-27', 'default2', 'SIPO', 0, 4000, '1974', 'M', 0), (4000, 3, '1976-10-27', '1976', 'SIPO', 3999, 4000, '1976', '1976', 4001), (3999, 5, '1974-10-27', 'default1', '%Y', 1, 4000, 'M', '1976', NULL), (2, 4, '1974-10-27', '1974', '1974', 4001, 4001, 'SIPO', '1976', 0), (3, 4000, '2023-01-01', '1974', 'M', 4001, 4001, NULL, 'default2', 4000), (4, 4001, '2023-01-02', 'M', 'default2', 4000, 3999, 'default2', 'default2', 4000), (5, 4, '1976-10-27', 'default1', NULL, 1, 0, NULL, '1976', 0), (6, 5, '1976-10-27', '%Y', '%Y', 1, 0, 'SIPO', 'M', 4001), (7, 4000, '2023-01-02', 'SIPO', NULL, 1, 0, '%Y', 'M', 4001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE STRFTIME('%Y', T3.birth_date) BETWEEN '1974' AND '1976' AND T3.gender = 'M' AND T1.amount > 4000 AND T1.k_symbol = 'SIPO';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM client AS T1 JOIN trans AS T2 ON T1.client_id = T2.account_id WHERE T1.gender = 'M' AND STRFTIME('%Y', T1.birth_date) BETWEEN '1974' AND '1976' AND T2.amount > 4000 AND T2.k_symbol = 'SIPO';

/*
Prediction Result:
(0,)
*/