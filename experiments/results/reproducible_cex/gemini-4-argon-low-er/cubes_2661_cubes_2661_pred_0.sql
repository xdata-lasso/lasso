-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (1, 2020, 'Tournament', 'USA');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (2, 2021, 'Tournament', 'USA');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (3, 2022, 'Tournament', 'USA');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (4, 2023, 'Tournament', 'USA');
INSERT INTO competition (Competition_ID, Year, Competition_type, Country) VALUES (5, 2024, 'Tournament', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT competition_type FROM (SELECT competition_type, COUNT(*) AS n FROM competition GROUP BY competition_type) WHERE (n < 5) ORDER BY competition_type;

/*
Gold Result:
*/

-- Prediction Query
SELECT Competition_type FROM competition GROUP BY Competition_type HAVING COUNT(*) <= 5;

/*
Prediction Result:
('Tournament',)
*/