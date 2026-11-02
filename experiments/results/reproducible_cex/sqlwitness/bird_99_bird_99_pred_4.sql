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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (12, '%Y', '1993', 'default2', 'default2', '1993', 'default2', 0, 13, 12.0, 12, NULL, 12.0, 2, 12, 13), (0, '%Y', '1993', '1993', '%Y', '%Y', 'default1', 2, 11, 11.0, 12, 13.0, 12.0, 1, 2, 13), (13, '1993', 'default1', '1993', '1993', '1993', 'default2', 11, 1, 13.0, 11, 12.0, 11.0, 0, 13, 13), (11, '%Y', '1993', '1993', '%Y', 'default2', 'default1', 13, 12, 0.0, 13, 2.0, 11.0, 0, 12, 1), (1, 'default2', '%Y', '%Y', 'default1', 'default2', 'default2', 1, 0, 11.0, 12, NULL, 1.0, 12, 11, 13), (2, '1993', 'default2', '1993', '%Y', 'default1', '1993', 2, 0, 12.0, 1, 12.0, 12.0, 12, 2, 12), (3, '%Y', 'default2', '1993', 'default1', '1993', 'default2', 1, 2, 12.0, 12, 1.0, 12.0, 11, 12, 12), (4, '%Y', '1993', 'default1', '%Y', 'default1', '1993', 12, 12, 2.0, 11, 11.0, 0.0, 11, 2, 11);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (2, 3, '%Y', '2023-01-02'), (13, 4, '1993', '1993-10-27'), (11, 2, '%Y', '2023-01-02'), (1, 12, 'default2', '2023-01-01'), (0, 3, 'default2', '2023-01-01'), (12, 0, '%Y', '2023-01-01'), (3, 13, '1993', '1993-10-27'), (4, 11, 'default2', '1993-10-27'), (5, 13, '1993', '2023-01-02'), (6, 12, '1993', '1993-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'default1', '1993-10-27'), (2, 13, '%Y', '2023-01-01'), (12, 2, '%Y', '1993-10-27'), (13, 4, '1993', '1993-10-27'), (0, 2, 'default2', '1993-10-27'), (11, 1, 'default1', '1993-10-27'), (3, 2, 'default2', '2023-01-02'), (4, 1, 'default2', '2023-01-01'), (5, 4, 'default2', '2023-01-02'), (6, 13, 'default1', '2023-01-02');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (2, 13, '1993', 12, 0.0, 'default1'), (1, 13, '%Y', 11, 13.0, 'default2'), (11, 5, 'default1', 1, 1.0, 'default1'), (12, 5, 'default1', 11, 13.0, '1993'), (0, 6, 'default1', 1, 1.0, 'default2');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 0, '2023-01-01', 13, 13, 12.0, '%Y'), (12, 12, '2023-01-02', 13, 0, 13.0, 'default1'), (11, 12, '1993-10-27', 11, 0, 13.0, 'default1'), (0, 4, '2023-01-02', 11, 12, 2.0, '%Y'), (1, 6, '2023-01-02', 13, 0, 2.0, 'default1'), (13, 0, '2023-01-01', 13, 1, 0.0, 'default1'), (3, 6, '2023-01-01', 12, 2, 2.0, 'default1'), (4, 2, '2023-01-01', 0, 0, 1.0, 'default1');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (12, 3, 0, 'default2'), (2, 3, 4, 'default1'), (1, 2, 4, '%Y'), (13, 0, 12, 'default2'), (0, 4, 6, 'default2'), (11, 5, 4, '1993'), (3, 3, 1, '1993'), (4, 11, 6, 'default1'), (5, 13, 11, 'default2'), (6, 0, 12, '%Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1993' AND T1.duration = 12 ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.disp_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT acc.account_id FROM account AS acc JOIN loan AS ln ON acc.account_id = ln.account_id WHERE ln.duration > 12 AND ln.amount = (SELECT MAX(ln2.amount) FROM loan AS ln2 JOIN account AS acc2 ON ln2.account_id = acc2.account_id WHERE ln2.duration > 12 AND STRFTIME('%Y', acc2.date) = '1993') AND STRFTIME('%Y', acc.date) = '1993';

/*
Prediction Result:
(0,)
*/