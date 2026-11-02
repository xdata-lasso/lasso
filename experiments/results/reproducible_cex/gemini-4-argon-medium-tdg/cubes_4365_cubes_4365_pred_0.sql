-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (1, 'District 1', 'Alice', 'Dem', 45);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (2, 'District 1', 'Bob', 'Dem', 50);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (3, 'District 1', 'Charlie', 'Dem', 35);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (4, 'District 1', 'David', 'Rep', 60);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (5, 'District 1', 'Eve', 'Rep', 40);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (6, 'District 2', 'Frank', 'Rep', 55);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (7, 'District 2', 'Grace', 'Rep', 30);
INSERT INTO "debate" ("Debate_ID", "Date", "Venue", "Num_of_Audience") VALUES (1, '2023-01-01', 'Hall A', 100);
INSERT INTO "debate_people" ("Debate_ID", "Affirmative", "Negative", "If_Affirmative_Win") VALUES (1, 4, 6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT district, party, MAX(n) AS maxn FROM (SELECT district, party, COUNT(*) AS n FROM people GROUP BY district, party) GROUP BY district, party) ORDER BY maxn DESC) LIMIT 1);

/*
Gold Result:
('Dem',)
*/

-- Prediction Query
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC, Party NULLS LAST LIMIT 1;

/*
Prediction Result:
('Rep',)
*/