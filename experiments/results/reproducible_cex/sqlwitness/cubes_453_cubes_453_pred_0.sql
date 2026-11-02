-- Schema DDL
CREATE TABLE "poker_player" ("Poker_Player_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Final_Table_Made" REAL, "Best_Finish" REAL, "Money_Rank" REAL, "Earnings" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Nationality" TEXT, "Name" TEXT, "Birth_Date" TEXT, "Height" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, nationality, name, birth_date, height) VALUES (1, 'default1', 'default1', 'default1', 0.0), (0, 'default1', NULL, 'default1', 1.0), (2, 'Russia', 'Russia', 'default1', 0.0), (3, 'default2', 'default2', NULL, NULL), (4, NULL, NULL, 'default2', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "people" WHERE ("nationality" <> 'Russia') ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM people WHERE Nationality <> 'Russia';

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/