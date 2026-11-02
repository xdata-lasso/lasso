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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, '%Y', '1997-12-31', '%Y', '1997', '1997-12-31', 'default1', 10000, 1, 10001.0, 10001, 9999.0, 0.0, 0, NULL, 0), (9999, '1997', 'default1', '1997', '%Y', '1997-12-31', 'default1', 10000, 10001, 9999.0, 9999, 10001.0, 9999.0, 10000, 10001, 0), (10000, 'default2', '%Y', '1997-12-31', 'default1', '%Y', 'default1', 10000, 10001, 0.0, 10001, 10000.0, 0.0, 10000, 9999, 0);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (9999, 9999, 'default1', '1997-01-01'), (10001, 1, '%Y', '2023-01-02'), (10000, 10000, '%Y', '1997-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (10001, 9999, '1997-12-31', 'default2', '%Y', 9999, 9999, 'default1', '1997-12-31', 10001), (9999, 10001, '1997-12-30', '%Y', '1997', 9999, 9999, '1997-01-01', '1997-01-01', 0), (0, 10001, '2023-01-02', '1997', 'default1', 10000, 10001, '1997-12-31', 'default2', 10000), (1, 10000, '2023-01-02', 'default1', 'default1', 9999, 10000, NULL, 'default2', 10000), (10000, 9999, '1997-12-30', '%Y', '1997', 9999, 10001, '%Y', 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.district_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T1.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '1997' GROUP BY T1.district_id HAVING SUM(T3.amount) > 10000;

/*
Gold Result:
(9999,)
*/

-- Prediction Query
SELECT T1.A2 AS district_name FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE T3.date BETWEEN '1997-01-01' AND '1997-12-31' GROUP BY T1.A2 HAVING SUM(T3.amount) > 10000;

/*
Prediction Result:
('1997',)
*/