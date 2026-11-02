-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'Zimbabwe', 'Harare', 'English');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'Austria', 'Vienna', 'German');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (3, 'Brazil', 'Brasilia', 'Portuguese');
INSERT INTO team (Team_id, Name) VALUES (1, 'Alpha');
INSERT INTO team (Team_id, Name) VALUES (2, 'Beta');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2020.0, 1, 1, 'John Doe', 'Forward', 1, '2020', 'State U');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2021.0, 2, 1, 'Jane Roe', 'Guard', 2, '2021', 'Tech U');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2022.0, 1, 2, 'Max Mustermann', 'Center', 3, '2022', 'City U');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 1, 'John Doe', '2020-2022', '10-2', '6-1', '4-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country_name, capital FROM country ORDER BY country_name, country.country_id NULLS LAST;

/*
Gold Result:
('Austria', 'Vienna')
('Brazil', 'Brasilia')
('Zimbabwe', 'Harare')
*/

-- Prediction Query
SELECT Country_name, Capital FROM country;

/*
Prediction Result:
('Zimbabwe', 'Harare')
('Austria', 'Vienna')
('Brazil', 'Brasilia')
*/