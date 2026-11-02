-- Schema DDL
CREATE TABLE "REGION" (
    "REGION_ID" INT,
    "REGION_NAME" TEXT,
    "DATE" TEXT,
    "LABEL" TEXT,
    "FORMAT" TEXT,
    "CATALOGUE" TEXT,
    PRIMARY KEY ("REGION_ID")
);
CREATE TABLE "PARTY" (
    "PARTY_ID" INT,
    "REGION_ID" INT,
    "MINISTER" TEXT,
    "TOOK_OFFICE" TEXT,
    "LEFT_OFFICE" TEXT,
    "PARTY_NAME" TEXT,
    PRIMARY KEY ("PARTY_ID"),
    FOREIGN KEY ("REGION_ID") REFERENCES "REGION"("REGION_ID")
);
CREATE TABLE "MEMBER" (
    "MEMBER_ID" INT,
    "PARTY_ID" TEXT,
    "MEMBER_NAME" TEXT,
    "IN_OFFICE" TEXT,
    PRIMARY KEY ("MEMBER_ID"),
    FOREIGN KEY ("PARTY_ID") REFERENCES "PARTY"("PARTY_ID")
);
CREATE TABLE "PARTY_EVENTS" (
    "EVENT_ID" INT,
    "MEMBER_IN_CHARGE_ID" INT,
    "PARTY_ID" INT,
    "EVENT_NAME" TEXT,
    PRIMARY KEY ("EVENT_ID"),
    FOREIGN KEY ("MEMBER_IN_CHARGE_ID") REFERENCES "MEMBER"("MEMBER_ID"),
    FOREIGN KEY ("PARTY_ID") REFERENCES "PARTY"("PARTY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO REGION VALUES (2, 0, 0, 0, 0, 0);
INSERT INTO REGION VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO PARTY VALUES (0, 2, 29, 30, 31, 32);
INSERT INTO PARTY VALUES (1, 0, 34, 35, 36, 1);
INSERT INTO MEMBER VALUES (0, 1, 0, 0);
INSERT INTO MEMBER VALUES (1, 1, 0, 0);
INSERT INTO PARTY_EVENTS VALUES (1, 1, 1, 28);
INSERT INTO PARTY_EVENTS VALUES (0, 0, 0, 33);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name, n AS count___ FROM (SELECT party_name, region_id, COUNT(*) AS n FROM (SELECT event_id, event_name, party_id, member_in_charge_id, party_id_other, minister, took_office, left_office, party_name, party_id AS region_id FROM (SELECT LHS.event_id AS event_id, LHS.event_name AS event_name, LHS.party_id AS party_id, LHS.member_in_charge_id AS member_in_charge_id, RHS.party_id AS party_id_other, RHS.minister AS minister, RHS.took_office AS took_office, RHS.left_office AS left_office, RHS.party_name AS party_name FROM party_events AS LHS INNER JOIN party AS RHS ON (LHS.party_id = RHS.region_id))) GROUP BY party_name, region_id) ORDER BY party_name, count___ NULLS LAST;

/*
Gold Result:
('1', 1)
*/

-- Prediction Query
SELECT T2.party_name, COUNT(*) FROM party_events AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id;

/*
Prediction Result:
('32', 1)
('1', 1)
*/