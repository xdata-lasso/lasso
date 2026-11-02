-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (0, '15', 16, 17, '18');
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (12, '0', 0, 0, NULL);
INSERT INTO "song" ("song_id", "singer_id", "title", "sales", "highest_position") VALUES (14, 12, '0', 0, 0);
INSERT INTO "song" ("song_id", "singer_id", "title", "sales", "highest_position") VALUES (13, 12, '0', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT citizenship FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.birth_year AS birth_year, LHS.net_worth_millions AS net_worth_millions, LHS.citizenship AS citizenship, LHS.n AS n, RHS.name AS name_other, RHS.birth_year AS birth_year_other, RHS.net_worth_millions AS net_worth_millions_other, RHS.n AS n_other FROM (SELECT singer_id, name, birth_year, net_worth_millions, citizenship, COUNT(*) OVER () AS n FROM singer) AS LHS INNER JOIN (SELECT singer_id, name, birth_year, net_worth_millions, citizenship, COUNT(*) OVER () AS n FROM singer) AS RHS ON (LHS.n = RHS.singer_id AND LHS.citizenship = RHS.citizenship)) ORDER BY citizenship;

/*
Gold Result:
*/

-- Prediction Query
SELECT Citizenship FROM singer GROUP BY Citizenship ORDER BY COUNT(*) DESC, Citizenship NULLS LAST LIMIT 1;

/*
Prediction Result:
('18',)
*/