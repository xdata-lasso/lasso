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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (2, 'default2', 'default2', 'default1', '1993', 'default2', '%Y', 12, 1, 12.0, 11, 0.0, 13.0, 12, NULL, 12), (11, 'default2', 'default2', '1993-12-31', 'default1', 'default2', 'default1', 0, 11, 1.0, 12, 12.0, 13.0, 2, 2, 12), (12, '1993-12-31', '1993-01-01', 'default1', '1993-12-31', '1993', 'default2', 0, 13, 2.0, 12, 1.0, 11.0, 2, 1, 13), (1, '1993', '1993', '%Y', '1993-12-31', '1993-12-31', '1993-01-01', 0, 13, 11.0, 2, 13.0, 13.0, 13, 2, 2), (0, 'default1', 'default2', '%Y', '%Y', '1993', '1993-12-31', 13, 13, 0.0, 13, 13.0, 12.0, 0, 0, 0), (13, '1993-12-31', '1993', '1993-01-01', 'default2', '1993', '%Y', 13, 13, 0.0, 12, 11.0, 11.0, 2, 0, 12);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 11, '1993-12-31', '1993-01-01'), (11, 0, '1993', '1993-12-31'), (12, 12, '1993', '1993-12-31'), (13, 1, '1993-12-31', '1993-12-30'), (1, 1, '1993-12-31', '1993-10-27'), (2, 0, '1993', '2023-01-02'), (3, 0, 'default2', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (13, 0, '1993-12-31', '1993-12-31'), (12, 1, '1993-01-01', '1993-10-27'), (2, 2, '1993-01-01', '1993-01-01');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (13, 12, '1993-01-01', 1, 0.0, 'default2'), (1, 2, '1993-01-01', 2, 11.0, '1993-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (13, 12, '2023-01-01', 13, 1, 0.0, '1993'), (0, 12, '1993-12-31', 12, 2, 12.0, 'default1'), (12, 12, '1993-01-01', 0, 2, 12.0, 'default1'), (1, 12, '1993-12-31', 11, 12, 1.0, '1993-01-01'), (2, 2, '1993-01-02', 2, 11, 11.0, '1993'), (11, 12, '1993-10-27', 13, 13, 11.0, '%Y');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (2, 13, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1993' AND T1.duration = 12 ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.disp_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T2.duration > 12 AND T1."date" >= '1993-01-01' AND T1."date" <= '1993-12-31' ORDER BY T2.amount DESC, T1.account_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(12,)
*/