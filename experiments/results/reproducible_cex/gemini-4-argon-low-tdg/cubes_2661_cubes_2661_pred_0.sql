-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Boundary value testing for COUNT(*) < 5 (counts of 1, 4, 5, 6) and out-of-order insertion to test ORDER BY
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (1, 2020, 'Type_Four', 'USA');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (2, 2021, 'Type_Four', 'UK');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (3, 2022, 'Type_Four', 'France');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (4, 2023, 'Type_Four', 'Germany');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (5, 2020, 'Type_One', 'Spain');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (6, 2018, 'Type_Five', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (7, 2019, 'Type_Five', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (8, 2020, 'Type_Five', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (9, 2021, 'Type_Five', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (10, 2022, 'Type_Five', 'Italy');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (11, 2015, 'Type_Six', 'Brazil');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (12, 2016, 'Type_Six', 'Brazil');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (13, 2017, 'Type_Six', 'Brazil');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (14, 2018, 'Type_Six', 'Brazil');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (15, 2019, 'Type_Six', 'Brazil');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (16, 2020, 'Type_Six', 'Brazil');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT competition_type FROM (SELECT competition_type, COUNT(*) AS n FROM competition GROUP BY competition_type) WHERE (n < 5) ORDER BY competition_type;

/*
Gold Result:
('Type_Four',)
('Type_One',)
*/

-- Prediction Query
SELECT Competition_type FROM competition GROUP BY Competition_type HAVING COUNT(*) <= 5;

/*
Prediction Result:
('Type_Five',)
('Type_Four',)
('Type_One',)
*/