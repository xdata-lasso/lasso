-- Schema DDL
CREATE TABLE "Tweets" ("tweet_id" INTEGER PRIMARY KEY, "content" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Tweets (tweet_id, content) VALUES (10, '   twelve_chr   ');
INSERT INTO Tweets (tweet_id, content) VALUES (20, '                ');
INSERT INTO Tweets (tweet_id, content) VALUES (30, '               ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15;

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(TRIM(CONTENT)) > 15;

/*
Prediction Result:
*/