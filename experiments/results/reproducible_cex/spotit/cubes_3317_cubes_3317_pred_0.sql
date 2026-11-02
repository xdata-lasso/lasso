-- Schema DDL
CREATE TABLE "BODY_BUILDER" (
    "BODY_BUILDER_ID" INT,
    "PEOPLE_ID" INT,
    "SNATCH" FLOAT,
    "CLEAN_JERK" FLOAT,
    "TOTAL" FLOAT,
    PRIMARY KEY ("BODY_BUILDER_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    "BIRTH_DATE" TEXT,
    "BIRTH_PLACE" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO BODY_BUILDER VALUES (0, 1, 21, 22, 14);
INSERT INTO BODY_BUILDER VALUES (1, 0, NULL, 29, 30);
INSERT INTO PEOPLE VALUES (0, 23, 24, 25, 26, 27);
INSERT INTO PEOPLE VALUES (1, 13, 31, 32, 33, 34);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___ FROM (SELECT name, total, COUNT(*) AS n FROM (SELECT * FROM (SELECT LHS.body_builder_id AS body_builder_id, LHS.people_id AS people_id, LHS.snatch AS snatch, LHS.clean_jerk AS clean_jerk, LHS.total AS total, RHS.people_id AS people_id_other, RHS.name AS name, RHS.height AS height, RHS.weight AS weight, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM body_builder AS LHS CROSS JOIN people AS RHS) WHERE (people_id = people_id_other)) GROUP BY name, total) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM people WHERE NOT people_id IN (SELECT People_ID FROM body_builder);

/*
Prediction Result:
(0,)
*/