-- Schema DDL
CREATE TABLE "Views" ("article_id" INTEGER, "author_id" INTEGER, "viewer_id" INTEGER, "view_date" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: views --
INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-55602865, -59984348, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-664303813, -1022641847, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1726781632, 247012447, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1980249628, -734455130, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1744686505, -1633151678, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-252690330, 1115440883, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1644814318, 1465859724, -1349201381, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1019800248, -1910425938, -845863578, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1610064545, 429706943, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (462974032, -1137908826, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-918961358, -1602639011, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-45536098, 1861536320, NULL, '2023-11-17');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1399556171, 1038707349, NULL, '2024-07-24');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (546571701, 947159877, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1990080517, 1408123494, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1964997180, 1149850321, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1833165707, 1155439218, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1313172851, -761141909, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (283598170, 742285925, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-747753377, 902887186, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-967741825, 775304493, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (373262291, -472966518, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-921187550, -2070843029, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (328305758, -751275471, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1347802441, 1673584235, 1, '2024-06-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH WLS AS (SELECT VIEWER_ID, VIEW_DATE, COUNT(DISTINCT ARTICLE_ID) AS NUM FROM VIEWS GROUP BY VIEWER_ID, VIEW_DATE) SELECT DISTINCT VIEWER_ID AS ID FROM WLS WHERE NUM > 1 ORDER BY VIEWER_ID ASC, ID NULLS LAST;

/*
Prediction Result:
(None,)
(1,)
*/