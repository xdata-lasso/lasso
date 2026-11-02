-- Schema DDL
CREATE TABLE "Tweets" ("tweet_id" INTEGER PRIMARY KEY, "content" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Tweets (tweet_id, content) VALUES (1, '                ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(TRIM(CONTENT)) > 15;

/*
Prediction Result:
*/