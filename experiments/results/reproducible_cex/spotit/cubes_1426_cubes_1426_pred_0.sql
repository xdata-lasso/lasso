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
INSERT INTO REGION VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO REGION VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO PARTY VALUES (0, 0, 35, 36, 37, 0);
INSERT INTO PARTY VALUES (1, 0, 39, NULL, 41, 0);
INSERT INTO MEMBER VALUES (0, 1, 0, 0);
INSERT INTO MEMBER VALUES (-1, 0, 0, 0);
INSERT INTO PARTY_EVENTS VALUES (0, -1, 0, 34);
INSERT INTO PARTY_EVENTS VALUES (1, -1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT party_name FROM (SELECT party_name, region_id, COUNT(*) AS n FROM (SELECT LHS.party_id AS party_id, LHS.minister AS minister, LHS.took_office AS took_office, LHS.left_office AS left_office, LHS.region_id AS region_id, LHS.party_name AS party_name, RHS.event_id AS event_id, RHS.event_name AS event_name, RHS.member_in_charge_id AS member_in_charge_id FROM party AS LHS LEFT JOIN party_events AS RHS ON (LHS.party_id = RHS.party_id)) GROUP BY party_name, region_id) WHERE (n >= 2) ORDER BY party_name;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT T2.party_name FROM party_events AS T1 JOIN party AS T2 ON T1.party_id = T2.party_id GROUP BY T1.party_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/