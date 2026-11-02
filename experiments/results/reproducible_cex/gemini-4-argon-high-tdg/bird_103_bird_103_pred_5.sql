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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Dist1', 'Reg1', '10000', '10', '5', '2', 1, 1, 50.0, 8000, 1.5, 2.0, 100, 200, 300);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (20, 1, 'POPLATEK MESICNE', '1993-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (30, 1, 'POPLATEK MESICNE', '1993-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (40, 1, 'POPLATEK MESICNE', '1993-01-04');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (50, 1, 'POPLATEK MESICNE', '1993-01-05');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (60, 1, 'POPLATEK MESICNE', '1993-01-06');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (101, 'M', '1970-05-10', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (102, 'F', '1971-06-11', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (103, 'M', '1972-07-12', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (104, 'F', '1973-08-13', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (105, 'M', '1974-09-14', 1);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (106, 'F', '1975-10-15', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1001, 101, 10, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1002, 102, 20, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1003, 103, 30, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1004, 104, 40, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1005, 105, 50, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1006, 106, 60, 'OWNER');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5001, 1001, 'classic', '1994-03-03');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5002, 1002, 'classic', '1994-03-02');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5003, 1003, 'classic', '1994-03-04');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5004, 1004, 'classic', '1993-03-03');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5005, 1005, 'classic', '1994-04-03');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (5006, 1006, 'classic', '1994-03-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.client_id FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN card AS T3 ON T2.disp_id = T3.disp_id WHERE T3.issued = '1994-03-03';

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT disp.client_id FROM card INNER JOIN disp ON card.disp_id = disp.disp_id WHERE STRFTIME('%Y', card.issued) = '1994' AND STRFTIME('%m', card.issued) = '03';

/*
Prediction Result:
(101,)
(102,)
(103,)
(106,)
*/