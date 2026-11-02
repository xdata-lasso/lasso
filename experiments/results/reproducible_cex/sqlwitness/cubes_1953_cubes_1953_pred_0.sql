-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO festival_detail (festival_id, festival_name, chair_name, location, year, num_of_audience) VALUES (2006, NULL, 'default1', NULL, NULL, NULL), (2008, NULL, 'default2', 'default1', NULL, 1), (0, NULL, 'default2', NULL, 2007, 1), (1, 'default2', NULL, 'default1', NULL, 2008), (2007, 'default2', 'default2', NULL, 2008, 0), (2, 'default1', NULL, NULL, 0, 0), (3, 'default1', NULL, 'default1', 2007, 1), (4, 'default1', 'default1', 'default2', 0, 2006), (5, 'default1', NULL, 'default2', 1, 2006), (6, 'default1', NULL, 'default2', 2006, 2007), (7, 'default2', NULL, 'default2', 2007, 2008), (8, 'default2', NULL, 'default1', 2006, 0), (9, 'default2', 'default2', 'default2', 2008, NULL), (10, NULL, 'default2', 'default2', 2008, 1), (11, 'default2', NULL, NULL, 2008, 2007), (12, 'default2', NULL, 'default2', 0, 2006), (13, 'default2', 'default1', 'default2', 2006, NULL), (14, 'default1', 'default2', 'default2', 2007, 2006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT festival_name FROM festival_detail WHERE (YEAR = 2007) ORDER BY festival_name, festival_detail.festival_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Festival_Name FROM festival_detail WHERE YEAR = 2007;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
('default1',)
*/