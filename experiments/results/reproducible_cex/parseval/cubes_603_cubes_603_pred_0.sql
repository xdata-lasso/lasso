-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: singer --
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (1, 'sin_37121f', 1.0, 1.0, 'sin_8df947');

INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (2, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe');

INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (3, 'hria2ypu', 882.963176, 841.297061, 'rwbbp');

INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (4, 'luhvdltti', 182.319045, 998.421621, 'prmd');

INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (5, 'posiie5unw6k', 768.216462, 83.204633, '9');

INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (6, '00t5c4e', 950.466571, 796.740316, 'gce');

INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (7, '76nium52', 816.814398, 396.776796, 'uo4nrqrofqy');

INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (8, '5s5b', 22.720462, 990.777211, '02eutliqa11r');

INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (9, 'ytoo3o9', 111.926013, 731.301441, '72klex14ji7z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT citizenship FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.birth_year AS birth_year, LHS.net_worth_millions AS net_worth_millions, LHS.citizenship AS citizenship, LHS.n AS n, RHS.name AS name_other, RHS.birth_year AS birth_year_other, RHS.net_worth_millions AS net_worth_millions_other, RHS.n AS n_other FROM (SELECT singer_id, name, birth_year, net_worth_millions, citizenship, COUNT(*) OVER () AS n FROM singer) AS LHS INNER JOIN (SELECT singer_id, name, birth_year, net_worth_millions, citizenship, COUNT(*) OVER () AS n FROM singer) AS RHS ON (LHS.n = RHS.singer_id AND LHS.citizenship = RHS.citizenship)) ORDER BY citizenship;

/*
Gold Result:
('72klex14ji7z',)
*/

-- Prediction Query
SELECT Citizenship FROM singer GROUP BY Citizenship ORDER BY COUNT(*) DESC, Citizenship NULLS LAST LIMIT 1;

/*
Prediction Result:
('02eutliqa11r',)
*/