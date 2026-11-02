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
-- Tests join path: client.district_id vs account.district_id
-- Tests COUNT(T3.account_id) vs COUNT(DISTINCT T3.account_id) vs COUNT(DISTINCT T2.client_id)
-- Tests T3.type <> 'OWNER' with multiple non-owner types ('DISPONENT', 'USER')
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Prague', 'south Bohemia', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Brno', 'north Bohemia', '100', '1', '1', '1', 1, 1, 1.0, 1, 1.0, 1.0, 1, 1, 1);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (100, 2, 'POPLATEK MESICNE', '2020-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 1, 'POPLATEK MESICNE', '2020-01-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (10, 'M', '1980-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (11, 'F', '1985-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (12, 'M', '1990-01-01', 2);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1000, 10, 100, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1001, 11, 100, 'USER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1002, 12, 101, 'DISPONENT');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.account_id) FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id INNER JOIN disp AS T3 ON T2.client_id = T3.client_id WHERE T1.A3 = 'south Bohemia' AND T3.type <> 'OWNER';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.account_id) FROM account AS T1 LEFT JOIN disp AS T2 ON T1.account_id = T2.account_id LEFT JOIN card AS T3 ON T2.disp_id = T3.disp_id INNER JOIN district AS T4 ON T1.district_id = T4.district_id WHERE T4.A3 = 'south Bohemia' AND T3.disp_id IS NULL;

/*
Prediction Result:
(1,)
*/