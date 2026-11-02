-- Schema DDL
CREATE TABLE "country" ("Country_id" INTEGER PRIMARY KEY, "Country_name" TEXT, "Capital" TEXT, "Official_native_language" TEXT);

CREATE TABLE "team" ("Team_id" INTEGER PRIMARY KEY, "Name" TEXT);

CREATE TABLE "match_season" ("Season" REAL PRIMARY KEY, "Team" INTEGER, "Country" INTEGER, "Player" TEXT, "Position" TEXT, "Draft_Pick_Number" INTEGER, "Draft_Class" TEXT, "College" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"), FOREIGN KEY ("Country") REFERENCES "country" ("Country_id"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Team" INTEGER, "Player" TEXT, "Years_Played" TEXT, "Total_WL" TEXT, "Singles_WL" TEXT, "Doubles_WL" TEXT, FOREIGN KEY ("Team") REFERENCES "team" ("Team_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (1, 'Argentina', 'Buenos Aires', 'Spanish');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (2, 'Brazil', 'Brasilia', 'Portuguese');
INSERT INTO country (Country_id, Country_name, Capital, Official_native_language) VALUES (3, 'Canada', 'Ottawa', 'English');
INSERT INTO team (Team_id, Name) VALUES (1, 'Alpha');
INSERT INTO team (Team_id, Name) VALUES (2, 'Bravo');
INSERT INTO team (Team_id, Name) VALUES (3, 'Charlie');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (1, 1, 'Adam', '1990', '10-1', '5-0', '5-1');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (2, 2, 'Mike', '2000', '8-2', '4-1', '4-1');
INSERT INTO player (Player_ID, Team, Player, Years_Played, Total_WL, Singles_WL, Doubles_WL) VALUES (3, 3, 'Zack', '2010', '6-4', '3-2', '3-2');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1990.0, 1, 1, 'Adam', 'Defender', 1, '1990', 'Auburn');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1991.0, 1, 1, 'Alex', 'Defender', 2, '1991', 'Auburn');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (1992.0, 1, 1, 'Andy', 'Defender', 3, '1992', 'Auburn');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2000.0, 2, 2, 'Mike', 'Midfielder', 5, '2000', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2001.0, 2, 2, 'Mitch', 'Midfielder', 6, '2001', 'Yale');
INSERT INTO match_season (Season, Team, Country, Player, Position, Draft_Pick_Number, Draft_Class, College) VALUES (2010.0, 3, 3, 'Zack', 'Striker', 10, '2010', 'Duke');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM (SELECT * FROM (SELECT * FROM (SELECT college, POSITION, MAX(n) AS n FROM (SELECT season, player, POSITION, country, team, draft_pick_number, draft_class, college, COUNT(*) OVER () AS n FROM match_season) GROUP BY college, POSITION) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('Midfielder',)
*/

-- Prediction Query
SELECT POSITION FROM match_season GROUP BY POSITION ORDER BY COUNT(*) DESC, POSITION NULLS LAST LIMIT 1;

/*
Prediction Result:
('Defender',)
*/