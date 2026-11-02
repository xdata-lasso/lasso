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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2217, 'recognize', 'central', 'ever', 'green', 'soldier', 'they', 2221, 2225, 2229.5, 2233, 2237.5, 2241.5, 2245, 2249, 2253);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2218, 'because', 'trial', 'generation', 'sort', 'theory', 'beat', 2238.0, 2244.0, 2250.5, 2256.0, 2262.5, 2268.5, 2274.0, 2280.0, 2286.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2219, 'question', 'main', 'development', 'until', 'know', 'many', 2255.0, 2263.0, 2271.5, 2279.0, 2287.5, 2295.5, 2303.0, 2311.0, 2319.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2220, 'later', 'court', 'look', 'fall', 'entire', 'after', 2272.0, 2282.0, 2292.5, 2302.0, 2312.5, 2322.5, 2332.0, 2342.0, 2352.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2277, 'scene', 'computer', 'box', 'forget', 'year', 'product', 2281, 2285, 2289.5, 2293, 2297.5, 2301.5, 2305, 2309, 2313);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2278, 'establish', 'police', 'particular', 'whatever', 'senior', 'eight', 2298.0, 2304.0, 2310.5, 2316.0, 2322.5, 2328.5, 2334.0, 2340.0, 2346.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2279, 'speak', 'common', 'agree', 'how', 'bag', 'blue', 2315.0, 2323.0, 2331.5, 2339.0, 2347.5, 2355.5, 2363.0, 2371.0, 2379.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2280, 'home', 'foreign', 'woman', 'industry', 'rock', 'spring', 2332.0, 2342.0, 2352.5, 2362.0, 2372.5, 2382.5, 2392.0, 2402.0, 2412.0);
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2257, 2217, 'so', '1993-05-13');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2258, 2217, 'notice', '1993-05-14');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2259, 2217, 'area', '1993-05-15');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2260, 2217, 'hard', '1993-05-16');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2317, 2277, 'return', '1997-09-17');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2318, 2277, 'plan', '1997-09-18');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2319, 2277, 'support', '1997-09-19');
INSERT INTO "account" ("account_id", "district_id", "frequency", "date") VALUES (2320, 2277, 'camera', '1997-09-20');
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2262, 2257, '1995-01-01', 'door', 'no', 2265, 2269, 'decision', 'relationship', 2273);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2263, 2257, '1995-01-01', 'rate', 'amount', 2278.0, 2284.0, 'those', 'building', 2294.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2264, 2257, '1995-01-01', 'authority', 'somebody', 2291.0, 2299.0, 'pretty', 'yourself', 2315.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2321, 2257, '1995-01-01', 'statement', 'allow', 2304.0, 2314.0, 'card', 'discover', 2336.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2261, 2317, '1995-01-01', 'others', 'reach', 2266, 2270, 'raise', 'test', 2274);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2322, 2317, '1995-01-01', 'stay', 'recently', 2338.0, 2344.0, 'growth', 'might', 2354.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2323, 2317, '1995-01-01', 'analysis', 'hospital', 2351.0, 2359.0, 'actually', 'born', 2375.0);
INSERT INTO "trans" ("trans_id", "account_id", "date", "type", "operation", "amount", "balance", "k_symbol", "bank", "account") VALUES (2324, 2317, '1995-01-01', 'hand', 'move', 2364.0, 2374.0, 'time', 'lead', 2396.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id FROM trans WHERE STRFTIME('%Y', date) = '1995' ORDER BY date ASC, trans.trans_id NULLS LAST LIMIT 1;

/*
Gold Result:
(2317,)
*/

-- Prediction Query
SELECT T1.account_id FROM account AS T1 INNER JOIN trans AS T2 ON T1.account_id = T2.account_id WHERE STRFTIME('%Y', T2.date) = '1995' GROUP BY T1.account_id ORDER BY MIN(T2.date), T1.account_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2257,)
*/