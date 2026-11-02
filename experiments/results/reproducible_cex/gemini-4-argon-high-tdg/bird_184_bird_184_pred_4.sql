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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Prague', 'Central', '100000', '10', '5', '2', 1, 1, 100.0, 10000, 1.5, 2.0, 100, 500, 600);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Brno', 'South', '50000', '8', '4', '1', 1, 1, 80.0, 9000, 2.5, 3.0, 80, 300, 400);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (31, 2, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (11, 'F', '1980-05-15', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (12, 'M', '1982-08-20', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (13, 'F', '1975-03-10', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (14, 'M', '1970-11-25', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (21, 11, 31, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (22, 12, 31, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (23, 13, 31, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (24, 14, 31, 'OWNER');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (41, 21, 'junior', '1998-01-01');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (42, 22, 'junior', '1998-02-01');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (43, 23, 'classic', '1998-03-01');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (44, 24, 'gold', '1998-04-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.client_id) FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN card AS T3 ON T2.disp_id = T3.disp_id WHERE T1.gender = 'F' AND T3.type = 'junior';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM client INNER JOIN card ON client.client_id = card.disp_id WHERE client.gender = 'F' AND card.type = 'junior';

/*
Prediction Result:
(0,)
*/