-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1001, 'purpose', 'Daniel Doyle', 'rate', 1005);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1002, 'brother', 'Stephanie Miller', 'science', 1016.0);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1003, 'ago', 'Allen Robinson', 'offer', 1027.0);
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1004, 'site', 'Alyssa Gonzalez', 'kind', 1038.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party FROM (SELECT * FROM (SELECT * FROM people ORDER BY party DESC, people.people_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('science',)
*/

-- Prediction Query
SELECT Party FROM people ORDER BY Age ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('rate',)
*/