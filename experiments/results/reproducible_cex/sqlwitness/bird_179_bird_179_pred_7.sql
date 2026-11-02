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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default2', '1998', '%Y', '%Y', '1998', '1998', 616, 0, 616.0, 617, 0.0, 0.0, 0, 617, 618), (617, 'default2', '1998', '%Y', 'default2', '1998', '1998', 616, 616, 0.0, 618, 616.0, 617.0, 618, NULL, 618);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (1, 617, 'default2', '2023-01-02'), (617, 617, '%Y', '2023-01-02'), (618, 617, 'default1', '2023-01-02'), (0, 617, 'default2', '2023-01-01'), (616, 617, 'default2', '2023-01-02'), (2, 1, 'default1', '2023-01-01'), (3, 617, '1998', '1998-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (617, 617, '%Y', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (617, 617, '1998-10-27', '1998', NULL, 618, 0, 'default2', NULL, 1), (0, 617, '2023-01-01', 'default2', 'default2', 1, 1, 'default2', 'default2', 1), (1, 617, '1998-10-27', 'default1', 'default1', 617, 1, '1998', '%Y', NULL), (616, 617, '2023-01-02', '%Y', NULL, 616, 616, '%Y', 'default1', 616);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (618, 617, 2, 'default2'), (0, 617, 0, '1998'), (616, 617, 0, 'default1'), (617, 617, 3, '%Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T3.amount) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '1998' AND T1.client_id = 617;

/*
Gold Result:
(1235,)
*/

-- Prediction Query
SELECT SUM(trans.amount) AS total_paid FROM trans INNER JOIN account ON trans.account_id = account.account_id INNER JOIN disp ON account.account_id = disp.account_id INNER JOIN client ON disp.client_id = client.client_id WHERE client.client_id = 617 AND STRFTIME('%Y', trans.date) = '1998';

/*
Prediction Result:
(None,)
*/