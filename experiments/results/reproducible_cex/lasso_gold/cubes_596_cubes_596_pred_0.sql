-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (1034, 'Gina Moore', 1035.5, 1036.5, 'source');
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (1046, 'Andrew Stevens', 1047.5, 1048.5, 'capital');
INSERT INTO "song" ("song_id", "singer_id", "title", "sales", "highest_position") VALUES (1037, 1034, 'Legal secretary', 1038.5, 1039.5);
INSERT INTO "song" ("song_id", "singer_id", "title", "sales", "highest_position") VALUES (1043, 1034, 'Trade mark attorney', 1044.5, 1045.5);
INSERT INTO "song" ("song_id", "singer_id", "title", "sales", "highest_position") VALUES (1049, 1046, 'Multimedia specialist', 1050.5, 1051.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, name FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.birth_year AS birth_year, LHS.net_worth_millions AS net_worth_millions, LHS.citizenship AS citizenship, RHS.song_id AS song_id, RHS.title AS title, RHS.sales AS sales, RHS.highest_position AS highest_position FROM singer AS LHS INNER JOIN song AS RHS ON (LHS.singer_id = RHS.singer_id)) ORDER BY title, name NULLS LAST;

/*
Gold Result:
('Legal secretary', 'Gina Moore')
('Multimedia specialist', 'Andrew Stevens')
('Trade mark attorney', 'Gina Moore')
*/

-- Prediction Query
SELECT T2.Title, T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID;

/*
Prediction Result:
('Legal secretary', 'Gina Moore')
('Trade mark attorney', 'Gina Moore')
('Multimedia specialist', 'Andrew Stevens')
*/