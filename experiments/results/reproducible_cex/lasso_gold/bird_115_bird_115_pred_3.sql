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
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2577, 'technology', 'south Bohemia', 'focus', 'tend', 'dog', 'inside', 2581, 2585, 2589.5, 2593, 2597.5, 2601.5, 2605, 2609, 2613);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2578, 'why', 'south Bohemia', 'focus', 'stuff', 'agent', 'get', 2598.0, 2604.0, 2610.5, 2616.0, 2622.5, 2628.5, 2634.0, 2640.0, 2646.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2579, 'magazine', 'south Bohemia', 'focus', 'try', 'receive', 'family', 2615.0, 2623.0, 2631.5, 2639.0, 2647.5, 2655.5, 2663.0, 2671.0, 2679.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2580, 'hard', 'south Bohemia', 'focus', 'drive', 'data', 'treatment', 2632.0, 2642.0, 2652.5, 2662.0, 2672.5, 2682.5, 2692.0, 2702.0, 2712.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2621, 'available', 'south Bohemia', 'focus', 'Mr', 'not', 'business', 2625, 2629, 2633.5, 2637, 2641.5, 2645.5, 2649, 2653, 2657);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2622, 'spring', 'south Bohemia', 'focus', 'instead', 'glass', 'understand', 2642.0, 2648.0, 2654.5, 2660.0, 2666.5, 2672.5, 2678.0, 2684.0, 2690.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2623, 'have', 'south Bohemia', 'focus', 'respond', 'wrong', 'every', 2659.0, 2667.0, 2675.5, 2683.0, 2691.5, 2699.5, 2707.0, 2715.0, 2723.0);
INSERT INTO "district" ("district_id", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15", "a16") VALUES (2624, 'put', 'south Bohemia', 'focus', 'threat', 'ahead', 'could', 2676.0, 2686.0, 2696.5, 2706.0, 2716.5, 2726.5, 2736.0, 2746.0, 2756.0);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2617, 'M', '1998-02-07', 2577);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2618, 'M', '1998-02-08', 2577);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2619, 'M', '1998-02-09', 2577);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2620, 'M', '1998-02-10', 2577);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2661, 'partner', '1973-06-11', 2621);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2662, 'partner', '1973-06-12', 2621);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2663, 'partner', '1973-06-13', 2621);
INSERT INTO "client" ("client_id", "gender", "birth_date", "district_id") VALUES (2664, 'partner', '1973-06-14', 2621);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) FROM client AS T1 INNER JOIN district AS T2 ON T1.district_id = T2.district_id WHERE T2.A3 = 'south Bohemia' GROUP BY T2.A4 ORDER BY T2.A4 DESC, CAST(SUM(T1.gender = 'M') AS REAL) * 100 / COUNT(T1.client_id) NULLS LAST LIMIT 1;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(IIF(T2.gender = 'M', 1, 0)) AS REAL) * 100 / COUNT(T2.gender) AS percentage_male_clients FROM district AS T1 INNER JOIN client AS T2 ON T1.district_id = T2.district_id WHERE T1.A3 = 'south Bohemia' GROUP BY T1.district_id ORDER BY T1.A4 DESC, percentage_male_clients NULLS LAST LIMIT 1;

/*
Prediction Result:
(0.0,)
*/