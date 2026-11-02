-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Zeta', 'North', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Beta', 'South', '1985');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (3, 'Alpha', 'East', '2001');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (4, 'Gamma', 'West', '1995');
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (1.0, 1, 5.0, 2.0, 1.0, 8.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (2.0, 3, 3.0, 4.0, 2.0, 9.0);
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (100, 2020.0, 'League', 'UK');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (100, 1, 3, '2-1');
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (10, 2, 'Player One', 'Forward', 15.0, 3.0, '2', 19.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (20, 2, 'Player Two', 'Back', 20.0, 5.0, '0', 20.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (30, 4, 'Player Three', 'Center', 10.0, 1.0, '1', 7.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM club AS LHS WHERE NOT EXISTS(SELECT 1 FROM player AS RHS WHERE (LHS.club_id = RHS.club_id))) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT name FROM CLub WHERE NOT Club_ID IN (SELECT Club_ID FROM player);

/*
Prediction Result:
('Zeta',)
('Alpha',)
*/