-- Schema DDL
CREATE TABLE "VIEWS" (
    "ARTICLE_ID" INT,
    "AUTHOR_ID" INT,
    "VIEWER_ID" INT,
    "VIEW_DATE" DATE
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO VIEWS VALUES (0, 1, -1, '0001-01-01');
INSERT INTO VIEWS VALUES (0, 0, 1, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
*/

-- Prediction Query
SELECT ID FROM (SELECT A.AUTHOR_ID AS ID FROM VIEWS AS A CROSS JOIN VIEWS AS B WHERE A.AUTHOR_ID = B.VIEWER_ID AND A.ARTICLE_ID = B.ARTICLE_ID) AS ID GROUP BY ID ORDER BY ID ASC;

/*
Prediction Result:
(1,)
*/