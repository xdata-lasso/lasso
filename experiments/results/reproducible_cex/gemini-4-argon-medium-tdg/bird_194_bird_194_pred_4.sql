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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Prague', 'Central', '1000', '1', '1', '1', 1, 1, 100.0, 10000, 1.0, 1.0, 100, 100, 100);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1995-03-15');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1980-05-20', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1990-11-10', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'M', '1975-02-28', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (104, 'F', '2000-08-01', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1001, 101, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1002, 102, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1003, 103, 10, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1004, 104, 10, 'DISPONENT');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5001, 1001, 'gold', '1998-06-15');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5002, 1002, 'classic', '1999-01-20');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5003, 1003, 'gold', '2000-03-10');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5004, 1004, 'junior', '2001-07-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id, STRFTIME('%Y', '2025-01-01 00:00:00') - STRFTIME('%Y', T3.birth_date) FROM disp AS T1 INNER JOIN card AS T2 ON T2.disp_id = T1.disp_id INNER JOIN client AS T3 ON T1.client_id = T3.client_id WHERE T2.type = 'gold' AND T1.type = 'OWNER';

/*
Gold Result:
(101, 45)
*/

-- Prediction Query
SELECT client.client_id, client.birth_date FROM card INNER JOIN disp ON card.disp_id = disp.disp_id INNER JOIN client ON disp.client_id = client.client_id WHERE card.type = 'gold' AND disp.type = 'OWNER';

/*
Prediction Result:
(101, '1980-05-20')
*/