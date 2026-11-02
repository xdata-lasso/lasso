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
INSERT INTO CANDIDATE VALUES (1, 1, 0, 16, 17, 9, -1, 9);
INSERT INTO CANDIDATE VALUES (0, 0, -1, 18, 19, 10, 0, 10);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT poll_source FROM (SELECT candidate_id, people_id, poll_source, date, support_rate, unsure_rate AS consider_rate, oppose_rate, unsure_rate, candidate_id_other, poll_source_other, date_other, support_rate_other, oppose_rate_other, unsure_rate_other FROM (SELECT candidate_id, candidate_id AS people_id, poll_source, date, support_rate, consider_rate, oppose_rate, unsure_rate, candidate_id_other, poll_source_other, date_other, support_rate_other, oppose_rate_other, unsure_rate_other FROM (SELECT LHS.candidate_id AS candidate_id, LHS.people_id AS people_id, LHS.poll_source AS poll_source, LHS.date AS date, LHS.support_rate AS support_rate, LHS.consider_rate AS consider_rate, LHS.oppose_rate AS oppose_rate, LHS.unsure_rate AS unsure_rate, RHS.candidate_id AS candidate_id_other, RHS.poll_source AS poll_source_other, RHS.date AS date_other, RHS.support_rate AS support_rate_other, RHS.oppose_rate AS oppose_rate_other, RHS.unsure_rate AS unsure_rate_other FROM candidate AS LHS INNER JOIN candidate AS RHS ON (LHS.candidate_id = RHS.people_id AND LHS.unsure_rate = RHS.consider_rate)))) ORDER BY poll_source;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT poll_source FROM candidate ORDER BY oppose_rate DESC, candidate.candidate_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/