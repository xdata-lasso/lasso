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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Hl.m. Praha', 'Prague', '1204953', '0', '0', '0', 1, 1, 100.0, 12541, 0.2, 0.43, 167, 85677, 99107);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (2, 'Benesov', 'central Bohemia', '88884', '80', '26', '6', 2, 5, 46.7, 8507, 1.6, 1.85, 132, 2159, 2674);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (301, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (302, 2, 'POPLATEK MESICNE', '1993-02-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (303, 1, 'POPLATEK MESICNE', '1993-03-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (304, 1, 'POPLATEK MESICNE', '1993-04-01');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1970-01-01', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1972-05-10', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'M', '1965-08-20', 2);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (104, 'F', '1980-11-30', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (202, 101, 301, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (203, 102, 302, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (201, 103, 303, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (204, 104, 304, 'OWNER');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (401, 301, '1994-01-01', 900000, 36, 25000.0, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (402, 302, '1994-02-01', 500000, 48, 10416.7, 'A');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (403, 303, '1994-03-01', 80000, 60, 15000.0, 'B');
INSERT INTO loan (loan_id, account_id, date, amount, duration, payments, status) VALUES (404, 304, '1994-04-01', 250000, 24, 10416.7, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.client_id FROM disp AS T1 INNER JOIN loan AS T2 ON T1.account_id = T2.account_id WHERE T1.type = 'OWNER' ORDER BY T2.amount DESC, T1.disp_id NULLS LAST, T2.loan_id NULLS LAST LIMIT 1;

/*
Gold Result:
(102,)
*/

-- Prediction Query
SELECT c.* FROM client AS c INNER JOIN disp AS d ON c.client_id = d.client_id INNER JOIN account AS a ON d.account_id = a.account_id INNER JOIN loan AS l ON a.account_id = l.account_id WHERE l.amount = (SELECT MAX(amount) FROM loan) AND d.type = 'OWNER';

/*
Prediction Result:
*/