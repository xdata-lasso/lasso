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
INSERT INTO BODY_BUILDER VALUES (1, 1, 0, 0, 0);
INSERT INTO BODY_BUILDER VALUES (0, 2, 0, 0, 0);
INSERT INTO PEOPLE VALUES (2, 13, 15, NULL, 16, 0);
INSERT INTO PEOPLE VALUES (1, 8, 9, 10, 11, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place FROM (SELECT birth_date, birth_place, MAX(n) AS maxn FROM (SELECT name, weight, n, name_other, height, birth_date, birth_place, n AS people_id FROM (SELECT LHS.name AS name, LHS.weight AS weight, LHS.n AS n, RHS.name AS name_other, RHS.height AS height, RHS.birth_date AS birth_date, RHS.birth_place AS birth_place FROM (SELECT name, weight, COUNT(*) AS n FROM people GROUP BY name, weight) AS LHS INNER JOIN people AS RHS ON (LHS.n = RHS.people_id AND LHS.weight = RHS.weight))) GROUP BY birth_date, birth_place) ORDER BY birth_place;

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT Birth_Place FROM people GROUP BY Birth_Place ORDER BY COUNT(*) DESC, Birth_Place NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/