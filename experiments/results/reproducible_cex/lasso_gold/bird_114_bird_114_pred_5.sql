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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2431, 'whose', 'Prague', 'cell', 'operation', 'vote', 'serve', 2435, 2439, 2443.5, 2447, 2451.5, 2455.5, 2459, 2463, 2467);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2433, 'thus', 'Prague', 'suddenly', 'physical', 'level', 'wait', 2452.0, 2458.0, 2464.5, 2470.0, 2476.5, 2482.5, 2488.0, 2494.0, 2500.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2434, 'campaign', 'Prague', 'region', 'free', 'position', 'mother', 2469.0, 2477.0, 2485.5, 2493.0, 2501.5, 2509.5, 2517.0, 2525.0, 2533.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2475, 'loss', 'Prague', 'nice', 'someone', 'teacher', 'last', 2486.0, 2496.0, 2506.5, 2516.0, 2526.5, 2536.5, 2546.0, 2556.0, 2566.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2432, 'watch', 'Prague', 'listen', 'though', 'star', 'edge', 2479, 2483, 2487.5, 2491, 2495.5, 2499.5, 2503, 2507, 2511);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2476, 'cold', 'Prague', 'event', 'public', 'near', 'face', 2496.0, 2502.0, 2508.5, 2514.0, 2520.5, 2526.5, 2532.0, 2538.0, 2544.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2477, 'six', 'Prague', 'society', 'factor', 'memory', 'less', 2513.0, 2521.0, 2529.5, 2537.0, 2545.5, 2553.5, 2561.0, 2569.0, 2577.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2478, 'training', 'Prague', 'end', 'space', 'produce', 'bank', 2530.0, 2540.0, 2550.5, 2560.0, 2570.5, 2580.5, 2590.0, 2600.0, 2610.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2472, 2431, 'sell', '1982-08-14');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2473, 2431, 'what', '1982-08-15');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2474, 2431, 'official', '1982-08-16');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2515, 2431, 'like', '1982-08-17');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2471, 2432, 'then', '1982-08-14');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2516, 2432, 'feeling', '1986-01-19');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2517, 2432, 'expert', '1986-01-20');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2518, 2432, 'government', '1986-01-21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.account_id FROM account AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'Prague' ORDER BY T1.date ASC, T1.account_id NULLS LAST, T2.district_id NULLS LAST LIMIT 1;

/*
Gold Result:
(2471,)
*/

-- Prediction Query
SELECT account.account_id FROM district INNER JOIN account ON district.district_id = account.district_id WHERE district.a3 = 'Prague' ORDER BY account.date ASC, district.district_id NULLS LAST, account.account_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2472,)
*/