-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, NULL, 'CapitalA', 'LangA');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'Zimbabwe', NULL, 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (3, 'Albania', 'Tirana', NULL);
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (4, NULL, 'CapitalB', 'LangB');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_name, capital FROM country ORDER BY country_name, country.country_id NULLS LAST;

/*
Gold Result:
(None, 'CapitalA')
(None, 'CapitalB')
('Albania', 'Tirana')
('Zimbabwe', None)
*/

-- Prediction Query
SELECT Country_name, Capital FROM country;

/*
Prediction Result:
(None, 'CapitalA')
('Zimbabwe', None)
('Albania', 'Tirana')
(None, 'CapitalB')
*/