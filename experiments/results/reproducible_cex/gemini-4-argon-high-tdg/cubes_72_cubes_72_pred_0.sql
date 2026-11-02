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
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Zack Morris');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'Kelly Kapowski');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (3, 'Jessie Alloway');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (4, 'Alice Smith');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (5, 'Bob Jones');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (6, 'Alice Smith');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (101, 1, 'NY', 2125550101, '2023-01-01 10:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (102, 1, 'CA', 3105550102, '2023-01-01 10:05:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (103, 3, 'IL', 3125550103, '2023-01-01 10:10:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (104, 4, 'NY', 2125550104, '2023-01-01 10:15:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "contestant_name" FROM "contestants" WHERE ("contestant_name" <> 'Jessie Alloway') ORDER BY contestant_name, contestants.contestant_number NULLS LAST;

/*
Gold Result:
('Alice Smith',)
('Alice Smith',)
('Bob Jones',)
('Kelly Kapowski',)
('Zack Morris',)
*/

-- Prediction Query
SELECT contestant_name FROM contestants WHERE contestant_name <> 'Jessie Alloway';

/*
Prediction Result:
('Zack Morris',)
('Kelly Kapowski',)
('Alice Smith',)
('Bob Jones',)
('Alice Smith',)
*/