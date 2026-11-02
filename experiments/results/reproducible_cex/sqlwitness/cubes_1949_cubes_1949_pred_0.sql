-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artwork (artwork_id, type, name) VALUES (0, 'default2', 'default2'), (2, 'default2', NULL), (1, 'default2', 'default1'), (3, 'default2', 'default1'), (4, NULL, 'default2'), (5, NULL, NULL), (6, NULL, NULL), (7, NULL, NULL), (8, 'default1', 'default1'), (9, 'default2', 'default2'), (10, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM (SELECT * FROM (SELECT * FROM (SELECT name, TYPE, COUNT(*) AS n FROM artwork GROUP BY name, TYPE) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT TYPE FROM artwork GROUP BY TYPE ORDER BY COUNT(*) DESC, TYPE NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/