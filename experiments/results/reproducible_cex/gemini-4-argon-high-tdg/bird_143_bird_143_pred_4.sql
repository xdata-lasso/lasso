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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Hl.m. Praha', 'Prague', '1204953', '0', '0', '0', 1, 1, 100.0, 12541, 0.2, 0.43, 167, 85677, 99107);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (201, 10, 'POPLATEK MESICNE', '1995-03-24');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (202, 10, 'POPLATEK MESICNE', '1996-07-12');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (203, 10, 'POPLATEK TYDNE', '1994-11-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (204, 10, 'POPLATEK PO OBRATU', '1997-01-19');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1970-12-13', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1978-05-20', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'M', '1965-08-01', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (104, 'F', '1982-02-14', 10);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (301, 101, 201, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (302, 102, 202, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (303, 103, 203, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (304, 104, 204, 'OWNER');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (401, 301, 'gold', '1998-10-16');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (402, 302, 'junior', '1998-06-12');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (403, 303, 'classic', '1997-04-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.account_id FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id WHERE T1.type IN ('gold', 'junior');

/*
Gold Result:
(201,)
(202,)
*/

-- Prediction Query
SELECT account.account_id FROM account INNER JOIN disp ON account.account_id = disp.account_id INNER JOIN card ON disp.disp_id = card.disp_id WHERE card.type = 'gold';

/*
Prediction Result:
(201,)
*/