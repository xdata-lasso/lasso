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
INSERT INTO VIEWS VALUES (0, -1, 0, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY id;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT V.AUTHOR_ID AS ID FROM VIEWS AS V INNER JOIN VIEWS AS U ON V.AUTHOR_ID = U.VIEWER_ID AND V.ARTICLE_ID = U.ARTICLE_ID ORDER BY V.AUTHOR_ID ASC, ID NULLS LAST;

/*
Prediction Result:
(-1,)
*/