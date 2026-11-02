-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (13, NULL, '26', NULL, NULL);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (12, NULL, '26', '24', 25);
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (15, '13', '13', 13);
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (14, '13', '13', 13);
INSERT INTO "debate_people" ("debate_id", "affirmative", "negative", "if_affirmative_win") VALUES (15, 13, 13, NULL);
INSERT INTO "debate_people" ("debate_id", "affirmative", "negative", "if_affirmative_win") VALUES (14, 12, 13, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.people_id AS people_id, LHS.district AS district, LHS.name AS name, LHS.party AS party, LHS.age AS age, RHS.n AS n FROM people AS LHS INNER JOIN (SELECT affirmative, COUNT(*) AS n FROM debate_people GROUP BY affirmative) AS RHS ON (LHS.people_id = RHS.affirmative)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('26', 1)
('26', 1)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM debate_people AS T1 JOIN people AS T2 ON T1.Affirmative = T2.People_ID GROUP BY T2.Name;

/*
Prediction Result:
('26', 2)
*/