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
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (10, '2021-06-15', 'Grand Hall', 150);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (2, '2021-06-15', 'Zimmer Auditorium', 500);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (5, '2020-01-10', 'Grand Hall', 300);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (8, '2022-03-20', 'Civic Center', 200);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (12, '2022-03-20', 'Civic Center', 450);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (2, 1, 2, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (2, 3, 2, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (5, 2, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, venue FROM debate ORDER BY date, debate.debate_id NULLS LAST;

/*
Gold Result:
('2020-01-10', 'Grand Hall')
('2021-06-15', 'Zimmer Auditorium')
('2021-06-15', 'Grand Hall')
('2022-03-20', 'Civic Center')
('2022-03-20', 'Civic Center')
*/

-- Prediction Query
SELECT Date, Venue FROM debate;

/*
Prediction Result:
('2021-06-15', 'Zimmer Auditorium')
('2020-01-10', 'Grand Hall')
('2022-03-20', 'Civic Center')
('2021-06-15', 'Grand Hall')
('2022-03-20', 'Civic Center')
*/