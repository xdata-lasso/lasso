-- Schema DDL
CREATE TABLE "COLLEGE" (
    "COLLEGE_ID" INT,
    "NAME" TEXT,
    "LEADER_NAME" TEXT,
    "COLLEGE_LOCATION" TEXT,
    PRIMARY KEY ("COLLEGE_ID")
);
CREATE TABLE "MEMBER" (
    "MEMBER_ID" INT,
    "COLLEGE_ID" INT,
    "NAME" TEXT,
    "COUNTRY" TEXT,
    PRIMARY KEY ("MEMBER_ID"),
    FOREIGN KEY ("COLLEGE_ID") REFERENCES "COLLEGE"("COLLEGE_ID")
);
CREATE TABLE "ROUND" (
    "ROUND_ID" INT,
    "MEMBER_ID" INT,
    "DECORATION_THEME" TEXT,
    "RANK_IN_ROUND" INT,
    PRIMARY KEY ("ROUND_ID", "MEMBER_ID"),
    FOREIGN KEY ("MEMBER_ID") REFERENCES "MEMBER"("MEMBER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COLLEGE VALUES (0, 0, 0, 0);
INSERT INTO COLLEGE VALUES (1, 0, 0, 0);
INSERT INTO MEMBER VALUES (1, 1, 14, 0);
INSERT INTO MEMBER VALUES (2, 0, 12, -1);
INSERT INTO ROUND VALUES (-1, 2, 0, 0);
INSERT INTO ROUND VALUES (0, 1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM (SELECT country, member_id, MAX(n) AS n FROM (SELECT country, member_id, COUNT(*) AS n FROM (SELECT member_id, name, country, member_id AS college_id, member_id_other, country_other FROM (SELECT LHS.member_id AS member_id, LHS.name AS name, LHS.country AS country, LHS.college_id AS college_id, RHS.member_id AS member_id_other, RHS.country AS country_other FROM member AS LHS INNER JOIN member AS RHS ON (LHS.member_id = RHS.college_id AND LHS.name = RHS.name))) GROUP BY country, member_id) GROUP BY country, member_id) ORDER BY country;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Country FROM member GROUP BY Country ORDER BY COUNT(*) DESC, Country NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/