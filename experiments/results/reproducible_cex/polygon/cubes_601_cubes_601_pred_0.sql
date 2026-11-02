-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (34, '37', 30, 31, '32');
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (16, '34', 34, 34, '34');
INSERT INTO "song" ("song_id", "singer_id", "title", "sales", "highest_position") VALUES (22, NULL, '23', 300000, 25);
INSERT INTO "song" ("song_id", "singer_id", "title", "sales", "highest_position") VALUES (33, 34, '35', 300001, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.song_id AS song_id, LHS.title AS title, LHS.singer_id AS singer_id, LHS.sales AS sales, LHS.highest_position AS highest_position, RHS.name AS name, RHS.birth_year AS birth_year, RHS.net_worth_millions AS net_worth_millions, RHS.citizenship AS citizenship FROM song AS LHS LEFT JOIN singer AS RHS ON (LHS.singer_id = RHS.singer_id)) WHERE (sales >= 300000.0) ORDER BY name;

/*
Gold Result:
(None,)
('37',)
*/

-- Prediction Query
SELECT DISTINCT T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID WHERE T2.Sales > 300000;

/*
Prediction Result:
('37',)
*/