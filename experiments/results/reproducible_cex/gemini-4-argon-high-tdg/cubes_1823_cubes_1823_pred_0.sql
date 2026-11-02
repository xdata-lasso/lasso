-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (5, 'District 1', 'Vera', 'Democratic', 40);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (10, 'District 2', 'Zara', 'Republican', 34);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (20, 'District 3', 'Yuki', 'Democratic', 35);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (30, 'District 4', 'Xena', 'Independent', 36);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (40, 'District 5', 'Will', 'Republican', 37);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (50, 'District 6', 'Uma', 'Democratic', 25);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (60, 'District 7', 'Tara', 'Independent', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (age < 35 OR age <= 36) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('Uma',)
('Xena',)
('Yuki',)
('Zara',)
*/

-- Prediction Query
SELECT Name FROM people WHERE Age = 35 OR Age = 36;

/*
Prediction Result:
('Yuki',)
('Xena',)
*/