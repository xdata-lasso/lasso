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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'F', 'F', 'default1', 'default2', 'default1', 'F', 0, 1, 1.0, 0, 0.0, 1.0, 1, 0, 0), (0, 'junior', 'default2', 'default2', 'junior', 'default2', 'default2', 1, 0, 1.0, 1, 1.0, 1.0, 1, NULL, 0), (2, 'default2', 'default2', 'F', 'junior', 'junior', 'F', 1, 1, 0.0, 0, 0.0, 0.0, 1, 0, 0), (3, 'default1', 'default1', 'F', 'default1', 'default1', 'default1', 1, 1, 0.0, 0, NULL, 0.0, 1, NULL, 1), (4, 'default1', 'default2', 'default1', 'default1', 'default1', 'default2', 1, 1, 0.0, 0, 0.0, 1.0, 0, 1, 0), (5, 'default2', 'junior', 'F', 'default2', 'default2', 'default2', 0, 1, 1.0, 1, 1.0, 1.0, 0, 1, 1), (6, 'default2', 'default1', 'F', 'junior', 'default2', 'default2', 1, 0, 1.0, 0, 0.0, 1.0, 1, NULL, 1), (7, 'F', 'default1', 'default2', 'junior', 'F', 'junior', 0, 1, 1.0, 1, 0.0, 1.0, 1, 1, 0), (8, 'default2', 'default2', 'junior', 'default1', 'junior', 'default2', 1, 1, 0.0, 0, 1.0, 0.0, 0, 1, 1), (9, 'default2', 'F', 'default1', 'F', 'junior', 'default1', 1, 0, 1.0, 1, 0.0, 0.0, 1, NULL, 1), (10, 'default2', 'default2', 'junior', 'default2', 'default1', 'junior', 0, 1, 0.0, 0, NULL, 0.0, 1, 1, 0), (11, 'default1', 'junior', 'F', 'junior', 'F', 'junior', 0, 0, 0.0, 1, 0.0, 0.0, 1, 0, 1), (12, 'F', 'junior', 'junior', 'junior', 'F', 'F', 1, 1, 0.0, 1, NULL, 0.0, 0, 0, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 9, 'F', '2023-01-02'), (0, 11, 'default2', '2023-01-02'), (2, 12, 'junior', '2023-01-01'), (3, 11, 'default1', '2023-01-02'), (4, 4, 'junior', '2023-01-01'), (5, 11, 'F', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 0, 'default2', '2023-01-02'), (1, 9, 'default2', '2023-01-01'), (2, 1, 'default2', '2023-01-01'), (3, 4, 'F', '2023-01-01'), (4, 10, 'default2', '2023-01-02'), (5, 1, 'default2', '2023-01-02'), (6, 10, 'junior', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 1, 1, 'junior'), (1, 6, 5, 'F'), (2, 2, 5, 'F');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (0, 0, 'F', '2023-01-01'), (1, 1, 'junior', '2023-01-01'), (2, 0, 'default1', '2023-01-01'), (3, 0, 'default2', '2023-01-02'), (4, 1, 'default1', '2023-01-02'), (5, 0, 'default2', '2023-01-02'), (6, 2, 'default2', '2023-01-02'), (7, 0, 'junior', '2023-01-01'), (8, 2, 'junior', '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN card AS T3 ON T2.disp_id = T3.disp_id WHERE T1.gender = 'F' AND T3.type = 'junior';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT client.client_id) AS female_junior_card_customers FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN card ON disp.disp_id = card.disp_id WHERE client.gender = 'F' AND card.type = 'junior';

/*
Prediction Result:
(2,)
*/