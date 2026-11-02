-- Schema DDL
CREATE TABLE "Tweets" ("tweet_id" INTEGER PRIMARY KEY, "content" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL, empty string, and whitespace padding (kills TRIM/LTRIM/RTRIM mutants)
INSERT INTO "Tweets" ("tweet_id", "content") VALUES (10, NULL);
INSERT INTO "Tweets" ("tweet_id", "content") VALUES (20, '');
INSERT INTO "Tweets" ("tweet_id", "content") VALUES (30, '                ');
INSERT INTO "Tweets" ("tweet_id", "content") VALUES (40, '   short text   ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15;

/*
Gold Result:
(30,)
(40,)
*/

-- Prediction Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15 OR CONTENT IS NULL;

/*
Prediction Result:
(10,)
(30,)
(40,)
*/