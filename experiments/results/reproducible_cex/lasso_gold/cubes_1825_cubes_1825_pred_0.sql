-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1006, 'science', 'Donald Booth', 'guy', 1010);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1007, 'offer', 'Caitlin Henderson', 'guy', 1010);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1008, 'kind', 'Daniel Gallagher', 'guy', 1010);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1009, 'discussion', 'James Howard', 'guy', 1010);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1011, NULL, 'Kimberly Dudley', 'figure', 1015);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1012, NULL, 'Juan Calderon', 'figure', 1015);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1013, NULL, 'Shannon Ray', 'figure', 1015);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1014, NULL, 'Amber Perez', 'figure', 1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM (SELECT age, party, COUNT(*) AS n FROM people GROUP BY age, party) ORDER BY n) LIMIT 1);

/*
Gold Result:
('guy',)
*/

-- Prediction Query
SELECT Party FROM people GROUP BY Party ORDER BY COUNT(*) DESC, Party NULLS LAST LIMIT 1;

/*
Prediction Result:
('figure',)
*/