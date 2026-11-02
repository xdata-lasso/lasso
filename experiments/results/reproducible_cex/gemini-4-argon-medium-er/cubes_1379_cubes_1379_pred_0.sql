-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (1, 'Zulu', 'CapZ', 'LangZ');
INSERT INTO "country" ("Country_id", "Country_name", "Capital", "Official_native_language") VALUES (2, 'Alpha', 'CapA', 'LangA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_name, capital FROM country ORDER BY country_name, country.country_id NULLS LAST;

/*
Gold Result:
('Alpha', 'CapA')
('Zulu', 'CapZ')
*/

-- Prediction Query
SELECT Country_name, Capital FROM country;

/*
Prediction Result:
('Zulu', 'CapZ')
('Alpha', 'CapA')
*/