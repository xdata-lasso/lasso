-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests age boundaries (34, 35, 36, 37) and NULL age values.
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'District 1', 'Charlie', 'Democratic', 34);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'District 2', 'Alice', 'Republican', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (3, 'District 3', 'Bob', 'Independent', 36);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (4, 'District 4', 'David', 'Democratic', 37);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (5, 'District 5', 'Eve', 'Republican', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (age < 35 OR age <= 36) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM people WHERE Age = 35 OR Age = 36;

/*
Prediction Result:
('Alice',)
('Bob',)
*/