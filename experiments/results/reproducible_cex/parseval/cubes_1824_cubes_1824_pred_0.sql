-- Schema DDL
CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "District" TEXT, "Name" TEXT, "Party" TEXT, "Age" INTEGER);

CREATE TABLE "debate" ("Debate_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Num_of_Audience" INTEGER);

CREATE TABLE "debate_people" ("Debate_ID" INTEGER, "Affirmative" INTEGER, "Negative" INTEGER, "If_Affirmative_Win" INTEGER, PRIMARY KEY ("Debate_ID", "Affirmative", "Negative"), FOREIGN KEY ("Negative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Affirmative") REFERENCES "people" ("People_ID"), FOREIGN KEY ("Debate_ID") REFERENCES "debate" ("Debate_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: debate --
INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (1, 'deb_ee3f9d', '5k5swwqcgs', 150);

INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (3, 'deb_ee3f9d', '9n8', 150);

INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (2, '4', 'gu7v', 149);

INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (4, 'e4', 'hria2ypuzhs', NULL);

INSERT INTO "debate" ("debate_id", "date", "venue", "num_of_audience") VALUES (5, NULL, 'rwbbp6luhvd', 150);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM debate WHERE (num_of_audience >= 150) ORDER BY date, debate.debate_id NULLS LAST;

/*
Gold Result:
(None,)
('deb_ee3f9d',)
('deb_ee3f9d',)
*/

-- Prediction Query
SELECT Date FROM debate WHERE Num_of_Audience > 150;

/*
Prediction Result:
*/