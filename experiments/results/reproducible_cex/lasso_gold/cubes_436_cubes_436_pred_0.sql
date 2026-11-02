-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1001, 'Northern Mariana Islands', 'Patrick Sanchez', 'offer', 1003.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1002, 'Northern Mariana Islands', 'Brian Yang', 'begin', 1014.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT nationality, COUNT(*) AS n FROM people GROUP BY nationality) WHERE (n > 2) ORDER BY nationality;

/*
Gold Result:
*/

-- Prediction Query
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Northern Mariana Islands',)
*/