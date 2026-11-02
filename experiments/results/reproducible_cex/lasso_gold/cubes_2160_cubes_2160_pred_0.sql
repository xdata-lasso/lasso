-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('product', 'Arthur James', 'Bouvet Island (Bouvetoya)', 'long');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('collection', 'Kendra Maddox DVM', 'French Polynesia', 'about');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('structure', 'Nathan Maldonado', 'Jordan', 'seven');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('response', 'Debra Davidson', 'Cayman Islands', 'type');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('dark', 'Clifford Ford', 'Sao Tome and Principe', 'investment');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('customer', 'Angela Morton', 'Thailand', 'mention');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('not', 'Annette Pearson', 'Dominica', 'medical');
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('list', 'Alexis Davis', 'Chad', 'different');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1009, 'product', '148 Eric Track
New Stephanie, NC 00575', 'Timothy Duncan', 'report', 1013, 'Art rock song body.');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1010, 'product', '15430 Natalie Common Apt. 718
East Donna, OH 22144', 'Richard Aguirre', 'report', 1026.0, 'Art rock song body.');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1011, 'product', '83465 Lam Mission Apt. 331
Andrewside, IN 77629', 'Brent Jordan', 'report', 1039.0, 'Art rock song body.');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1012, 'product', '031 Michele Cliffs
West Elizabeth, IL 71179', 'John Daniel', 'report', 1052.0, 'Art rock song body.');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1017, NULL, '60647 Henderson Street
Mooreport, IL 08166', 'Carlos Brewer', 'cause', 1021, 'Thing these hard citizen street region.');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1018, NULL, '500 Shaw Walk
North Susan, CO 24857', 'Timothy Walls', 'cause', 1034.0, 'Thing these hard citizen street region.');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1019, NULL, '361 Beth Canyon
South Dianeshire, NC 41968', 'Marc Hart', 'cause', 1047.0, 'Thing these hard citizen street region.');
INSERT INTO "mill" ("id", "architect_id", "location", "name", "type", "built_year", "notes") VALUES (1020, NULL, 'USNS Santiago
FPO AA 31786', 'Joshua Wagner', 'cause', 1060.0, 'Thing these hard citizen street region.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT notes, TYPE, COUNT(*) AS n FROM mill GROUP BY notes, TYPE) ORDER BY TYPE DESC) LIMIT 1);

/*
Gold Result:
('report', 4)
*/

-- Prediction Query
SELECT TYPE, COUNT(*) FROM mill GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('cause', 4)
*/