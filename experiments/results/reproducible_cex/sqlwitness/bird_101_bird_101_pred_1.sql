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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, '%Y', 'default1', 'default1', '1995', '%Y', 'default1', 1, 0, 0.0, 0, 0.0, 2.0, 1, NULL, 0), (2, '%Y', 'default2', 'default2', 'default2', 'default2', '%Y', 2, 2, 2.0, 2, NULL, 2.0, 0, 2, 0), (0, '1995-01-01', 'default2', '1995-01-01', '1995-01-01', '1995', 'default2', 1, 0, 0.0, 2, NULL, 2.0, 1, NULL, 0), (3, '1995-01-01', '1995', 'default1', '%Y', '1995-12-31', '1995', 1, 0, 0.0, 1, 2.0, 0.0, 0, NULL, 1), (4, '1995-01-01', '%Y', '1995-01-01', 'default2', 'default1', '1995', 2, 0, 0.0, 2, 2.0, 2.0, 0, 1, 0), (5, '1995-01-01', '1995-12-31', '1995-12-31', 'default2', '%Y', '1995-12-31', 2, 1, 0.0, 1, 0.0, 1.0, 0, NULL, 2), (6, '1995-12-31', '1995-12-31', '1995-12-31', 'default2', '1995-12-31', '1995-01-01', 0, 2, 2.0, 2, 2.0, 2.0, 2, NULL, 0), (7, 'default1', 'default2', '1995-01-01', '1995-12-31', '%Y', '%Y', 0, 0, 1.0, 0, NULL, 2.0, 1, 1, 1), (8, 'default1', 'default2', '%Y', '1995-01-01', 'default2', 'default2', 0, 2, 1.0, 0, NULL, 0.0, 0, NULL, 1), (9, '%Y', '%Y', '1995', 'default2', 'default2', 'default1', 1, 1, 1.0, 2, 1.0, 1.0, 2, NULL, 1), (10, '%Y', 'default2', 'default2', '%Y', 'default1', 'default2', 0, 1, 2.0, 0, 0.0, 0.0, 1, NULL, 0), (11, '1995-01-01', 'default1', 'default1', '1995-01-01', '1995-01-01', '1995-01-01', 2, 2, 2.0, 2, 2.0, 1.0, 2, 0, 2), (12, '1995', '1995-12-31', 'default1', 'default1', '%Y', 'default1', 0, 1, 0.0, 2, 0.0, 2.0, 1, 0, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 12, '1995-12-31', '2023-01-01'), (2, 10, '%Y', '1995-12-30'), (0, 10, '1995-01-01', '1995-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (1, 2, '1995-12-30', '1995-12-31', 'default2', 0, 2, '1995-01-01', 'default1', 1), (0, 1, '1995-01-01', '1995', 'default1', 1, 0, '1995-01-01', NULL, 1), (2, 1, '1995-10-27', '1995-01-01', '%Y', 2, 2, NULL, '1995', 0), (3, 1, '1995-10-27', 'default2', 'default2', 0, 1, 'default1', '1995-01-01', 1), (4, 1, '2023-01-01', '%Y', '%Y', 2, 2, '1995', '%Y', NULL), (5, 2, '1995-12-30', 'default1', NULL, 2, 2, '1995-12-31', '1995-12-31', NULL), (6, 1, '1995-10-27', '1995-12-31', '1995', 0, 2, '1995-12-31', '%Y', NULL), (7, 0, '1994-12-31', '1995-01-01', '1995', 2, 2, '1995-12-31', '1995-01-01', 0), (8, 1, '1995-12-30', '1995', NULL, 0, 0, 'default1', '%Y', NULL), (9, 1, '2023-01-01', '1995-12-31', 'default2', 1, 1, '1995-01-01', '1995-01-01', 2), (10, 2, '1995-01-01', '1995', '1995-01-01', 1, 1, NULL, 'default1', 1);
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (2, 1, 'default1', 0, 2.0, 'default1'), (0, 0, '1995-01-01', 1, 0.0, 'default2'), (1, 2, 'default2', 2, 2.0, '1995-12-31'), (3, 1, '1995', 0, 0.0, 'default2'), (4, 0, 'default2', 0, 0.0, '%Y'), (5, 0, '1995-01-01', 2, 2.0, '1995'), (6, 2, '1995-12-31', 0, 0.0, 'default2'), (7, 2, '1995', 0, 1.0, '1995-01-01'), (8, 1, '1995', 2, 2.0, '1995'), (9, 0, '%Y', 0, 0.0, 'default2'), (10, 2, '1995', 2, 0.0, '1995-12-31'), (11, 0, '%Y', 0, 2.0, '1995-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM trans WHERE STRFTIME('%Y', date) = '1995' ORDER BY date ASC, trans.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT account_id FROM trans WHERE date BETWEEN '1995-01-01' AND '1995-12-31' AND date = (SELECT MIN(date) FROM trans WHERE date BETWEEN '1995-01-01' AND '1995-12-31');

/*
Prediction Result:
(1,)
(2,)
*/