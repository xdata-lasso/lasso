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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (8000, 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'OWNER', 'default2', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 1, 8999, 0.0, 8001, 9001.0, 7999.0, 8000, 0, 7999), (0, 'default2', 'POPLATEK MESICNE', 'OWNER', 'POPLATEK MESICNE', 'OWNER', 'OWNER', 9000, 1, 0.0, 8001, 9001.0, 1.0, 8000, 8001, 7999), (8999, 'default2', 'default2', 'default1', 'POPLATEK MESICNE', 'POPLATEK MESICNE', 'OWNER', 0, 8001, 8000.0, 7999, 9000.0, 7999.0, 0, 0, 7999), (9000, 'POPLATEK MESICNE', 'OWNER', 'default1', 'OWNER', 'OWNER', 'default1', 0, 8000, 7999.0, 8001, 8999.0, 0.0, 9001, 0, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (8999, 8999, 'default2', '2023-01-01'), (9000, 8999, 'POPLATEK MESICNE', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (8001, 8999, 'POPLATEK MESICNE', '2023-01-01'), (8000, 8999, 'POPLATEK MESICNE', '2023-01-01'), (9001, 0, 'POPLATEK MESICNE', '2023-01-02'), (7999, 0, 'default1', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (7999, 8001, 8999, 'default2'), (8000, 9001, 9000, 'POPLATEK MESICNE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.type FROM district AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T2.account_id = T3.account_id WHERE T3.type <> 'OWNER' AND T1.A11 BETWEEN 8000 AND 9000;

/*
Gold Result:
('POPLATEK MESICNE',)
*/

-- Prediction Query
SELECT DISTINCT account.frequency FROM account INNER JOIN disp ON account.district_id = disp.client_id INNER JOIN district ON disp.client_id = district.district_id WHERE account.frequency = 'POPLATEK MESICNE' AND disp.type = 'OWNER' AND district.A11 BETWEEN 8000 AND 9000;

/*
Prediction Result:
*/