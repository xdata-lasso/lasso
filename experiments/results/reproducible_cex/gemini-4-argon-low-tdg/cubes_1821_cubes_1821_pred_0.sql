-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (1, 'District 1', 'Alice', 'Party A', 35);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (2, 'District 2', 'Bob', 'Party B', 42);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (1, '2023-05-01', 'Zeta Center', 500);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (2, '2023-01-15', 'Alpha Hall', 100);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (3, '2023-03-10', 'Alpha Hall', 200);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (4, '2023-02-20', 'Beta Arena', 300);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (1, 1, 2, 1);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (2, 1, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT venue FROM debate ORDER BY venue;

/*
Gold Result:
('Alpha Hall',)
('Beta Arena',)
('Zeta Center',)
*/

-- Prediction Query
SELECT DISTINCT Venue FROM debate;

/*
Prediction Result:
('Zeta Center',)
('Alpha Hall',)
('Beta Arena',)
*/