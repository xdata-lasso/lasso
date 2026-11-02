-- Schema DDL
CREATE TABLE "Tweets" ("tweet_id" INTEGER PRIMARY KEY, "content" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests strict boundary conditions around length 15 (14, 15, 16)
INSERT INTO "Tweets" ("tweet_id", "content") VALUES (1, '12345678901234');
INSERT INTO "Tweets" ("tweet_id", "content") VALUES (2, '123456789012345');
INSERT INTO "Tweets" ("tweet_id", "content") VALUES (3, '1234567890123456');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15;

/*
Gold Result:
(3,)
*/

-- Prediction Query
WITH A AS (SELECT TWEET_ID, CONTENT, SUBSTRING(' ,CONTENT,', 16) AS S FROM TWEETS) SELECT TWEET_ID FROM A WHERE S <> '';

/*
Prediction Result:
*/