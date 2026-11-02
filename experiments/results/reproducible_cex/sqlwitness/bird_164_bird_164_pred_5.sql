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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (32424, 'default2', 'default2', 'default1', 'default2', 'default1', 'default2', 32424, 32423, 32422.0, 1, NULL, 32423.0, 1, 32423, 0), (1, 'default1', 'default2', 'default1', 'default1', 'default2', 'default2', 0, 32424, 1.0, 32422, 32423.0, 32422.0, 32424, 0, 1), (32423, 'default2', 'default2', 'default2', 'default1', 'default1', 'default1', 0, 32423, 32422.0, 1, 0.0, 32422.0, 32424, 32424, 0), (32422, 'default2', 'default2', 'default1', 'default2', 'default2', 'default1', 32423, 32423, 32422.0, 0, 32424.0, 1.0, 32423, 1, 32424);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (32423, 32424, 'default1', '2023-01-02'), (32424, 32422, 'default1', '2023-01-02'), (32422, 32422, 'default1', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 32422, 'default2', '2023-01-02'), (32422, 1, 'default2', '2023-01-01');
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (32423, 32422, 'default2', 32424, 1.0, 'default2'), (32424, 32422, 'default2', 32424, 0.0, 'default1');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (32423, 1, 32423, 'default1'), (1, 32422, 32424, 'default2'), (0, 32422, 32424, 'default2'), (32422, 32422, 32423, 'default1'), (32424, 32422, 32423, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.client_id FROM "order" AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE T1.order_id = 32423;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.gender FROM client AS T1 LEFT JOIN disp AS T2 ON T1.client_id = T2.client_id LEFT JOIN "order" AS T3 ON T2.account_id = T3.account_id WHERE T3.order_id = 32423;

/*
Prediction Result:
('default1',)
('default1',)
('default1',)
('default1',)
*/