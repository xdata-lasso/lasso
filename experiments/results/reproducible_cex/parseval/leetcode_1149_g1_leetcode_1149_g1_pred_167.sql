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

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1644814318, 1465859724, NULL, '2023-04-22');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (700293388, 906324270, NULL, '2020-05-06');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2122220075, 1072996612, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (13244799, -1659388584, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1526238907, -1377057208, NULL, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-841692980, -1364429300, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1257178728, 1236688122, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2087640001, 907682809, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (2026480202, -1576219117, -1823627488, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1209887326, -1399556171, 1038707349, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1419861592, 700088193, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (374105386, 1274489983, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1683203397, 528680845, 1, NULL);

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1585009206, -53231346, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-443340271, 757448742, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1179823637, 1119186446, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (781505063, 418417917, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (-1031969798, -1106983592, 1, '2024-06-15');

INSERT INTO "views" ("article_id", "author_id", "viewer_id", "view_date") VALUES (1884179925, 902551284, 1, '2024-06-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT V1.VIEWER_ID AS ID FROM VIEWS AS V1 JOIN VIEWS AS V2 ON (V1.VIEW_DATE = V2.VIEW_DATE OR (V1.VIEW_DATE IS NULL AND V2.VIEW_DATE IS NULL)) AND V1.VIEWER_ID = V2.VIEWER_ID AND V1.ARTICLE_ID <> V2.ARTICLE_ID ORDER BY 1, ID NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH T1 AS (SELECT V.VIEWER_ID, COUNT(DISTINCT V.ARTICLE_ID) AS ART_CNT, V.VIEW_DATE FROM VIEWS AS V GROUP BY VIEWER_ID, VIEW_DATE) SELECT DISTINCT T1.VIEWER_ID AS ID FROM T1 WHERE T1.ART_CNT > 1 ORDER BY ID;

/*
Prediction Result:
(None,)
(1,)
*/