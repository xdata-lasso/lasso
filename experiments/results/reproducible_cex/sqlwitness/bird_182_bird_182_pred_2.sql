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
INSERT INTO district (district_id, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16) VALUES (4001, '1976-12-31', 'default2', 'default2', '1974', '1976', '1976', 0, 4000, 1.0, 3999, 4000.0, 1.0, 3999, 3999, 4000), (0, 'default1', 'default2', 'M', 'default2', 'SIPO', 'M', 1, 3999, 4000.0, 4000, 4000.0, 4001.0, 4000, 3999, 0), (4000, '1974-01-01', '1974', 'SIPO', '%Y', 'default1', '1976-12-31', 4000, 0, 3999.0, 1, NULL, 4001.0, 3999, 1, 0), (3999, '%Y', '1974', '1974-01-01', '1976-12-31', '%Y', 'SIPO', 4000, 1, 3999.0, 1, 1.0, 4001.0, 4001, 4001, 0), (1, '1976-12-31', 'default2', '1974-01-01', '1976', '%Y', '1974', 4000, 3999, 0.0, 4000, NULL, 1.0, 3999, 4000, 4001), (2, 'SIPO', '%Y', 'default1', 'SIPO', 'SIPO', 'default2', 1, 3999, 4001.0, 4001, NULL, 1.0, 4001, 0, 4001), (3, 'M', 'default2', '1974', '1976-12-31', 'SIPO', '1974', 1, 0, 1.0, 4001, 4001.0, 4000.0, 4000, 0, 1), (4, '1974', '%Y', '1974', 'default2', '1976-12-31', 'default1', 4001, 0, 0.0, 0, 4001.0, 1.0, 3999, 0, 3999), (5, '1976-12-31', 'default2', 'SIPO', 'default2', 'default1', 'SIPO', 1, 3999, 4000.0, 1, 1.0, 0.0, 4000, 3999, 0), (6, '1976-12-31', 'default2', 'default2', 'SIPO', '1974', '1974-01-01', 0, 4001, 0.0, 1, 3999.0, 0.0, 4001, 4000, 4001), (7, 'default2', '1976-12-31', '1976', '1976', 'default2', '%Y', 1, 4000, 0.0, 0, 0.0, 0.0, 3999, 3999, 1), (8, 'default2', 'SIPO', '1974', '1974', 'SIPO', '1976-12-31', 4000, 4001, 4000.0, 4001, 1.0, 4001.0, 4001, 0, 4001), (9, 'default1', '1976-12-31', '%Y', '1976-12-31', '%Y', 'SIPO', 4001, 0, 4001.0, 4001, 1.0, 3999.0, 4001, 3999, 1), (10, '1976', 'default1', '1974', 'default2', 'default1', '1976', 0, 0, 4000.0, 1, 3999.0, 1.0, 3999, 3999, 1), (11, 'SIPO', '%Y', '1974', 'default2', '1976', 'M', 4000, 1, 4001.0, 4000, 0.0, 0.0, 4000, 4001, 0), (12, '1976', 'M', '1976', '1974-01-01', '1976-12-31', 'M', 3999, 0, 0.0, 4000, 4001.0, 0.0, 4001, 4001, 1), (13, '1976-12-31', '1974-01-01', '1974', 'default2', 'M', '1974-01-01', 4001, 1, 4000.0, 4000, 1.0, 0.0, 4001, 0, 1);
INSERT INTO client (client_id, district_id, gender, birth_date) VALUES (4001, 10, 'default1', '1974-10-27'), (0, 9, 'M', '1974-01-02'), (1, 13, '%Y', '1976-12-30'), (3999, 4, '1974', '1974-01-01'), (4000, 11, '%Y', '1976-12-30'), (2, 0, 'SIPO', '1973-12-31'), (3, 4001, '1976', '1973-12-31'), (4, 10, 'default1', '1976-12-31'), (5, 7, '1976-12-31', '2023-01-02'), (6, 8, '1974-01-01', '2023-01-01'), (7, 5, 'M', '1976-10-27'), (8, 7, 'default2', '1976-10-27'), (9, 3999, 'default1', '1977-01-01'), (10, 1, 'SIPO', '1973-12-31'), (11, 10, 'default2', '2023-01-01'), (12, 13, 'SIPO', '1976-10-27');
INSERT INTO account (account_id, district_id, frequency, date) VALUES (4000, 13, 'default1', '1976-12-31'), (1, 3, '1976-12-31', '1977-01-01'), (3999, 13, 'M', '1974-01-02');
INSERT INTO trans (trans_id, account_id, date, type, operation, amount, balance, k_symbol, bank, account) VALUES (3999, 1, '2023-01-02', '1974', '1976-12-31', 1, 4001, 'SIPO', 'SIPO', 1), (4000, 3999, '1974-10-27', 'default2', 'default1', 1, 1, 'M', 'default2', 3999), (0, 4000, '1976-10-27', '%Y', '1976-12-31', 4000, 0, 'default1', 'SIPO', 1), (4001, 1, '1976-12-30', '1976-12-31', '1976', 0, 1, 'M', '%Y', 4000), (1, 3999, '1974-10-27', 'default1', 'M', 4001, 3999, '1974', 'default2', 3999), (2, 3999, '1976-12-30', '1974', '%Y', 3999, 1, 'default1', '1974', 4000), (3, 1, '1976-12-31', '1974-01-01', '1976', 4000, 3999, 'SIPO', '1976', 3999), (4, 4000, '2023-01-02', '%Y', '1974-01-01', 0, 4000, '1976', 'M', 4001), (5, 1, '1976-10-27', '1976-12-31', '1976', 1, 0, '%Y', '1976', NULL), (6, 3999, '2023-01-01', 'SIPO', '1974', 4001, 3999, '1974', 'default1', 4001), (7, 4000, '1974-01-02', 'M', 'M', 0, 4001, 'default2', 'SIPO', 3999), (8, 3999, '1976-12-31', 'M', 'default1', 3999, 3999, 'SIPO', '1976-12-31', NULL);
INSERT INTO "order" (order_id, account_id, bank_to, account_to, amount, k_symbol) VALUES (0, 1, 'SIPO', 0, 4000.0, 'default1'), (1, 1, '1976', 4001, 4001.0, 'SIPO'), (4001, 3999, '%Y', 0, 1.0, '1976-12-31'), (3999, 3999, 'M', 3999, 4000.0, 'default1'), (4000, 4000, 'default2', 1, 4000.0, '1974-01-01'), (2, 1, 'SIPO', 0, 4001.0, 'default2'), (3, 3999, 'M', 0, 0.0, '%Y'), (4, 1, 'default2', 4001, 0.0, 'default1'), (5, 1, '1974', 3999, 0.0, '1976-12-31');
INSERT INTO disp (disp_id, account_id, client_id, type) VALUES (4000, 4000, 10, 'default1'), (0, 1, 0, 'default2'), (3999, 4000, 1, '1976'), (4001, 4000, 9, '1974'), (1, 3999, 4000, '1976'), (2, 4000, 11, '%Y'), (3, 1, 1, 'default1'), (4, 4000, 10, 'default2'), (5, 1, 3, 'SIPO');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.account_id) FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id INNER JOIN client AS T3 ON T2.district_id = T3.district_id WHERE STRFTIME('%Y', T3.birth_date) BETWEEN '1974' AND '1976' AND T3.gender = 'M' AND T1.amount > 4000 AND T1.k_symbol = 'SIPO';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "client"."client_id") FROM "client" INNER JOIN "disp" ON "client"."client_id" = "disp"."client_id" INNER JOIN "order" ON "disp"."account_id" = "order"."account_id" WHERE "client"."gender" = 'M' AND "client"."birth_date" BETWEEN '1974-01-01' AND '1976-12-31' AND "order"."k_symbol" = 'SIPO' AND "order"."amount" > 4000;

/*
Prediction Result:
(1,)
*/