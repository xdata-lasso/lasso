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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (131, 'default2', 'default1', 'default1', 'default1', '%Y', '%Y', 130, 131, 130.0, 0, 129.0, 131.0, 131, 129, 129), (0, '%Y', 'default1', '%Y', 'default2', '%Y', 'default1', 0, 129, 0.0, 129, 0.0, 129.0, 0, 129, 1), (1, 'default1', '%Y', 'default2', 'default2', 'default2', 'default2', 130, 1, 131.0, 131, 131.0, 130.0, 0, 129, 1), (129, 'default2', 'default1', '%Y', 'default2', 'default2', '%Y', 0, 129, 129.0, 1, 129.0, 131.0, 129, 1, 1), (130, 'default1', '%Y', '%Y', '%Y', 'default1', 'default1', 131, 129, 129.0, 129, 0.0, 0.0, 130, 131, 131), (2, 'default1', 'default2', 'default2', '%Y', 'default1', '%Y', 129, 131, 131.0, 130, 130.0, 130.0, 1, 1, 129), (3, '%Y', 'default2', '%Y', '%Y', 'default2', 'default2', 131, 0, 129.0, 130, 131.0, 129.0, 0, 131, 1), (4, '%Y', 'default1', 'default2', 'default1', 'default2', 'default1', 1, 131, 129.0, 129, 131.0, 129.0, 131, 129, 129), (5, 'default1', 'default2', 'default2', '%Y', 'default1', '%Y', 131, 130, 131.0, 1, 1.0, 0.0, 130, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 1, 'default1', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'default2', '2023-01-01'), (130, 4, '%Y', '2023-01-02'), (129, 1, '%Y', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (129, 1, 1, '%Y'), (1, 129, 1, 'default2'), (0, 129, 1, 'default2'), (130, 130, 1, '%Y'), (131, 129, 1, 'default1'), (2, 130, 1, '%Y'), (3, 129, 1, '%Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STRFTIME('%Y', T1.birth_date) FROM client AS T1 INNER JOIN disp AS T3 ON T1.client_id = T3.client_id INNER JOIN account AS T2 ON T3.account_id = T2.account_id WHERE T2.account_id = 130;

/*
Gold Result:
('2023',)
('2023',)
*/

-- Prediction Query
SELECT birth_date FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id WHERE T2.account_id = 130;

/*
Prediction Result:
('2023-01-01',)
('2023-01-01',)
*/