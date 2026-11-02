-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: representative --
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1, 'lhs_b77252', 'lhs_fb284c', 'lhs_ccc0d7', 'lhs_f3c7ed');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (-2147483648, 'lhs_ebd7f7', 'lhs_ceb039', 'lhs_fc0160', 'lhs_d30bc9');

-- Inserting into table: election --
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (-2147483648, 1, '5k5swwqcgs', 171.746906, 557.512061, 868.436572, 537.136345);

INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (-2147483647, 1, '4', 249.706432, 99.523333, 314.813297, 328.996339);

INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (-2147483646, 1, '4h', 268.82475, 710.998147, 945.642658, 795.366812);

INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (-2147483645, 1, 'puzhsrw', 944.247544, 994.117864, 749.826493, 503.083789);

INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (-2147483644, 1, 'hvdltt', 125.12763, 22.535764, 600.048938, 240.969194);

INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (-2147483643, 1, 'mdpos', 133.007885, 75.403642, 327.753528, 218.301157);

INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (-2147483642, 1, 'klfa9000t', 827.854302, 983.124993, 828.555322, 38.208914);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
('lhs_b77252',)
*/

-- Prediction Query
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY votes DESC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST;

/*
Prediction Result:
('lhs_b77252',)
('lhs_b77252',)
('lhs_b77252',)
('lhs_b77252',)
('lhs_b77252',)
('lhs_b77252',)
('lhs_b77252',)
*/