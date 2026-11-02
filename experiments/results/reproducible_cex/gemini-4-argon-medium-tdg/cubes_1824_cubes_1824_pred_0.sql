-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (1, 'District 1', 'Alice', 'Party A', 40);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (2, 'District 2', 'Bob', 'Party B', 45);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (3, 'District 3', 'Charlie', 'Party A', 50);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (1, '2023-05-01', 'Hall A', 149);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (2, '2023-05-02', 'Hall B', 150);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (3, '2023-05-03', 'Hall C', 151);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (4, '2023-01-01', 'Hall D', 200);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (5, '2023-05-02', 'Hall E', 300);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (1, 1, 2, 1);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (2, 1, 2, 0);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (2, 2, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM debate WHERE (num_of_audience >= 150) ORDER BY date, debate.debate_id NULLS LAST;

/*
Gold Result:
('2023-01-01',)
('2023-05-02',)
('2023-05-02',)
('2023-05-03',)
*/

-- Prediction Query
SELECT Date FROM debate WHERE Num_of_Audience > 150;

/*
Prediction Result:
('2023-05-03',)
('2023-01-01',)
('2023-05-02',)
*/