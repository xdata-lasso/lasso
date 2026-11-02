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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (0, 'default1', '1998-01-01', '1998-01-01', '1998', '%Y', 'gold', 1, 2, 100.0, 1, 0.0, 101.0, -1, -1, 1), (1, '1998', '1998-01-01', 'gold', 'default1', '1998-01-01', 'default1', 99, 1, 99.0, -1, 0.0, 0.0, -1, 2, 101), (-1, 'default2', '1998-01-01', '1998-01-01', '1998', '1998', '%Y', -1, 0, 0.0, 1, 100.0, 2.0, 99, NULL, 2), (2, 'default1', 'gold', 'default1', '1998', 'default2', 'default1', 100, 0, 0.0, 2, 1.0, 2.0, -1, 2, -1), (99, 'default2', 'gold', 'gold', 'default1', '1998', 'default2', 1, 99, 101.0, 99, -1.0, 0.0, 100, 100, 99);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (101, -1, 'default1', '1998-01-02'), (-1, 0, '1998-01-01', '2023-01-01'), (1, 2, 'default1', '1997-12-31'), (0, 0, 'default1', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 0, '1998', '2023-01-02');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (100, 1, 0, 'gold'), (0, 1, 101, '1998'), (99, 1, -1, '1998-01-01'), (-1, 1, 0, '%Y'), (1, 1, -1, '1998');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (99, -1, 'gold', '1998-10-27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(type = 'gold') AS REAL) * 100 / COUNT(card_id) FROM card WHERE STRFTIME('%Y', issued) < '1998';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN issued < '1998-01-01' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(card_id) FROM card WHERE type = 'gold';

/*
Prediction Result:
(0.0,)
*/