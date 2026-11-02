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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (616, 'default1', 'VYDAJ', '%Y', 'default1', '%Y', '%Y', 617, 616, 618.0, 1, 617.0, 617.0, 616, 0, 1), (617, 'default2', '%Y', 'default1', 'default2', '%Y', 'default2', 617, 1, 1.0, 0, NULL, 1.0, 617, NULL, 0), (1, '%Y', 'default2', 'default2', 'default2', 'default2', 'VYDAJ', 0, 617, 618.0, 1, 0.0, 1.0, 1, NULL, 1), (618, 'default2', '%Y', 'default2', 'VYDAJ', 'default2', 'VYDAJ', 0, 1, 617.0, 618, NULL, 618.0, 616, 617, 0), (0, 'default1', '1998', 'default1', 'VYDAJ', 'default2', 'VYDAJ', 617, 618, 0.0, 1, 617.0, 1.0, 1, 618, 616), (2, 'default1', 'VYDAJ', 'VYDAJ', 'default2', 'default2', 'VYDAJ', 0, 0, 616.0, 1, 1.0, 0.0, 1, 1, 0), (3, 'default2', '%Y', 'VYDAJ', 'default1', 'default1', 'default2', 616, 1, 1.0, 618, 618.0, 0.0, 617, 1, 616), (4, 'default1', '1998', 'default2', 'VYDAJ', '1998', 'default2', 0, 617, 617.0, 1, 617.0, 617.0, 617, NULL, 618), (5, 'default2', '1998', '1998', '%Y', 'default1', 'default1', 617, 618, 616.0, 618, 0.0, 616.0, 618, 0, 618);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (616, 2, 'default1', '2023-01-02'), (617, 617, 'default1', '2023-01-01'), (1, 2, 'default2', '1998-10-27'), (0, 5, 'VYDAJ', '1998-10-27'), (618, 4, 'default1', '1998-10-27'), (2, 2, 'VYDAJ', '1998-10-27'), (3, 4, 'VYDAJ', '2023-01-01'), (4, 1, '%Y', '2023-01-02'), (5, 2, 'default1', '2023-01-01');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (0, 2, 'VYDAJ', '1998-10-27'), (618, 617, '1998', '2023-01-01'), (617, 616, 'default2', '2023-01-01');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (618, 618, '1998-10-27', '%Y', '1998', 617, 617, '1998', '%Y', 617), (0, 0, '1998-10-27', 'default2', '1998', 618, 618, '1998', 'default2', 0), (617, 617, '2023-01-01', 'VYDAJ', 'VYDAJ', 618, 0, 'default2', '%Y', 616), (1, 617, '2023-01-01', 'default1', 'VYDAJ', 0, 618, 'default2', 'VYDAJ', 617), (616, 0, '1998-10-27', '1998', 'default2', 617, 1, 'default2', '1998', 616), (2, 618, '2023-01-01', '1998', 'VYDAJ', 617, 617, '1998', 'VYDAJ', 1), (3, 0, '1998-10-27', 'VYDAJ', 'default1', 0, 617, 'default2', NULL, 618), (4, 617, '2023-01-01', 'VYDAJ', 'default1', 0, 617, '1998', '%Y', 616);
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (617, 0, 0, 'VYDAJ'), (616, 0, 3, 'VYDAJ'), (0, 0, 617, 'default2'), (1, 618, 2, '%Y'), (618, 617, 618, 'default2'), (2, 0, 3, 'VYDAJ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T3.amount) FROM client AS T1 INNER JOIN account AS T2 ON T1.district_id = T2.district_id INNER JOIN trans AS T3 ON T2.account_id = T3.account_id WHERE STRFTIME('%Y', T3.date) = '1998' AND T1.client_id = 617;

/*
Gold Result:
(617,)
*/

-- Prediction Query
SELECT SUM(trans.amount) FROM trans JOIN disp ON trans.account_id = disp.account_id JOIN client ON disp.client_id = client.client_id WHERE client.client_id = 617 AND trans.type = 'VYDAJ' AND STRFTIME('%Y', trans.date) = '1998';

/*
Prediction Result:
(0,)
*/