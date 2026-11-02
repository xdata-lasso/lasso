-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO debate (debate_id, date, venue, num_of_audience) VALUES (0, 'default1', NULL, 1), (1, 'default2', NULL, 0), (2, 'default2', 'default2', 1), (3, NULL, 'default2', NULL);
INSERT INTO people (people_id, district, name, party, age) VALUES (0, NULL, 'default2', 'default1', NULL), (1, 'default2', 'default2', NULL, 1), (2, 'default1', NULL, 'default2', 0), (3, 'default2', 'default1', 'default1', NULL), (4, 'default2', 'default2', 'default2', 0), (5, NULL, NULL, 'default2', 1), (6, 'default1', 'default2', NULL, 1), (7, 'default1', NULL, 'default2', 1), (8, 'default2', 'default1', 'default1', NULL), (9, 'default1', NULL, 'default1', 0);
INSERT INTO debate_people (debate_id, affirmative, negative, if_affirmative_win) VALUES (1, 2, 5, 0), (2, 3, 1, NULL), (1, 5, 7, 1), (1, 5, 5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.people_id AS people_id, LHS.district AS district, LHS.name AS name, LHS.party AS party, LHS.age AS age, RHS.n AS n FROM people AS LHS INNER JOIN (SELECT affirmative, COUNT(*) AS n FROM debate_people GROUP BY affirmative) AS RHS ON (LHS.people_id = RHS.affirmative)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 2)
('default1', 1)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM debate_people AS T1 JOIN people AS T2 ON T1.Affirmative = T2.People_ID GROUP BY T2.Name;

/*
Prediction Result:
(None, 3)
('default1', 1)
*/