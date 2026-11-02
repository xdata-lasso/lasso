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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default2', 'default1', 'default1', 'default1', 'default1', 'default1', 1, 0, 991.0, 992, 993.0, 993.0, 1, 991, 992), (992, 'default1', 'default1', 'default2', 'default1', 'default2', 'default2', 1, 993, 1.0, 1, 991.0, 991.0, 992, 0, 991), (993, 'default1', 'default1', 'default1', 'default1', 'default1', 'default1', 0, 0, 992.0, 991, 992.0, 991.0, 991, 993, 992), (991, 'default2', 'default1', 'default1', 'default1', 'default1', 'default1', 992, 993, 1.0, 991, 992.0, 991.0, 0, NULL, 1), (1, 'default2', 'default1', 'default2', 'default1', 'default1', 'default1', 991, 0, 991.0, 0, 993.0, 993.0, 992, 992, 993);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (992, 1, 'default1', '2023-01-01'), (993, 991, 'default1', '2023-01-01'), (1, 993, 'default1', '2023-01-01'), (991, 1, 'default1', '2023-01-01'), (0, 993, 'default1', '2023-01-01'), (2, 1, 'default2', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (992, 992, 'default1', '2023-01-02'), (993, 0, 'default2', '2023-01-02'), (0, 991, 'default1', '2023-01-01'), (1, 992, 'default1', '2023-01-02'), (991, 993, 'default2', '2023-01-01'), (2, 991, 'default2', '2023-01-01'), (3, 0, 'default2', '2023-01-01'), (4, 0, 'default1', '2023-01-02'), (5, 991, 'default1', '2023-01-01'), (6, 993, 'default1', '2023-01-02'), (7, 992, 'default1', '2023-01-01');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 6, '2023-01-01', 993, 991, 0.0, 'default2'), (993, 992, '2023-01-02', 993, 993, 993.0, 'default2'), (991, 992, '2023-01-02', 0, 0, 0.0, 'default1'), (0, 6, '2023-01-01', 0, 991, 1.0, 'default2'), (992, 2, '2023-01-02', 992, 992, 992.0, 'default2'), (2, 4, '2023-01-02', 991, 992, 1.0, 'default1'), (3, 4, '2023-01-01', 991, 0, 1.0, 'default2'), (4, 992, '2023-01-01', 0, 991, 0.0, 'default1'), (5, 993, '2023-01-01', 0, 991, 0.0, 'default1'), (6, 993, '2023-01-01', 991, 991, 1.0, 'default1'), (7, 992, '2023-01-01', 0, 1, 992.0, 'default2'), (8, 992, '2023-01-02', 0, 0, 1.0, 'default2'), (9, 0, '2023-01-01', 993, 993, 0.0, 'default2'), (10, 5, '2023-01-02', 991, 1, 991.0, 'default2');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (992, 0, 993, 'default1'), (1, 5, 0, 'default2'), (0, 2, 0, 'default1'), (991, 1, 2, 'default2'), (993, 4, 992, 'default2'), (2, 2, 0, 'default2'), (3, 992, 991, 'default1'), (4, 3, 1, 'default1'), (5, 4, 993, 'default1'), (6, 5, 0, 'default2'), (7, 6, 992, 'default1'), (8, 0, 992, 'default1'), (9, 6, 2, 'default2'), (10, 991, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.amount, T3.status FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id WHERE T1.client_id = 992;

/*
Gold Result:
*/

-- Prediction Query
SELECT loan.amount, loan.status FROM loan INNER JOIN disp ON loan.account_id = disp.account_id WHERE disp.client_id = 992;

/*
Prediction Result:
(0, 'default2')
(993, 'default2')
(993, 'default2')
(991, 'default1')
(991, 'default2')
*/