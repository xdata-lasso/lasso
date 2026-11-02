-- Schema DDL
CREATE TABLE "CANDIDATE" (
    "CANDIDATE_ID" INT,
    "PEOPLE_ID" INT,
    "POLL_SOURCE" TEXT,
    "DATE" TEXT,
    "SUPPORT_RATE" FLOAT,
    "CONSIDER_RATE" FLOAT,
    "OPPOSE_RATE" FLOAT,
    "UNSURE_RATE" FLOAT,
    PRIMARY KEY ("CANDIDATE_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "SEX" TEXT,
    "NAME" TEXT,
    "DATE_OF_BIRTH" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CANDIDATE VALUES (0, -1, 72, 73, NULL, 74, 75, 76);
INSERT INTO CANDIDATE VALUES (1, 0, 82, 83, NULL, 84, 85, 86);
INSERT INTO PEOPLE VALUES (-1, 67, 68, 69, 70, 71);
INSERT INTO PEOPLE VALUES (0, 77, 78, 79, 80, 81);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, sex FROM (SELECT LHS.candidate_id AS candidate_id, LHS.people_id AS people_id, LHS.poll_source AS poll_source, LHS.date AS date, LHS.support_rate AS support_rate, LHS.consider_rate AS consider_rate, LHS.oppose_rate AS oppose_rate, LHS.unsure_rate AS unsure_rate, LHS.sex AS sex, LHS.name AS name, LHS.date_of_birth AS date_of_birth, LHS.height AS height, LHS.weight AS weight FROM (SELECT LHS.candidate_id AS candidate_id, LHS.people_id AS people_id, LHS.poll_source AS poll_source, LHS.date AS date, LHS.support_rate AS support_rate, LHS.consider_rate AS consider_rate, LHS.oppose_rate AS oppose_rate, LHS.unsure_rate AS unsure_rate, RHS.sex AS sex, RHS.name AS name, RHS.date_of_birth AS date_of_birth, RHS.height AS height, RHS.weight AS weight FROM candidate AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) AS LHS INNER JOIN (SELECT MAX(support_rate) AS support_rate FROM candidate) AS RHS ON (LHS.support_rate = RHS.support_rate)) ORDER BY name, sex NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT t1.name, t1.sex FROM people AS t1 JOIN candidate AS t2 ON t1.people_id = t2.people_id ORDER BY t2.support_rate DESC, t1.people_id NULLS LAST, t2.candidate_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('68', '67')
*/