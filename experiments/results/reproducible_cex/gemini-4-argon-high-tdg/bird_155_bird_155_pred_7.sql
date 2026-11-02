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
-- DATASET 1
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Hl.m. Praha', 'Prague', '1204953', '0', '0', '0', 1, 1, 100.0, 12541, 0.29, 0.43, 167, 85677, 99107);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (2, 1, 'POPLATEK MESICNE', '1993-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (3, 1, 'POPLATEK MESICNE', '1993-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (4, 1, 'POPLATEK MESICNE', '1993-04-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (5, 1, 'POPLATEK MESICNE', '1993-05-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (6, 1, 'POPLATEK MESICNE', '1993-06-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (7, 1, 'POPLATEK MESICNE', '1993-07-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (8, 1, 'POPLATEK MESICNE', '1993-08-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (9, 1, 'POPLATEK MESICNE', '1993-09-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1993-10-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1971-02-02', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (3, 'M', '1972-03-03', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (4, 'F', '1973-04-04', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (5, 'M', '1974-05-05', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (6, 'F', '1975-06-06', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (7, 'M', '1976-07-07', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (8, 'F', '1977-08-08', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (9, 'M', '1978-09-09', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'F', '1979-10-10', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 1, 1, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 2, 2, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 3, 3, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (4, 4, 4, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (5, 5, 5, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (6, 6, 6, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (7, 7, 7, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (8, 8, 8, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (9, 9, 9, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (10, 10, 10, 'OWNER');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (1, 1, 'gold', '1995-03-15');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (2, 2, 'gold', '1997-12-31');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (3, 3, 'classic', '1996-07-20');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (4, 4, 'junior', '1997-01-01');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5, 5, 'classic', '1997-06-10');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (6, 6, 'junior', '1996-11-05');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (7, 7, 'classic', '1995-09-12');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (8, 8, 'gold', '1998-01-01');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (9, 9, 'gold', '1998-08-19');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (10, 10, 'gold', '1999-04-22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(type = 'gold') AS REAL) * 100 / COUNT(card_id) FROM card WHERE STRFTIME('%Y', issued) < '1998';

/*
Gold Result:
(28.571428571428573,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN type = 'gold' AND STRFTIME('%Y', issued) < '1998' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percent_gold_cards FROM card;

/*
Prediction Result:
(20.0,)
*/