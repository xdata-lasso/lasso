-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests queries that erroneously join with debate_people (e.g., INNER JOIN) when the target person has no debate records.
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (10, 'District 1', 'Grace', 'Libertarian', 30);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (20, 'District 2', 'Heidi', 'SwigParty', 55);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (100, '2023-01-01', 'Main Hall', 500);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (100, 10, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM people ORDER BY party DESC, people.people_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('SwigParty',)
*/

-- Prediction Query
SELECT Party FROM people ORDER BY Age ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Libertarian',)
*/