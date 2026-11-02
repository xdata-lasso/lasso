-- Schema DDL
CREATE TABLE "Web_client_accelerator" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Operating_system" TEXT, "Client" TEXT, "Connection" TEXT);

CREATE TABLE "browser" ("id" INTEGER PRIMARY KEY, "name" TEXT, "market_share" REAL);

CREATE TABLE "accelerator_compatible_browser" ("accelerator_id" INTEGER, "browser_id" INTEGER, "compatible_since_year" INTEGER, PRIMARY KEY ("accelerator_id", "browser_id"), FOREIGN KEY ("browser_id") REFERENCES "browser" ("id"), FOREIGN KEY ("accelerator_id") REFERENCES "Web_client_accelerator" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Web_client_accelerator (id, name, Operating_system, Client, Connection) VALUES (1, 'FastWeb', 'Windows', 'Desktop', 'Broadband');
INSERT INTO Web_client_accelerator (id, name, Operating_system, Client, Connection) VALUES (2, 'TurboNet', 'Linux', 'Mobile', 'Fiber');
INSERT INTO browser (id, name, market_share) VALUES (1, 'Chrome', 5.0);
INSERT INTO browser (id, name, market_share) VALUES (2, 'Chrome', 10.5);
INSERT INTO browser (id, name, market_share) VALUES (3, 'Chrome', 10.5);
INSERT INTO browser (id, name, market_share) VALUES (4, 'Firefox', 20.0);
INSERT INTO browser (id, name, market_share) VALUES (5, 'Firefox', 30.0);
INSERT INTO browser (id, name, market_share) VALUES (6, 'Opera', 4.9);
INSERT INTO browser (id, name, market_share) VALUES (7, 'Brave', 1.5);
INSERT INTO browser (id, name, market_share) VALUES (8, 'Vivaldi', 1.5);
INSERT INTO browser (id, name, market_share) VALUES (9, 'Tor', NULL);
INSERT INTO accelerator_compatible_browser (accelerator_id, browser_id, compatible_since_year) VALUES (1, 2, 2018);
INSERT INTO accelerator_compatible_browser (accelerator_id, browser_id, compatible_since_year) VALUES (2, 2, 2020);
INSERT INTO accelerator_compatible_browser (accelerator_id, browser_id, compatible_since_year) VALUES (1, 6, 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT market_share) AS n_distinct FROM (SELECT * FROM browser WHERE (market_share >= 5.0))) ORDER BY count___;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM browser WHERE market_share >= 5;

/*
Prediction Result:
(5,)
*/