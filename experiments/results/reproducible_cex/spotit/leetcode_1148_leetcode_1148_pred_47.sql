-- Schema DDL
CREATE TABLE "VIEWS" (
    "ARTICLE_ID" INT,
    "AUTHOR_ID" INT,
    "VIEWER_ID" INT,
    "VIEW_DATE" DATE
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO VIEWS VALUES (NULL, 1, 1, '0001-01-01');
INSERT INTO VIEWS VALUES (1, 0, 0, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT T1.AUTHOR_ID AS ID FROM VIEWS AS T1 LEFT JOIN VIEWS AS T2 ON T1.AUTHOR_ID = T2.VIEWER_ID AND T1.ARTICLE_ID = T2.ARTICLE_ID GROUP BY 1 HAVING COUNT(T2.VIEWER_ID) >= 1 ORDER BY 1, ID NULLS LAST;

/*
Prediction Result:
(0,)
*/