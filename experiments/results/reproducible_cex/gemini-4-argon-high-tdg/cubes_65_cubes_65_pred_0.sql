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
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Tabatha Gehling');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'John Smith');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (3, 'Tabatha');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (4, 'tabatha gehling');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (101, 1, 'NY', 2125550103, '2023-05-03 14:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (102, 1, 'CA', 3105550101, '2023-05-01 09:30:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (103, 1, 'IL', 3125550102, '2023-05-02 18:15:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (104, 2, 'NY', 2125550199, '2023-05-01 08:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (105, 3, 'CA', 3105550198, '2023-05-01 07:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (106, 4, 'IL', 3125550197, '2023-05-01 06:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "created", "state", "phone_number" FROM (SELECT "LHS"."contestant_number" AS "contestant_number", "LHS"."contestant_name" AS "contestant_name", "RHS"."vote_id" AS "vote_id", "RHS"."phone_number" AS "phone_number", "RHS"."state" AS "state", "RHS"."created" AS "created" FROM (SELECT * FROM "contestants" WHERE ("contestant_name" = 'Tabatha Gehling')) AS LHS INNER JOIN votes AS RHS ON (LHS.contestant_number = RHS.contestant_number)) ORDER BY created, "created" NULLS LAST, "state" NULLS LAST, "phone_number" NULLS LAST;

/*
Gold Result:
('2023-05-01 09:30:00', 'CA', 3105550101)
('2023-05-02 18:15:00', 'IL', 3125550102)
('2023-05-03 14:00:00', 'NY', 2125550103)
*/

-- Prediction Query
SELECT T2.created, T2.state, T2.phone_number FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number = T2.contestant_number WHERE T1.contestant_name = 'Tabatha Gehling';

/*
Prediction Result:
('2023-05-03 14:00:00', 'NY', 2125550103)
('2023-05-01 09:30:00', 'CA', 3105550101)
('2023-05-02 18:15:00', 'IL', 3125550102)
*/