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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'gold', 'default1', 'gold', 'default1', '1998', '1998', 0, 100, 0.0, 1, -1.0, 2.0, 1, 100, 1), (0, 'default2', '%Y', '1998', '%Y', '%Y', 'default1', 2, 2, 101.0, 99, -1.0, -1.0, 0, 1, -1), (99, 'default1', 'default2', 'default2', 'gold', '%Y', 'default2', 99, 1, 101.0, 1, 101.0, 101.0, 99, 100, 99), (101, 'default1', 'default2', '%Y', '1998', 'gold', '%Y', 99, 2, 100.0, 2, 2.0, -1.0, 0, 100, 100), (100, 'default1', '%Y', 'gold', '%Y', 'gold', '%Y', 0, -1, 1.0, 2, -1.0, 1.0, 2, 100, 99);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (101, 1, '%Y', '1998-10-27'), (1, 1, 'default1', '1998-10-27'), (-1, 99, '1998', '2023-01-01'), (99, 0, '1998', '1998-10-27'), (0, 99, '1998', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'gold', '1998-10-27'), (100, 100, '%Y', '2023-01-01'), (-1, 101, 'default1', '2023-01-01');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (0, 100, 0, '1998'), (1, 101, 101, 'gold');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (101, 0, 'default2', '1998-10-27'), (99, 0, '%Y', '2023-01-02'), (1, 1, '%Y', '1998-10-27'), (0, 0, 'default2', '2023-01-01'), (-1, 0, '1998', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(type = 'gold') AS REAL) * 100 / COUNT(card_id) FROM card WHERE STRFTIME('%Y', issued) < '1998';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN type = 'gold' AND STRFTIME('%Y', issued) < '1998' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percent_gold_cards FROM card;

/*
Prediction Result:
(0.0,)
*/