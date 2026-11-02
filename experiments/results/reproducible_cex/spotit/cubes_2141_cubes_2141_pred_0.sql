-- Schema DDL
CREATE TABLE "ITEM" (
    "I_ID" INT,
    "TITLE" TEXT,
    PRIMARY KEY ("I_ID")
);
CREATE TABLE "REVIEW" (
    "A_ID" INT,
    "I_ID" INT,
    "U_ID" INT,
    "RATING" INT,
    "RANK" INT,
    PRIMARY KEY ("A_ID"),
    FOREIGN KEY ("I_ID") REFERENCES "ITEM"("I_ID"),
    FOREIGN KEY ("U_ID") REFERENCES "USERACCT"("U_ID")
);
CREATE TABLE "USERACCT" (
    "U_ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("U_ID")
);
CREATE TABLE "TRUST" (
    "TARGET_U_ID" INT,
    "SOURCE_U_ID" INT,
    "TRUST" INT,
    FOREIGN KEY ("TARGET_U_ID") REFERENCES "USERACCT"("U_ID"),
    FOREIGN KEY ("SOURCE_U_ID") REFERENCES "USERACCT"("U_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ITEM VALUES (0, 0);
INSERT INTO ITEM VALUES (-1, 0);
INSERT INTO REVIEW VALUES (-1, -1, 1, 0, 0);
INSERT INTO REVIEW VALUES (0, 0, 0, 0, 0);
INSERT INTO USERACCT VALUES (1, 37);
INSERT INTO USERACCT VALUES (0, 38);
INSERT INTO TRUST VALUES (1, 1, 3);
INSERT INTO TRUST VALUES (0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT u_id, name, source_u_id, target_u_id, u_id AS trust FROM (SELECT LHS.u_id AS u_id, LHS.name AS name, RHS.source_u_id AS source_u_id, RHS.target_u_id AS target_u_id FROM useracct AS LHS INNER JOIN trust AS RHS ON (LHS.u_id = RHS.trust))) ORDER BY source_u_id DESC) LIMIT 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.name FROM useracct AS T1 JOIN trust AS T2 ON T1.u_id = T2.target_u_id ORDER BY trust, T1.u_id NULLS LAST, T2.target_u_id NULLS LAST, T2.source_u_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('38',)
*/