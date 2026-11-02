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
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (5, 'Dist5', 'Reg5', '1000', '10', '5', '2', 1, 1, 50.0, 8000, 1.5, 2.0, 100, 100, 120);
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (20, 'Dist20', 'Reg20', '2000', '20', '10', '4', 2, 2, 60.0, 9000, 2.5, 3.0, 110, 150, 180);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 5, 'POPLATEK MESICNE', '1995-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (1, 20, 'POPLATEK MESICNE', '1995-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (5, 20, 'POPLATEK TYDNE', '1995-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (10, 20, 'POPLATEK PO OBRATU', '1995-01-04');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (11, 5, 'POPLATEK MESICNE', '1995-01-05');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (1, 'M', '1970-01-01', 5);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (2, 'F', '1972-05-10', 5);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (50, 'M', '1965-03-15', 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (51, 'F', '1980-07-20', 20);
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (52, 'M', '1975-11-30', 20);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (1, 1, 0, 'Owner');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (2, 2, 0, 'Disponent');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (101, 50, 1, 'Owner');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (102, 51, 1, 'Owner');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (103, 52, 1, 'Disponent');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (104, 50, 5, 'Owner');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (105, 51, 5, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (106, 52, 5, 'Other');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (107, 50, 10, 'Owner');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (108, 51, 10, 'Disponent');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (109, 52, 10, 'disponent');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (3, 1, 11, 'Owner');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (4, 2, 11, 'Disponent');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (5, 50, 11, 'Disponent');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(type = 'Owner'), SUM(type = 'Disponent') FROM disp WHERE account_id BETWEEN 1 AND 10;

/*
Gold Result:
(4, 2)
*/

-- Prediction Query
SELECT type, COUNT(*) FROM disp WHERE account_id BETWEEN 1 AND 10 GROUP BY type;

/*
Prediction Result:
('Disponent', 2)
('OWNER', 1)
('Other', 1)
('Owner', 4)
('disponent', 1)
*/