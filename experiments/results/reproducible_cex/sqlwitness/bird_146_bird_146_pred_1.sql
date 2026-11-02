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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', 'F', 'F', 'OWNER', 'F', 'F', 0, 1, 1.0, 0, NULL, 1.0, 1, NULL, 0), (1, 'default1', 'F', 'default1', 'default1', 'default2', 'OWNER', 0, 0, 1.0, 0, NULL, 0.0, 0, 0, 0), (2, 'OWNER', 'F', 'default2', 'F', 'default2', 'default2', 1, 0, 0.0, 1, 1.0, 0.0, 0, 1, 1), (3, 'OWNER', 'OWNER', 'default1', 'default2', 'default2', 'default2', 1, 0, 0.0, 1, 1.0, 0.0, 0, 1, 0), (4, 'OWNER', 'default1', 'F', 'default1', 'OWNER', 'OWNER', 0, 1, 0.0, 0, 1.0, 1.0, 0, 1, 0), (5, 'F', 'F', 'F', 'F', 'F', 'default1', 1, 1, 1.0, 1, 1.0, 0.0, 1, NULL, 0), (6, 'default2', 'OWNER', 'OWNER', 'default1', 'default2', 'default1', 1, 1, 1.0, 0, 0.0, 0.0, 0, NULL, 0), (7, 'OWNER', 'F', 'F', 'F', 'default1', 'default2', 1, 1, 0.0, 0, 0.0, 1.0, 0, 0, 0), (8, 'default1', 'F', 'OWNER', 'default2', 'OWNER', 'default2', 0, 1, 0.0, 0, 1.0, 0.0, 0, 0, 0), (9, 'default2', 'default2', 'default1', 'F', 'OWNER', 'default2', 1, 1, 0.0, 0, 1.0, 1.0, 1, 1, 1), (10, 'F', 'F', 'default1', 'default1', 'OWNER', 'OWNER', 0, 0, 1.0, 1, NULL, 0.0, 1, 0, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 0, 'default1', '2023-01-01'), (0, 5, 'default2', '2023-01-02'), (2, 1, 'F', '2023-01-02'), (3, 0, 'F', '2023-01-01'), (4, 4, 'F', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 6, 'F', '2023-01-02'), (1, 9, 'default1', '2023-01-02'), (2, 7, 'OWNER', '2023-01-01'), (3, 4, 'default2', '2023-01-01'), (4, 8, 'default1', '2023-01-01'), (5, 1, 'OWNER', '2023-01-01'), (6, 7, 'OWNER', '2023-01-02'), (7, 10, 'OWNER', '2023-01-02'), (8, 4, 'OWNER', '2023-01-02'), (9, 10, 'F', '2023-01-01'), (10, 6, 'OWNER', '2023-01-02'), (11, 3, 'default2', '2023-01-02'), (12, 4, 'OWNER', '2023-01-02'), (13, 1, 'OWNER', '2023-01-02'), (14, 5, 'default1', '2023-01-01'), (15, 1, 'default1', '2023-01-02');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (1, 8, '2023-01-01', 0, 0, 1.0, 'default1'), (0, 12, '2023-01-01', 1, 1, 0.0, 'default2'), (2, 1, '2023-01-02', 1, 1, 0.0, 'F'), (3, 5, '2023-01-01', 1, 0, 1.0, 'default1'), (4, 13, '2023-01-02', 1, 1, 0.0, 'OWNER'), (5, 0, '2023-01-02', 1, 1, 0.0, 'default1'), (6, 7, '2023-01-01', 0, 0, 1.0, 'default2'), (7, 2, '2023-01-01', 0, 0, 1.0, 'default2');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (1, 8, 0, 'F'), (0, 1, 1, 'default2'), (2, 10, 1, 'F'), (3, 1, 4, 'default1'), (4, 1, 2, 'default2'), (5, 3, 1, 'F'), (6, 2, 1, 'OWNER'), (7, 1, 1, 'OWNER'), (8, 13, 1, 'OWNER'), (9, 6, 1, 'default2'), (10, 2, 4, 'default2'), (11, 4, 1, 'OWNER');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (0, 11, 'default2', '2023-01-02'), (1, 10, 'OWNER', '2023-01-02'), (2, 11, 'OWNER', '2023-01-01'), (3, 6, 'default1', '2023-01-01'), (4, 2, 'OWNER', '2023-01-01'), (5, 9, 'OWNER', '2023-01-01'), (6, 9, 'default2', '2023-01-02'), (7, 6, 'default1', '2023-01-01'), (8, 0, 'default1', '2023-01-01'), (9, 11, 'default1', '2023-01-02'), (10, 5, 'default1', '2023-01-02'), (11, 7, 'OWNER', '2023-01-01'), (12, 10, 'OWNER', '2023-01-01'), (13, 0, 'OWNER', '2023-01-02'), (14, 6, 'default1', '2023-01-01'), (15, 7, 'F', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id INNER JOIN card AS T4 ON T2.disp_id = T4.disp_id WHERE T1.gender = 'F';

/*
Gold Result:
(4,)
(4,)
*/

-- Prediction Query
SELECT client.client_id FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN card ON disp.disp_id = card.disp_id INNER JOIN loan ON disp.account_id = loan.account_id WHERE client.gender = 'F' AND disp.type = 'OWNER';

/*
Prediction Result:
*/