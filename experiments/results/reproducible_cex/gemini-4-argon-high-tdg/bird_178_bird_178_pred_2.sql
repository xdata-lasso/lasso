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
-- DATASET 2
INSERT INTO district (district_id, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16) VALUES (1, 'Hl.m. Praha', 'Prague', '1204953', '0', '0', '0', 1, 1, 100.0, 12541, 0.2, 0.43, 167, 85677, 99107);
INSERT INTO account (account_id, district_id, frequency, date) VALUES (201, 1, 'POPLATEK MESICNE', '1993-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (202, 1, 'POPLATEK MESICNE', '1993-01-02');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (203, 1, 'POPLATEK MESICNE', '1993-01-03');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (204, 1, 'POPLATEK MESICNE', '1993-01-04');
INSERT INTO client (client_id, gender, birth_date, district_id) VALUES (9, 'F', '1972-04-10', 1);
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (101, 9, 201, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (102, 9, 202, 'OWNER');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (103, 9, 203, 'DISPONENT');
INSERT INTO disp (disp_id, client_id, account_id, type) VALUES (104, 9, 204, 'DISPONENT');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (301, 101, 'classic', '1996-01-01');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (302, 102, 'classic', '1996-02-01');
INSERT INTO card (card_id, disp_id, type, issued) VALUES (303, 103, 'junior', '1996-03-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.type FROM client AS T1 INNER JOIN disp AS T2 ON T1.client_id = T2.client_id INNER JOIN card AS T3 ON T2.disp_id = T3.disp_id WHERE T1.client_id = 9;

/*
Gold Result:
('classic',)
('classic',)
('junior',)
*/

-- Prediction Query
SELECT DISTINCT "card"."type" FROM "card" INNER JOIN "disp" ON "card"."disp_id" = "disp"."disp_id" WHERE "disp"."client_id" = 9;

/*
Prediction Result:
('classic',)
('junior',)
*/