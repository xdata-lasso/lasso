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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (1, 'default1', 'F', 'F', 'default1', 'default2', 'default2', 1, 1, 2.0, 0, 1.0, 2.0, 1, 2, 0), (2, 'F', 'default1', 'F', 'default2', 'default1', 'F', 2, 0, 0.0, 0, 2.0, 1.0, 2, 1, 0), (0, 'F', 'default1', 'F', 'default2', 'default2', 'default1', 0, 0, 0.0, 1, 1.0, 2.0, 2, 2, 1), (3, 'F', 'default2', 'default1', 'F', 'F', 'default1', 0, 2, 2.0, 1, 0.0, 1.0, 2, 0, 0), (4, 'default2', 'default2', 'default1', 'default1', 'default1', 'F', 0, 2, 2.0, 1, 0.0, 0.0, 0, 2, 1), (5, 'F', 'default2', 'default1', 'default2', 'default2', 'default2', 2, 1, 1.0, 1, NULL, 1.0, 1, 2, 0), (6, 'default1', 'default1', 'default1', 'F', 'F', 'F', 1, 1, 1.0, 1, 0.0, 1.0, 2, NULL, 2), (7, 'F', 'default2', 'default2', 'F', 'F', 'default2', 0, 0, 0.0, 2, NULL, 2.0, 2, 2, 2), (8, 'default2', 'default2', 'F', 'F', 'default2', 'F', 1, 1, 0.0, 2, 2.0, 2.0, 0, 1, 0);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (2, 1, 'default2', '2023-01-02'), (0, 5, 'default2', '2023-01-01'), (1, 7, 'default2', '2023-01-02'), (3, 7, 'default1', '2023-01-02'), (4, 8, 'default2', '2023-01-01'), (5, 7, 'F', '2023-01-01'), (6, 7, 'F', '2023-01-01'), (7, 8, 'F', '2023-01-01'), (8, 4, 'default2', '2023-01-02'), (9, 0, 'default2', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T1.gender = 'F' ORDER BY T1.birth_date ASC, T2.A11 ASC, T1.client_id NULLS LAST, T2.district_id NULLS LAST, T3.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT client.client_id AS account_number FROM client JOIN district ON client.district_id = district.district_id WHERE client.gender = 'F' ORDER BY client.birth_date DESC, district.A11 ASC, client.client_id NULLS LAST, district.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(5,)
*/