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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', '%Y', 'A', 'A', 'default2', '1993', 2, 0, 1.0, 13, 11.0, 12.0, 11, 1, 2), (2, 'default2', 'A', '1993', '1993', 'A', 'default1', 0, 1, 2.0, 13, NULL, 13.0, 2, 12, 11), (12, 'default1', 'default2', 'default2', '%Y', 'A', 'default1', 0, 2, 0.0, 1, 0.0, 13.0, 13, 2, 1), (0, 'A', '%Y', 'A', 'default1', 'default2', 'default1', 11, 0, 1.0, 2, 12.0, 1.0, 12, NULL, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (13, 1, 'A', '2023-01-01'), (0, 1, '1993', '2023-01-02'), (12, 1, '%Y', '1993-10-27'), (1, 12, 'A', '1993-10-27'), (11, 1, 'default2', '2023-01-02'), (2, 2, '%Y', '2023-01-01'), (3, 12, 'default2', '2023-01-01'), (4, 1, 'default1', '2023-01-01'), (5, 1, 'default1', '2023-01-01'), (6, 12, '1993', '1993-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (11, 12, 'A', '2023-01-02'), (13, 2, 'A', '2023-01-02'), (0, 12, 'default1', '1993-10-27'), (1, 12, 'default1', '2023-01-01'), (2, 2, 'A', '2023-01-01'), (12, 0, '%Y', '1993-10-27');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (1, 13, 'default2', 11, 1.0, '1993'), (12, 0, '%Y', 1, 13.0, '1993'), (2, 12, 'A', 13, 2.0, 'default1'), (0, 0, '1993', 13, 2.0, '1993'), (11, 0, 'default1', 0, 0.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (2, 0, '1993-10-27', 1, 12, 12.0, '%Y'), (11, 0, '1993-10-27', 13, 12, 1.0, '1993'), (12, 0, '2023-01-01', 1, 12, 0.0, '1993'), (0, 13, '2023-01-02', 1, 13, 12.0, 'default2'), (13, 11, '1993-10-27', 0, 11, 0.0, 'default1'), (1, 12, '2023-01-01', 1, 11, 12.0, 'default2'), (3, 13, '2023-01-02', 2, 2, 11.0, '1993'), (4, 2, '1993-10-27', 12, 13, 2.0, '1993'), (5, 2, '2023-01-01', 12, 2, 13.0, 'default2'), (6, 0, '2023-01-02', 13, 2, 13.0, 'default2'), (7, 0, '2023-01-01', 1, 1, 1.0, 'default1'), (8, 1, '2023-01-02', 0, 13, 0.0, '1993'), (9, 1, '1993-10-27', 2, 13, 1.0, 'default2'), (10, 1, '2023-01-02', 11, 13, 0.0, '%Y'), (14, 11, '2023-01-01', 0, 2, 12.0, 'default2'), (15, 12, '2023-01-02', 0, 11, 1.0, 'default2'), (16, 2, '1993-10-27', 12, 2, 1.0, '1993'), (17, 13, '2023-01-02', 1, 12, 13.0, '%Y'), (18, 1, '2023-01-01', 2, 1, 12.0, '%Y'), (19, 0, '1993-10-27', 13, 1, 11.0, '%Y'), (20, 12, '2023-01-02', 1, 11, 2.0, 'default1'), (21, 2, '1993-10-27', 11, 11, 12.0, '1993'), (22, 13, '2023-01-02', 1, 12, 12.0, '%Y'), (23, 13, '2023-01-01', 0, 11, 12.0, 'default1'), (24, 0, '2023-01-02', 11, 2, 11.0, 'A'), (25, 13, '2023-01-02', 13, 12, 11.0, '1993'), (26, 1, '2023-01-01', 13, 12, 1.0, 'default2');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (2, 12, 1, '%Y'), (12, 0, 11, '1993'), (11, 11, 4, 'A'), (1, 11, 3, 'A'), (13, 0, 12, '1993'), (0, 12, 6, 'default2'), (3, 11, 1, '%Y'), (4, 12, 5, 'default1'), (5, 12, 1, 'A'), (6, 2, 6, '1993'), (7, 11, 11, '1993'), (8, 2, 13, 'A'), (9, 11, 3, 'default2'), (10, 0, 4, 'A'), (14, 12, 5, 'A'), (15, 13, 5, 'default1'), (16, 13, 1, 'A'), (17, 0, 12, 'default1'), (18, 11, 12, 'A'), (19, 0, 2, 'default1'), (20, 13, 4, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1993' AND T1.duration = 12 ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.disp_id NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT account.account_id FROM loan INNER JOIN account ON loan.account_id = account.account_id WHERE loan.duration > 12 AND loan.status = 'A' AND STRFTIME('%Y', account.date) = '1993' ORDER BY loan.amount DESC, loan.loan_id NULLS LAST, account.account_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/