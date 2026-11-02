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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, '1995', '1995-01-01', '1995', 'default1', '%Y', '1995-01-01', 2, 2, 2.0, 0, 0.0, 0.0, 0, 0, 2), (1, '1995-01-01', 'default2', 'default2', 'default2', '1995-01-01', '%Y', 2, 0, 0.0, 1, NULL, 2.0, 0, 1, 1), (2, '1995-01-01', '%Y', 'default1', '%Y', 'default2', '1995-12-31', 1, 0, 1.0, 1, 2.0, 2.0, 1, 1, 2), (3, '1995-01-01', '%Y', 'default2', '1995-12-31', 'default1', 'default2', 2, 2, 0.0, 1, NULL, 1.0, 0, 0, 2), (4, '1995', '1995-01-01', 'default2', '%Y', '1995-01-01', '1995-12-31', 1, 0, 2.0, 0, 0.0, 2.0, 1, NULL, 2), (5, '1995', '1995-01-01', 'default1', '1995', 'default1', '1995', 0, 0, 2.0, 1, 1.0, 0.0, 0, NULL, 2), (6, 'default1', '%Y', 'default1', 'default1', '1995-12-31', '1995-01-01', 0, 2, 2.0, 1, NULL, 1.0, 0, 1, 2);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 2, '1995', '1995-01-01'), (2, 5, '1995-12-31', '1995-12-31'), (0, 0, '1995', '1995-01-01'), (3, 6, '1995-12-31', '1995-01-01'), (4, 6, '1995', '1995-01-01'), (5, 1, '1995', '1995-01-01'), (6, 6, '%Y', '1995-01-01'), (7, 0, '1995-01-01', '2023-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 7, '2023-01-02', '1995-12-31', 'default1', 1, 1, '%Y', '1995', 1), (0, 4, '1995-01-02', 'default1', '1995-01-01', 1, 0, 'default1', '1995', 0), (2, 3, '1995-01-01', 'default2', '1995-12-31', 1, 2, '%Y', 'default1', 1), (3, 0, '1995-12-31', 'default2', 'default2', 2, 0, NULL, 'default1', 2), (4, 4, '1994-12-31', '1995', 'default2', 2, 2, '1995', '1995-12-31', NULL), (5, 2, '2023-01-02', '1995-12-31', '1995-01-01', 0, 1, NULL, '1995-01-01', 2), (6, 1, '1995-01-02', 'default1', '1995-12-31', 2, 1, 'default2', 'default2', 0), (7, 7, '2023-01-02', '1995', '%Y', 0, 0, '1995-12-31', '1995-12-31', 0), (8, 0, '1995-12-31', 'default1', 'default1', 2, 1, '1995', '1995-12-31', NULL), (9, 5, '1996-01-01', '1995', '1995-01-01', 1, 0, '1995-01-01', NULL, NULL), (10, 1, '1995-01-01', '1995-01-01', '1995-12-31', 0, 1, '%Y', '%Y', 0), (11, 7, '1996-01-01', 'default2', '%Y', 1, 0, '1995', 'default1', 0), (12, 1, '1995-12-30', '%Y', 'default2', 1, 0, '%Y', 'default1', 1);
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 4, '%Y', 0, 2.0, '1995'), (0, 0, 'default1', 1, 2.0, '1995-12-31'), (2, 5, '%Y', 1, 0.0, '1995');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM trans WHERE STRFTIME('%Y', date) = '1995' ORDER BY date ASC, trans.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT account_id FROM trans WHERE date = (SELECT MIN(date) FROM trans WHERE date BETWEEN '1995-01-01' AND '1995-12-31');

/*
Prediction Result:
(3,)
(1,)
*/