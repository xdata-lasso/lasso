-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: festival_detail --
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 1, -734455130);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483647, '4h', 'ia2yp', 'uzhsrwbbp6lu', 1, 1019800248);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483646, 'dlttil', 'n', 'rmdp', 1, 2026480202);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (2, 'ie5', 'nw6klf', 'a9000t5c4eci', 1, 1149850321);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (3, 'e', '76nium52', 'zbuo4nrqrof', 1, 373262291);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483645, 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', 1, -1666765085);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483642, '72klex14ji7z', 'au2dwy', 'q13py', 1, 244829661);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483641, 'jsl', 'b4yp5qi', 'rkf9vqx5', 1, 1836127587);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483640, 'f8jegd2', 'vy9uxj4', 'wb', 1, -1929953647);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483639, 'ph2', 'nd', 'wnqcx', 1, 722884590);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483638, 'hncprjtu0dz', '9fjgq8n2f', 'dqv0gcb9', 1, 172461907);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483637, 'k3zbily', 'kn6vc', '6ah', 1, -348113485);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483636, 'jswwlq7xb', '72fxa7ryfd', 'z16ni', NULL, 2011234363);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483635, 'ai5', 'h', 'ogrgjd8y', NULL, 1129658414);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483634, '1afgo', 'ri', 'tsj3ayxp1q4', NULL, -1538707438);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (5, 'den8c68x', 'vacx7afu5', '1of77p', 1, -435350511);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (4, '72ctdctmfg62', '0v', 'q8qdjpe1', 1, -1180042408);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483631, '5k5swwqcgs', '9n8', '4', 2, -734455130);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (6, '4h', 'ia2yp', 'uzhsrwbbp6lu', 1019800248, -1910425938);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR FROM (SELECT * FROM (SELECT * FROM (SELECT festival_id, festival_name, chair_name, LOCATION, YEAR, num_of_audience, COUNT(*) OVER () AS n FROM festival_detail) ORDER BY festival_name) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT YEAR FROM festival_detail GROUP BY YEAR HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
(1,)
*/