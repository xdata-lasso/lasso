-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Zeta FC', 'West', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Alpha FC', 'North', '2010');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (3, 'Beta FC', 'East', '1980');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (4, 'Gamma FC', 'North', '1970');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (5, 'Delta FC', NULL, '2000');
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (1.0, 1, 5.0, 2.0, 1.0, 8.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (2.0, 1, 3.0, 1.0, 0.0, 4.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (3.0, 2, 1.0, 4.0, 2.0, 7.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (101, 1, 'John Doe', 'Forward', 20.0, 5.0, '2', 24.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (102, 1, 'Jane Roe', 'Back', 15.0, 2.0, '0', 8.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (103, 2, 'Sam Smith', 'Halfback', 30.0, 10.0, '5', 50.0);
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (10, 2021.0, 'League', 'England');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (20, 2022.0, 'Cup', 'France');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (10, 1, 2, '24-18');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (20, 2, 4, '10-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT region FROM club ORDER BY region, club.club_id NULLS LAST;

/*
Gold Result:
(None,)
('East',)
('North',)
('North',)
('West',)
*/

-- Prediction Query
SELECT DISTINCT Region FROM club ORDER BY Region ASC;

/*
Prediction Result:
(None,)
('East',)
('North',)
('West',)
*/