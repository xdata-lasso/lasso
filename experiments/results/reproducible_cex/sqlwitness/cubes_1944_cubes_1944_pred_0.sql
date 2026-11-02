-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artwork (artwork_id, type, name) VALUES (0, 'default1', 'default1'), (1, NULL, 'default2'), (2, 'default2', 'default1'), (3, 'default2', NULL), (4, NULL, NULL), (5, 'default1', 'default2'), (6, NULL, NULL);
INSERT INTO festival_detail (festival_id, festival_name, chair_name, location, year, num_of_audience) VALUES (0, 'default1', NULL, 'default2', 0, 1), (2, 'default1', 'default1', NULL, NULL, 2);
INSERT INTO nomination (artwork_id, festival_id, result) VALUES (2, 0, NULL), (0, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artwork AS LHS WHERE NOT EXISTS(SELECT 1 FROM nomination AS RHS WHERE (LHS.artwork_id = RHS.artwork_id))) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
(None,)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM Artwork WHERE NOT Artwork_ID IN (SELECT Artwork_ID FROM nomination);

/*
Prediction Result:
('default2',)
(None,)
(None,)
('default2',)
(None,)
*/