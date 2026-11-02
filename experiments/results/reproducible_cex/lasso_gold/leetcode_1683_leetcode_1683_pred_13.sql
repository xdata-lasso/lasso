-- Schema DDL
CREATE TABLE "Tweets" ("tweet_id" INTEGER PRIMARY KEY, "content" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "tweets" ("tweet_id", "content") VALUES (1004, 35);
INSERT INTO "tweets" ("tweet_id", "content") VALUES (1005, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15;

/*
Gold Result:
*/

-- Prediction Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15 OR CONTENT IS NULL;

/*
Prediction Result:
(1005,)
*/