-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Alpha FC', 'North', '1990');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Beta United', 'South', '1995');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (1, 2020.0, 'Tournament', 'USA');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (2, 2010.0, 'Tournament', 'Australia');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (3, 2015.0, 'League', 'UK');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (4, 2015.0, 'League', 'UK');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (5, 2005.0, 'Cup', 'France');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (1, 1, 2, '2-1');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (1, 2, 1, '0-3');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (3, 1, 2, '1-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT competition_type, country FROM competition ORDER BY competition_type, competition.competition_id NULLS LAST;

/*
Gold Result:
('Cup', 'France')
('League', 'UK')
('League', 'UK')
('Tournament', 'USA')
('Tournament', 'Australia')
*/

-- Prediction Query
SELECT Competition_type, Country FROM competition;

/*
Prediction Result:
('Tournament', 'USA')
('Tournament', 'Australia')
('League', 'UK')
('League', 'UK')
('Cup', 'France')
*/