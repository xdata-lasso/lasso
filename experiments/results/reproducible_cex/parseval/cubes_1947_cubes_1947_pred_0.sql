-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: festival_detail --
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1, 't3__b24572', '4', 'gu7v', -1865039888, 1160656988);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (2, 't3__b24572', 'dpos', 'ie5', -1209887326, -1399556171);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (-2147483647, 't3__b24572', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (3, '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 1836127587, -1529584866);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (6, '5k5swwqcgs', '9n8', '4', -734455130, 1744686505);

INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (8, 'hria2ypu', 'hsrwbbp', 'luhvdltti', -1364429300, -1257178728);

-- Inserting into table: artwork --
INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (1, '5k5swwqcgs', '9n8');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (-2147483647, 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (2, 'rofqyp5s5b', 'p');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (3, '02eutliqa11r', 'ytoo3o9');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (4, 'klex14ji', '7zwau2dwyr');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (7, 'mdpos', 'ie5');

INSERT INTO "artwork" ("artwork_id", "type", "name") VALUES (5, 'nw6klf', 'a9000t5c4eci');

-- Inserting into table: nomination --
INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (1, 1, 'ia2yp');

INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (1, 2, '4nrq');

INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (3, 1, 'l7');

INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (4, 1, '13pyu');

INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (1, 3, 'd2');

INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (7, 3, 'gce376nium52');

INSERT INTO "nomination" ("artwork_id", "festival_id", "result") VALUES (-2147483647, 3, 'zbuo4nrqrof');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT festival_id, festival_name FROM (SELECT festival_id, festival_name, chair_name, LOCATION, YEAR, num_of_audience, artwork_id, TYPE, name, RESULT, COUNT(*) OVER () AS n FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, LHS.artwork_id AS artwork_id, LHS.type AS TYPE, LHS.name AS name, RHS.result AS RESULT FROM (SELECT LHS.festival_id AS festival_id, LHS.festival_name AS festival_name, LHS.chair_name AS chair_name, LHS.location AS LOCATION, LHS.year AS YEAR, LHS.num_of_audience AS num_of_audience, RHS.artwork_id AS artwork_id, RHS.type AS TYPE, RHS.name AS name FROM festival_detail AS LHS CROSS JOIN artwork AS RHS) AS LHS INNER JOIN nomination AS RHS ON (LHS.festival_id = RHS.festival_id AND LHS.artwork_id = RHS.artwork_id))) WHERE (n >= 2) ORDER BY festival_id, festival_name NULLS LAST;

/*
Gold Result:
(1, 't3__b24572')
(2, 't3__b24572')
(3, '8d99rljsl')
*/

-- Prediction Query
SELECT T1.Festival_ID, T3.Festival_Name FROM nomination AS T1 JOIN artwork AS T2 ON T1.Artwork_ID = T2.Artwork_ID JOIN festival_detail AS T3 ON T1.Festival_ID = T3.Festival_ID GROUP BY T1.Festival_ID HAVING COUNT(*) >= 2;

/*
Prediction Result:
(1, 't3__b24572')
(3, '8d99rljsl')
*/