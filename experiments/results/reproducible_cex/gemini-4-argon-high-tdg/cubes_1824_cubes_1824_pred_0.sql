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
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (1, '2020-05-10', 'Hall A', 150);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (2, '2018-03-15', 'Hall B', 200);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (3, '2019-11-20', 'Hall C', 149);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (4, '2018-03-15', 'Hall D', 151);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (5, '2017-01-01', 'Hall E', 100);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (6, '2021-08-30', 'Hall F', NULL);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (2, 1, 2, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (2, 2, 3, 0);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (4, 1, 3, 1);
INSERT INTO debate_people (Debate_ID, Affirmative, Negative, If_Affirmative_Win) VALUES (5, 3, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM debate WHERE (num_of_audience >= 150) ORDER BY date, debate.debate_id NULLS LAST;

/*
Gold Result:
('2018-03-15',)
('2018-03-15',)
('2020-05-10',)
*/

-- Prediction Query
SELECT Date FROM debate WHERE Num_of_Audience > 150;

/*
Prediction Result:
('2018-03-15',)
('2018-03-15',)
*/