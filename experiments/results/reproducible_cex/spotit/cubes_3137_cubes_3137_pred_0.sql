-- Schema DDL
CREATE TABLE "ARTIST" (
    "ARTIST_ID" INT,
    "NAME" TEXT,
    "COUNTRY" TEXT,
    "YEAR_JOIN" INT,
    "AGE" INT,
    PRIMARY KEY ("ARTIST_ID")
);
CREATE TABLE "EXHIBITION" (
    "EXHIBITION_ID" INT,
    "ARTIST_ID" INT,
    "YEAR" INT,
    "THEME" TEXT,
    "TICKET_PRICE" FLOAT,
    PRIMARY KEY ("EXHIBITION_ID"),
    FOREIGN KEY ("ARTIST_ID") REFERENCES "ARTIST"("ARTIST_ID")
);
CREATE TABLE "EXHIBITION_RECORD" (
    "EXHIBITION_ID" INT,
    "DATE" TEXT,
    "ATTENDANCE" INT,
    PRIMARY KEY ("EXHIBITION_ID", "DATE"),
    FOREIGN KEY ("EXHIBITION_ID") REFERENCES "EXHIBITION"("EXHIBITION_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ARTIST VALUES (1, 2, 31, 0, 0);
INSERT INTO ARTIST VALUES (0, 2, 34, 0, 0);
INSERT INTO EXHIBITION VALUES (1, 0, 0, 29, 30);
INSERT INTO EXHIBITION VALUES (0, 1, 0, 32, 33);
INSERT INTO EXHIBITION_RECORD VALUES (1, 7, 0);
INSERT INTO EXHIBITION_RECORD VALUES (0, 8, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.exhibition_id AS exhibition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.ticket_price AS ticket_price FROM artist AS LHS INNER JOIN exhibition AS RHS ON (LHS.artist_id = RHS.artist_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('2', 2)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id GROUP BY T1.artist_id;

/*
Prediction Result:
('2', 1)
('2', 1)
*/