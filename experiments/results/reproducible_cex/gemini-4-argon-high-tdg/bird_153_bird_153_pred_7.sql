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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (10, 'Praha', 'Bohemia', '100000', '10', '10', '10', 1, 1, 100.0, 10000, 1.5, 2.0, 100, 1000, 1200);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (101, 10, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (102, 10, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (103, 10, 'POPLATEK MESICNE', '1995-01-03');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (201, 'M', '1970-01-01', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (202, 'F', '1975-05-10', 10);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (203, 'M', '1980-08-20', 10);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (301, 201, 101, 'Owner');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (302, 202, 102, 'Owner');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (303, 203, 103, 'Owner');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (304, 202, 101, 'Disponent');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (305, 203, 102, 'Disponent');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (401, 301, 'classic', '1998-01-01');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (402, 302, 'classic', '1998-01-02');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (403, 301, 'gold', '1998-01-03');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (404, 302, 'junior', '1998-01-04');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (405, 303, 'junior', '1998-01-05');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (406, 304, 'classic', '1998-01-06');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (407, 305, 'gold', '1998-01-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.card_id) FROM card AS T1 INNER JOIN disp AS T2 ON T1.disp_id = T2.disp_id WHERE T1.type = 'classic' AND T2.type = 'Owner';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(c.card_id) FROM card AS c JOIN disp AS d ON c.disp_id = d.disp_id JOIN account AS a ON d.account_id = a.account_id WHERE d.type = 'OWNER' AND c.type = 'classic';

/*
Prediction Result:
(0,)
*/