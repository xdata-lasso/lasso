-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (1, 'District 1', 'Alice Smith', 'Democratic', 45);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (2, 'District 2', 'Bob Jones', 'Republican', 52);
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (3, 'District 3', 'Carol White', 'Independent', 38);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (1, '2021-04-10', 'Grand Hall', 150);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (2, '2021-02-15', 'Arena Alpha', 400);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (3, '2021-01-20', 'Main Theater', 250);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (4, '2021-03-05', 'Civic Center', 100);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (5, '2021-05-12', 'Grand Hall', 300);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (1, 1, 2, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (2, 2, 3, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (5, 1, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT venue FROM debate ORDER BY venue;

/*
Gold Result:
('Arena Alpha',)
('Civic Center',)
('Grand Hall',)
('Main Theater',)
*/

-- Prediction Query
SELECT DISTINCT Venue FROM debate;

/*
Prediction Result:
('Grand Hall',)
('Arena Alpha',)
('Main Theater',)
('Civic Center',)
*/