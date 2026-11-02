-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (212, 'NY');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (310, 'CA');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (312, 'IL');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Alice');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'Bob');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (10, 1, 'NY', 5550101, '2023-01-02 10:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (5, 1, 'NY', 5550102, '2023-01-03 10:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (20, 2, 'CA', 5550103, '2023-01-01 08:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (15, 2, 'CA', 5550103, '2023-01-01 08:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state, created FROM votes ORDER BY state, votes.vote_id NULLS LAST;

/*
Gold Result:
('CA', '2023-01-01 08:00:00')
('CA', '2023-01-01 08:00:00')
('NY', '2023-01-03 10:00:00')
('NY', '2023-01-02 10:00:00')
*/

-- Prediction Query
SELECT DISTINCT state, created FROM votes;

/*
Prediction Result:
('NY', '2023-01-03 10:00:00')
('NY', '2023-01-02 10:00:00')
('CA', '2023-01-01 08:00:00')
*/