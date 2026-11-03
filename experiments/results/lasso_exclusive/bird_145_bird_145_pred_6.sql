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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1749, 'middle', 'whatever', 'best', 'themselves', 'about', 'case', 1752, 1755, 1758.5, 1761, 1764.5, 1767.5, 1770, 1773, 1776);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1750, 'enter', 'throughout', 'protect', 'factor', 'goal', 'public', 1769.0, 1774.0, 1779.5, 1784.0, 1789.5, 1794.5, 1799.0, 1804.0, 1809.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (1751, 'western', 'approach', 'land', 'another', 'spend', 'everybody', 1786.0, 1793.0, 1800.5, 1807.0, 1814.5, 1821.5, 1828.0, 1835.0, 1842.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1779, 1749, 'color', '1980-07-17');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1780, 1749, 'site', '1980-07-18');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (1781, 1749, 'letter', '1980-07-19');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1782, 1779, '1998-12-31 23:59:59', 'ok', 'VYBER KARTOU', 1796.0, 1788, 'option', 'bag', 1791);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1783, 1779, '1998-12-31 23:59:59', 'season', 'VYBER KARTOU', 1798.0, 1803.0, 'act', 'you', 1812.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1784, 1779, '1998-12-31 23:59:59', 'late', 'VYBER KARTOU', 1800.0, 1818.0, 'brother', 'use', 1833.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1794, 1779, '1998-12-31 23:59:59', 'rock', 'offer', 1797, 1800, 'hope', 'choose', 1803);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1795, 1779, '1998-12-31 23:59:59', 'well', 'also', 1810.0, 1815.0, 'pass', 'law', 1824.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (1796, 1779, '1998-12-31 23:59:59', 'church', 'they', 1823.0, 1830.0, 'old', 'care', 1845.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM trans AS T1 INNER JOIN account AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T1.date) = '1998' AND T1.operation = 'VYBER KARTOU' AND T1.amount < (SELECT AVG(amount) FROM trans WHERE STRFTIME('%Y', date) = '1998');

/*
Gold Result:
(1779,)
(1779,)
(1779,)
*/

-- Prediction Query
SELECT t.account_id FROM trans AS t INNER JOIN account AS a ON t.account_id = a.account_id WHERE t.operation = 'VYBER KARTOU' AND t.date BETWEEN '1998-01-01' AND '1998-12-31' AND t.amount < (SELECT AVG(amount) FROM trans WHERE date BETWEEN '1998-01-01' AND '1998-12-31');

/*
Prediction Result:
*/