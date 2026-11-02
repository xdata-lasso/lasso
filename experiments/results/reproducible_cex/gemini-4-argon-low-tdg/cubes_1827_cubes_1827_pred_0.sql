-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (1, 'District A', 'John Doe', 'Party X', 45);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (2, 'District B', 'Jane Smith', 'Party Y', 38);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (1, '2023-05-01', 'City Hall', 150);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (2, '2023-01-10', 'Arena', 500);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (3, '2023-03-15', 'Ballroom', 50);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (4, '2023-02-20', 'City Hall', 300);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (1, 1, 2, 1);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (1, 2, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT venue FROM debate ORDER BY venue, debate.debate_id NULLS LAST;

/*
Gold Result:
('Arena',)
('Ballroom',)
('City Hall',)
('City Hall',)
*/

-- Prediction Query
SELECT Venue FROM debate ORDER BY Num_of_Audience ASC, debate.debate_id NULLS LAST;

/*
Prediction Result:
('Ballroom',)
('City Hall',)
('City Hall',)
('Arena',)
*/