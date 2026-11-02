-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "area_code_state" ("area_code", "state") VALUES (1005, 'Florida');
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (1006, 'Megan Mcclain');
INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1007, 1006, 'Florida', 1008, '1971-02-02');
INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1009, 1006, 'Florida', 1008, '1971-02-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state, created FROM votes ORDER BY state, votes.vote_id NULLS LAST;

/*
Gold Result:
('Florida', '1971-02-02')
('Florida', '1971-02-02')
*/

-- Prediction Query
SELECT DISTINCT state, created FROM votes;

/*
Prediction Result:
('Florida', '1971-02-02')
*/