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
INSERT INTO people (People_ID, District, Name, Party, Age) VALUES (4, 'District 4', 'David Brown', 'Democratic', 61);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (10, '2023-09-01', 'Grand Theater', 450);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (2, '2023-04-01', 'Zeta Arena', 200);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (30, '2023-01-01', 'Main Hall', 800);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (4, '2023-06-01', 'Alpha Center', 300);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (50, '2023-02-01', 'Main Hall', 100);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (10, 1, 2, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (10, 3, 4, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (2, 2, 3, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (30, 1, 4, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (50, 4, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT venue FROM debate ORDER BY venue, debate.debate_id NULLS LAST;

/*
Gold Result:
('Alpha Center',)
('Grand Theater',)
('Main Hall',)
('Main Hall',)
('Zeta Arena',)
*/

-- Prediction Query
SELECT Venue FROM debate ORDER BY Num_of_Audience ASC, debate.debate_id NULLS LAST;

/*
Prediction Result:
('Main Hall',)
('Zeta Arena',)
('Alpha Center',)
('Grand Theater',)
('Main Hall',)
*/