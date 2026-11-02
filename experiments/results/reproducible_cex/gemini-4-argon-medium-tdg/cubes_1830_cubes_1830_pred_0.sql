-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests case sensitivity and lexicographical ordering of strings (e.g., lowercase vs uppercase in ASCII,
-- where 'a' > 'Z' in standard BINARY collation) and single-row vs multi-row edge cases.
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (1, 'Central', 'Karen', 'Zeta', 35);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (2, 'Central', 'Leo', 'alpha', 40);
INSERT INTO "people" ("People_ID", "District", "Name", "Party", "Age") VALUES (3, 'Central', 'Mona', 'Beta', 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM people ORDER BY party DESC, people.people_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('alpha',)
*/

-- Prediction Query
SELECT Party FROM people ORDER BY Age ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta',)
*/