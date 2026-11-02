-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by competition_type (ASC vs DESC), tie-breaking by competition_id (ASC vs DESC) with inverted country order to ensure competition_id is used rather than country, and verifies that SELECT DISTINCT is not mistakenly used.
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (20, 2010.0, 'League', 'USA');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (10, 2015.0, 'League', 'Zambia');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (5, 2020.0, 'Cup', 'Canada');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (15, 2018.0, 'Cup', 'Canada');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (1, 2005.0, 'Tournament', 'France');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT competition_type, country FROM competition ORDER BY competition_type, competition.competition_id NULLS LAST;

/*
Gold Result:
('Cup', 'Canada')
('Cup', 'Canada')
('League', 'Zambia')
('League', 'USA')
('Tournament', 'France')
*/

-- Prediction Query
SELECT Competition_type, Country FROM competition;

/*
Prediction Result:
('Tournament', 'France')
('Cup', 'Canada')
('League', 'Zambia')
('Cup', 'Canada')
('League', 'USA')
*/