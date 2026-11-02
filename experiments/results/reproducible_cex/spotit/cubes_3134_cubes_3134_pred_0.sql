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
INSERT INTO ARTIST VALUES (-1, 0, 0, 0, 0);
INSERT INTO ARTIST VALUES (0, 0, 0, 0, 0);
INSERT INTO EXHIBITION VALUES (1, -1, 0, 1, 24);
INSERT INTO EXHIBITION VALUES (0, -1, 2005, 25, 26);
INSERT INTO EXHIBITION_RECORD VALUES (1, -1, 1);
INSERT INTO EXHIBITION_RECORD VALUES (1, 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, date, attendance FROM (SELECT LHS.exhibition_id AS exhibition_id, LHS.year AS YEAR, LHS.theme AS theme, LHS.artist_id AS artist_id, LHS.ticket_price AS ticket_price, RHS.date AS date, RHS.attendance AS attendance FROM (SELECT * FROM exhibition WHERE (YEAR <= 2004)) AS LHS INNER JOIN exhibition_record AS RHS ON (LHS.exhibition_id = RHS.exhibition_id)) ORDER BY theme, date NULLS LAST, attendance NULLS LAST;

/*
Gold Result:
('1', '-1', 1)
('1', '0', 2)
*/

-- Prediction Query
SELECT T2.theme, T1.date, T1.attendance FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id = T2.exhibition_id WHERE T2.year = 2004;

/*
Prediction Result:
*/