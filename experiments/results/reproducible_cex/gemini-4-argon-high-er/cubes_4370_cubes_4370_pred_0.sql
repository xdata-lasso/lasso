-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'D1', 'Alice', 'Dem', 20);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'D2', 'Bob', 'Rep', 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT LHS.age AS age, RHS.people_id AS people_id, RHS.district AS district, RHS.name AS name, RHS.party AS party, RHS.age AS age_other FROM (SELECT MIN(age) AS age FROM people) AS LHS CROSS JOIN people AS RHS) WHERE (age = age_other) ORDER BY party;

/*
Gold Result:
('Dem',)
('Rep',)
*/

-- Prediction Query
SELECT Party FROM people ORDER BY Age ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Dem',)
*/