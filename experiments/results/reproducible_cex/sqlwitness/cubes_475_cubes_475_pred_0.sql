-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (1, 'default2', 'default2', 0, 0, 0, 1), (2, NULL, NULL, NULL, 0, 2, NULL), (0, 'default1', 'default2', 0, 1, 2, 2), (3, NULL, 'default1', 2, 2, 0, NULL), (4, 'default1', 'default2', 0, 2, NULL, 0), (5, 'default1', 'default1', 2, 2, 0, 0);
INSERT INTO concert (concert_id, stadium_id, concert_name, theme, year) VALUES (1, NULL, 'default1', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM concert AS RHS WHERE (LHS.stadium_id = RHS.stadium_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE NOT stadium_id IN (SELECT stadium_id FROM concert);

/*
Prediction Result:
*/