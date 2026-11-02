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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'gold', 'default2', 'gold', '%Y', 'OWNER', 'default2', 1, 0, 0.0, 0, 1.0, 0.0, 1, NULL, 0), (0, 'gold', 'OWNER', '%Y', '2025-01-01 00:00:00', 'default1', 'default1', 0, 0, 0.0, 1, NULL, 0.0, 0, NULL, 0), (2, 'OWNER', 'gold', '2025-01-01 00:00:00', 'default2', 'default2', '%Y', 1, 0, 0.0, 0, NULL, 1.0, 0, 1, 0), (3, 'default2', '2025-01-01 00:00:00', 'default1', 'default1', 'default1', 'gold', 0, 0, 1.0, 1, 0.0, 1.0, 1, 1, 1), (4, 'default2', '2025-01-01 00:00:00', 'gold', 'gold', 'default2', 'default2', 0, 1, 0.0, 1, NULL, 0.0, 1, 0, 1), (5, 'gold', 'gold', '2025-01-01 00:00:00', '%Y', '%Y', '2025-01-01 00:00:00', 0, 0, 1.0, 0, 1.0, 0.0, 0, 0, 0), (6, '%Y', '%Y', 'OWNER', '%Y', 'gold', 'OWNER', 1, 0, 0.0, 1, 1.0, 0.0, 1, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (0, 1, 'default1', '2023-01-02'), (1, 2, 'OWNER', '2023-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 2, 'default2', '2023-01-01'), (1, 2, 'OWNER', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 1, 0, '%Y'), (1, 1, 1, 'OWNER'), (2, 0, 1, 'OWNER'), (3, 1, 1, '%Y'), (4, 1, 0, 'default2');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (1, 3, '2025-01-01 00:00:00', '2023-01-02'), (0, 1, 'gold', '2025-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T3.birth_date) FROM disp AS T1 INNER JOIN card AS T2 ON T2.disp_id = T1.disp_id INNER JOIN client AS T3 ON T1.client_id = T3.client_id WHERE T2.type = 'gold' AND T1.type = 'OWNER';

/*
Gold Result:
(1, 2)
*/

-- Prediction Query
SELECT client.client_id, client.birth_date FROM card INNER JOIN disp ON card.disp_id = disp.disp_id INNER JOIN client ON disp.client_id = client.client_id WHERE card.type = 'gold' AND disp.type = 'OWNER';

/*
Prediction Result:
(1, '2023-01-02')
*/