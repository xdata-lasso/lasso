-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO browser (id, name, market_share) VALUES (1, 'Chrome', 60.5);
INSERT INTO browser (id, name, market_share) VALUES (2, 'Safari', 60.5);
INSERT INTO browser (id, name, market_share) VALUES (3, 'Firefox', 5.0);
INSERT INTO browser (id, name, market_share) VALUES (4, 'Edge', 4.99);
INSERT INTO browser (id, name, market_share) VALUES (5, 'Opera', 1.2);
INSERT INTO browser (id, name, market_share) VALUES (6, 'Brave', NULL);
INSERT INTO Web_client_accelerator (id, name, Operating_system, Client, Connection) VALUES (1, 'Acc1', 'Windows', 'Desktop', 'Broadband');
INSERT INTO accelerator_compatible_browser (accelerator_id, browser_id, compatible_since_year) VALUES (1, 1, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT market_share) AS n_distinct FROM (SELECT * FROM browser WHERE (market_share >= 5.0))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM browser WHERE market_share >= 5;

/*
Prediction Result:
(3,)
*/