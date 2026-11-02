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
SELECT DISTINCT V1.AUTHOR_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON V1.ARTICLE_ID = V2.ARTICLE_ID AND V1.AUTHOR_ID = V2.VIEWER_ID ORDER BY V1.AUTHOR_ID, ID NULLS LAST;

/*
Prediction Result:
(-1,)
*/