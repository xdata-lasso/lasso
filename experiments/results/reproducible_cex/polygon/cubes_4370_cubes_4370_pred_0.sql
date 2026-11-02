-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (11, '16', '17', '18', 797);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (10, '19', '20', '21', NULL);
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (13, '797', '797', 797);
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (12, '797', '797', 797);
INSERT INTO "debate_people" ("debate_id", "affirmative", "negative", "if_affirmative_win") VALUES (13, 11, 11, 1);
INSERT INTO "debate_people" ("debate_id", "affirmative", "negative", "if_affirmative_win") VALUES (13, 10, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT LHS.age AS age, RHS.people_id AS people_id, RHS.district AS district, RHS.name AS name, RHS.party AS party, RHS.age AS age_other FROM (SELECT MIN(age) AS age FROM people) AS LHS CROSS JOIN people AS RHS) WHERE (age = age_other) ORDER BY party;

/*
Gold Result:
('18',)
*/

-- Prediction Query
SELECT Party FROM people ORDER BY Age ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('21',)
*/