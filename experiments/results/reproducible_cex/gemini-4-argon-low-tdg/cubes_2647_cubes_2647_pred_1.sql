-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic alphabetical sorting, duplicate names (DISTINCT vs ALL), NULL values in 'name', and inverse relationship between Club_ID and name.
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (3, 'Alpha', 'North', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Charlie', 'South', '1985');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Bravo', 'East', '2000');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (4, 'Alpha', 'West', '1995');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (5, NULL, 'Central', '2010');
-- Foreign key data to detect unexpected INNER JOINs (Club 3, 4, 5 are omitted from child tables, Club 1 is duplicated)
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (1.0, 1, 5.0, 2.0, 1.0, 8.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (2.0, 1, 2.0, 3.0, 1.0, 6.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (101, 1, 'John Doe', 'Forward', 10.0, 2.0, '1', 10.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (102, 1, 'Jane Smith', 'Back', 15.0, 5.0, '0', 20.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (103, 2, 'Bob Brown', 'Center', 8.0, 1.0, '2', 8.0);
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (10, 2020.0, 'League', 'UK');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (10, 1, 2, '20-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM club ORDER BY name, club.club_id NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Alpha',)
('Bravo',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM club ORDER BY Start_year ASC, club.club_id NULLS LAST;

/*
Prediction Result:
('Charlie',)
('Alpha',)
('Alpha',)
('Bravo',)
(None,)
*/