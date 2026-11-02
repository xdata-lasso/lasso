-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (1, 'Arsenal', 'London', '1886');
INSERT INTO club (Club_ID, name, Region, Start_year) VALUES (2, 'Chelsea', 'London', '1905');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (101, 2020, 'League', 'UK');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (102, 2021, 'League', 'UK');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (103, 2018, 'Derby', 'Spain');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (104, 2019, 'Derby', 'Spain');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (105, 2020, 'Derby', 'Spain');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (106, 2021, 'Derby', 'Spain');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (107, 2022, 'Friendly', 'France');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (108, 2015, 'Qualifier', 'Germany');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (109, 2016, 'Qualifier', 'Germany');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (110, 2017, 'Qualifier', 'Germany');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (111, 2018, 'Qualifier', 'Germany');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (112, 2019, 'Qualifier', 'Germany');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (113, 2010, 'Tournament', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (114, 2011, 'Tournament', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (115, 2012, 'Tournament', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (116, 2013, 'Tournament', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (117, 2014, 'Tournament', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (118, 2015, 'Tournament', 'Italy');
INSERT INTO competition_result (Competition_ID, Club_ID_1, Club_ID_2, Score) VALUES (101, 1, 2, '2-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT competition_type FROM (SELECT competition_type, COUNT(*) AS n FROM competition GROUP BY competition_type) WHERE (n < 5) ORDER BY competition_type;

/*
Gold Result:
('Derby',)
('Friendly',)
('League',)
*/

-- Prediction Query
SELECT Competition_type FROM competition GROUP BY Competition_type HAVING COUNT(*) <= 5;

/*
Prediction Result:
('Derby',)
('Friendly',)
('League',)
('Qualifier',)
*/