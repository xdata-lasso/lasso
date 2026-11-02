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
INSERT INTO ITEM VALUES (-1, 0);
INSERT INTO ITEM VALUES (0, 0);
INSERT INTO REVIEW VALUES (-1, 0, -1, -2, 0);
INSERT INTO REVIEW VALUES (0, -1, 0, NULL, -1);
INSERT INTO USERACCT VALUES (-1, -1);
INSERT INTO USERACCT VALUES (0, 0);
INSERT INTO TRUST VALUES (0, -1, 0);
INSERT INTO TRUST VALUES (0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT a_id, u_id, a_id AS i_id, rating, rank, name, a_id_other, rating_other, rank_other FROM (SELECT LHS.a_id AS a_id, LHS.u_id AS u_id, LHS.i_id AS i_id, LHS.rating AS rating, LHS.rank AS rank, LHS.name AS name, RHS.a_id AS a_id_other, RHS.rating AS rating_other, RHS.rank AS rank_other FROM (SELECT a_id, a_id AS u_id, i_id, rating, rank, name FROM (SELECT LHS.a_id AS a_id, LHS.u_id AS u_id, LHS.i_id AS i_id, LHS.rating AS rating, LHS.rank AS rank, RHS.name AS name FROM review AS LHS INNER JOIN useracct AS RHS ON (LHS.a_id = RHS.u_id))) AS LHS INNER JOIN review AS RHS ON (LHS.a_id = RHS.i_id AND LHS.rank = RHS.u_id))) ORDER BY name;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT T1.name FROM useracct AS T1 JOIN review AS T2 ON T1.u_id = T2.u_id ORDER BY T2.rating DESC, T1.u_id NULLS LAST, T2.a_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/