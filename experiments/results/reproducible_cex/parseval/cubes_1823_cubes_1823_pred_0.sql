-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (1, '5k5swwqcgs', 'peo_a44a5a', '9n8', 0);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (3, '4', 'peo_a44a5a', 'gu7v', 0);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (2, '5k5swwqcgs', '9n8', '4', 35);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (4, 'gu7v', 'e4', 'hria2ypuzhs', 37);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (5, 'rwbbp6luhvd', 'tti', 'bnp', NULL);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (6, 'mdpos', 'ie5', 'nw6klf', NULL);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (7, 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', NULL);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (8, 'qyp5s5bbp0', '2eutliqa11r', 'ytoo3o9', NULL);

INSERT INTO "people" ("people_id", "district", "name", "party", "age") VALUES (9, 'l7', 'klex14ji', '7zwau2dwyr', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people WHERE (age < 35 OR age <= 36) ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('9n8',)
('peo_a44a5a',)
('peo_a44a5a',)
*/

-- Prediction Query
SELECT Name FROM people WHERE Age = 35 OR Age = 36;

/*
Prediction Result:
('9n8',)
*/