-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO singer (singer_id, name, birth_year, net_worth_millions, citizenship) VALUES (1948, NULL, 1947.0, 1949.0, NULL), (0, 'default2', 1949.0, 1947.0, 'default2'), (1947, NULL, 1.0, NULL, 'default2'), (1, 'default2', 1.0, 1948.0, 'default1'), (1949, 'default1', 1949.0, 1.0, NULL), (1950, 'default1', 1947.0, 0.0, NULL), (2, NULL, 1.0, 1948.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM singer WHERE (birth_year >= 1948.0 AND birth_year <= 1949.0) ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE Birth_Year = 1948 OR Birth_Year = 1949;

/*
Prediction Result:
('default2',)
('default1',)
*/