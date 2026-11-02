-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (212, 'NY');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (310, 'CA');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (512, 'TX');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (305, 'FL');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Alice');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'Bob');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (3, 'Charlie');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (4, 'Diana');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (1, 2, 'TX', 5121111, '2023-05-01 08:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (2, 2, 'CA', 3102222, '2023-05-02 12:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (3, 3, 'CA', 3101111, '2023-05-03 12:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (4, 1, 'CA', 3103333, '2023-05-01 09:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (5, 2, 'CA', 3104444, '2023-05-01 09:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (6, 1, 'NY', 2121111, '2023-05-01 07:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT state, created FROM votes ORDER BY state, votes.vote_id NULLS LAST;

/*
Gold Result:
('CA', '2023-05-02 12:00:00')
('CA', '2023-05-03 12:00:00')
('CA', '2023-05-01 09:00:00')
('CA', '2023-05-01 09:00:00')
('NY', '2023-05-01 07:00:00')
('TX', '2023-05-01 08:00:00')
*/

-- Prediction Query
SELECT DISTINCT state, created FROM votes;

/*
Prediction Result:
('TX', '2023-05-01 08:00:00')
('CA', '2023-05-02 12:00:00')
('CA', '2023-05-03 12:00:00')
('CA', '2023-05-01 09:00:00')
('NY', '2023-05-01 07:00:00')
*/