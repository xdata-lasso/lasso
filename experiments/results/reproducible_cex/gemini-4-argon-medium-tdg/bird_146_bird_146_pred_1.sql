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
-- DATASET 3
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Ostrava', 'North', '3000', '30', '30', '30', 3, 3, 80.0, 8500, 3.5, 4.0, 80, 80, 80);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (31, 1, 'POPLATEK PO OBRATU', '1993-05-05');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (301, 'F', '1965-04-04', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (302, 'F', '1968-08-08', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3001, 301, 31, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3002, 302, 31, 'DISPONENT');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (7001, 31, '1994-05-05', 24000, 24, 1000.0, 'A');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (9001, 3002, 'gold', '1995-05-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN loan AS T3 ON T2.account_id = T3.account_id INNER JOIN card AS T4 ON T2.disp_id = T4.disp_id WHERE T1.gender = 'F';

/*
Gold Result:
(302,)
*/

-- Prediction Query
SELECT client.client_id FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN card ON disp.disp_id = card.disp_id INNER JOIN loan ON disp.account_id = loan.account_id WHERE client.gender = 'F' AND disp.type = 'OWNER';

/*
Prediction Result:
*/