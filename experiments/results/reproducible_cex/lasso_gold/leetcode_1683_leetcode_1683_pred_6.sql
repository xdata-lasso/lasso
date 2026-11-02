-- Schema DDL
CREATE TABLE "Tweets" ("tweet_id" INTEGER PRIMARY KEY, "content" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "tweets" ("tweet_id", "content") VALUES (1011, 'agoagoagoagoagoa');
INSERT INTO "tweets" ("tweet_id", "content") VALUES (1012, ' sitsitsitsitsi ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15;

/*
Gold Result:
(1011,)
(1012,)
*/

-- Prediction Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(TRIM(CONTENT)) > 15;

/*
Prediction Result:
(1011,)
*/