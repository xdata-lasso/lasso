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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2316, 'summer', 'apply', 'campaign', 'region', 'free', 'position', 2320, 2324, 2328.5, 2332, 2336.5, 2340.5, 2344, 2348, 2352);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2318, 'safe', 'onto', 'loss', 'nice', 'someone', 'teacher', 2337.0, 2343.0, 2349.5, 2355.0, 2361.5, 2367.5, 2373.0, 2379.0, 2385.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2319, 'national', 'enjoy', 'cell', 'operation', 'vote', 'wait', 2354.0, 2362.0, 2370.5, 2378.0, 2386.5, 2394.5, 2402.0, 2410.0, 2418.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2364, 'majority', 'whose', 'suddenly', 'physical', 'level', 'mother', 2371.0, 2381.0, 2391.5, 2401.0, 2411.5, 2421.5, 2431.0, 2441.0, 2451.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2317, 'watch', 'listen', 'public', 'near', 'face', 'feeling', 2368, 2372, 2376.5, 2332, 2384.5, 2388.5, 2392, 2396, 2400);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2365, 'cold', 'event', 'factor', 'memory', 'less', 'expert', 2385.0, 2391.0, 2397.5, 2403.0, 2409.5, 2415.5, 2421.0, 2427.0, 2433.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2366, 'six', 'end', 'space', 'produce', 'bank', 'front', 2402.0, 2410.0, 2418.5, 2426.0, 2434.5, 2442.5, 2450.0, 2458.0, 2466.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2367, 'training', 'though', 'star', 'edge', 'sell', 'now', 2419.0, 2429.0, 2439.5, 2449.0, 2459.5, 2469.5, 2479.0, 2489.0, 2499.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2356, 2316, 'last', '1981-06-08');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2358, 2316, 'then', '1981-06-09');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2359, 2316, 'what', '1981-06-10');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2404, 2316, 'like', '1981-06-11');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2357, 2317, 'be', '1989-03-16');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2405, 2317, 'certainly', '1989-03-17');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2406, 2317, 'city', '1989-03-18');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2407, 2317, 'during', '1989-03-19');
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2361, 'F', '1985-10-12', 2316);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2362, 'F', '1985-10-13', 2316);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2363, 'F', '1985-10-14', 2316);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2408, 'F', '1985-10-15', 2316);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2360, 'F', '1985-10-12', 2317);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2409, 'F', '1993-07-21', 2317);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2410, 'F', '1993-07-22', 2317);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2411, 'F', '1993-07-23', 2317);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.account_id FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id INNER JOIN account AS T3 ON T2.district_id = T3.district_id WHERE T1.gender = 'F' ORDER BY T1.birth_date ASC, T2.A11 ASC, T1.client_id NULLS LAST, T2.district_id NULLS LAST, T3.account_id NULLS LAST LIMIT 1;

/*
Gold Result:
(2357,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id INNER JOIN district AS T3 ON T2.district_id = T3.district_id WHERE T2.gender = 'F' ORDER BY T2.birth_date ASC, T3.A11 ASC, T1.account_id NULLS LAST, T2.client_id NULLS LAST, T3.district_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2356,)
*/