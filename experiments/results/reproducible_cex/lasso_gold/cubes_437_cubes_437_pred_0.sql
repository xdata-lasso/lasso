-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1009, 'Reunion', 'Connie Lawrence', 'bill', 1013.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1010, 'Reunion', 'Abigail Shaffer', 'her', 1024.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1011, 'Reunion', 'Gina Moore', 'throw', 1035.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1012, 'Reunion', 'Gabrielle Davis', 'guy', 1046.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1017, NULL, 'Andrew Stevens', 'recently', 1021.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1018, NULL, 'Thomas Miller', 'drive', 1032.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1019, NULL, 'Mark Mcclure', 'spring', 1043.5);
INSERT INTO "people" ("people_id", "nationality", "name", "birth_date", "height") VALUES (1020, NULL, 'Corey Jones', 'figure', 1054.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT * FROM (SELECT * FROM (SELECT nationality, COUNT(*) AS n FROM people GROUP BY nationality) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Nationality FROM people GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
('Reunion',)
*/