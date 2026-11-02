-- Schema DDL
CREATE TABLE "VIEWS" (
    "ARTICLE_ID" INT,
    "AUTHOR_ID" INT,
    "VIEWER_ID" INT,
    "VIEW_DATE" DATE
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO VIEWS VALUES (0, 0, -1, '0001-01-01');
INSERT INTO VIEWS VALUES (0, -1, -2, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.AUTHOR_ID AS ID FROM VIEWS AS A CROSS JOIN VIEWS AS B WHERE A.ARTICLE_ID = B.ARTICLE_ID AND A.AUTHOR_ID = B.VIEWER_ID ORDER BY A.AUTHOR_ID, ID NULLS LAST;

/*
Prediction Result:
(-1,)
*/