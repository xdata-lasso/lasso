-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO singer (singer_id, name, birth_year, net_worth_millions, citizenship) VALUES (1, 'default1', NULL, 1.0, 'default2'), (0, NULL, NULL, 1.0, 'France'), (2, 'default2', 1.0, NULL, 'France'), (3, NULL, 1.0, 1.0, 'default1'), (4, 'default2', 0.0, 1.0, 'default2'), (5, NULL, 1.0, 1.0, 'France'), (6, 'default1', NULL, 1.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "singer" WHERE ("citizenship" <> 'France') ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE Citizenship <> 'France';

/*
Prediction Result:
('default1',)
(None,)
('default2',)
('default1',)
*/