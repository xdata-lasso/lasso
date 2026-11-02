-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic Venue sorting (out of order insertion), duplicates (kills DISTINCT/GROUP BY), and empty child tables (kills INNER JOIN with debate_people).
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (3, '2023-05-01', 'Zeta Hall', 200);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (1, '2023-01-01', 'Alpha Center', 500);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (2, '2023-03-01', 'Beta Arena', 100);
INSERT INTO debate (Debate_ID, Date, Venue, Num_of_Audience) VALUES (4, '2023-02-01', 'Alpha Center', 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT venue FROM debate ORDER BY venue, debate.debate_id NULLS LAST;

/*
Gold Result:
('Alpha Center',)
('Alpha Center',)
('Beta Arena',)
('Zeta Hall',)
*/

-- Prediction Query
SELECT Venue FROM debate ORDER BY Num_of_Audience ASC, debate.debate_id NULLS LAST;

/*
Prediction Result:
('Beta Arena',)
('Zeta Hall',)
('Alpha Center',)
('Alpha Center',)
*/