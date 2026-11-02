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
-- Inserting into table: account --
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1, -2147483648, 'ilbnp', '2023-01-01');

INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (3, -2147483648, 'tliqa1', '2024-10-14');

-- Inserting into table: district --
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 700293388, 906324270, 944.247544, 2122220075, 749.826493, 503.083789, -1659388584, 1526238907, -1377057208);

-- Inserting into table: client --
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (-2147483648, 'dposiie5unw', '2025-09-21', -2147483648);

-- Inserting into table: disp --
INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (1, -2147483648, 1, 'lfa');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-2147483647, -2147483648, 1, 'e');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (0, -2147483648, 1, 'qyp5s5bbp0');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (-1, -2147483648, 1, '72k');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (4, -2147483648, 1, 'sr');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (6, -2147483648, 1, 'b');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (2, -2147483648, 1, 'luhvdltti');

INSERT INTO "disp" ("disp_id", "client_id", "account_id", "type") VALUES (3, -2147483648, 1, '5sw');

-- Inserting into table: loan --
INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (1, 1, '1993-01-01', 1, 12, 587.783596, '000t5c4ec');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (2, 1, '1993-01-01', 1, 12, 467.07027, 'nium52zbu');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (3, 1, '1993-01-01', 1, 12, 225.300904, 'rqro');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483645, 1, '1993-01-01', 0, 12, 274.580687, 'ytoo3o9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483644, 1, '1993-01-01', 0, 12, 74.250383, 'x14ji7zwau2d');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483643, 1, '1993-01-01', 0, 12, 278.010437, '3pyu78d');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483642, 1, '1993-01-01', -1, 12, 145.402595, 'l0b4y');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483641, 1, '1993-01-01', 0, 12, 792.401003, '2rk');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483640, 1, '1993-01-01', 0, 12, 410.133844, '8j');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483639, 1, '1993-01-01', -1, 12, 712.084197, '1vy9uxj4');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (-2147483638, 1, '1993-01-01', 0, 12, 22.63964, 'lph2gn');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (5, 1, '2025-06-17', -1437333179, -921145356, 357.862717, 'cgsk9');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (7, 1, '2022-04-27', -1980249628, -734455130, 906.21648, 'hria2ypu');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (4, 1, '1993-01-01', -1364429300, 1, 998.421621, 'prmd');

INSERT INTO "loan" ("loan_id", "account_id", "date", "amount", "duration", "payments", "status") VALUES (6, 1, '2000-03-01', 1258409369, 12, 38.668834, 'k9n8c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM loan AS T1 INNER JOIN disp AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1993' AND T1.duration = 12 ORDER BY T1.amount DESC, T1.loan_id NULLS LAST, T2.disp_id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT acc.account_id FROM account AS acc JOIN loan AS ln ON acc.account_id = ln.account_id WHERE ln.duration > 12 AND ln.amount = (SELECT MAX(ln2.amount) FROM loan AS ln2 JOIN account AS acc2 ON ln2.account_id = acc2.account_id WHERE ln2.duration > 12 AND STRFTIME('%Y', acc2.date) = '1993') AND STRFTIME('%Y', acc.date) = '1993';

/*
Prediction Result:
*/