-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (10, 'Zeta FC', 'North', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (20, 'Alpha United', 'South', '2005');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (30, 'Alpha United', 'East', '1980');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (5, 'beta Rovers', 'West', '2000');
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (1.0, 10, 5.0, 2.0, 1.0, 8.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (2.0, 10, 3.0, 1.0, 0.0, 4.0);
INSERT INTO club_rank (Rank, Club_ID, Gold, Silver, Bronze, Total) VALUES (3.0, 20, 1.0, 4.0, 2.0, 7.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (1, 20, 'John Doe', 'Forward', 15.0, 5.0, '2', 24.0);
INSERT INTO player (Player_ID, Club_ID, name, Position, Apps, Tries, Goals, Points) VALUES (2, 20, 'Jane Smith', 'Back', 20.0, 8.0, '10', 52.0);
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (100, 2020.0, 'League', 'UK');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (100, 10, 20, '24-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM club ORDER BY name, club.club_id NULLS LAST;

/*
Gold Result:
('Alpha United',)
('Alpha United',)
('Zeta FC',)
('beta Rovers',)
*/

-- Prediction Query
SELECT name FROM club ORDER BY Start_year ASC, club.club_id NULLS LAST;

/*
Prediction Result:
('Alpha United',)
('Zeta FC',)
('beta Rovers',)
('Alpha United',)
*/