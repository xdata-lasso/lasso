-- Schema DDL
CREATE TABLE "Tweets" ("tweet_id" INTEGER PRIMARY KEY, "content" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Tweets (tweet_id, content) VALUES (10, NULL);
INSERT INTO Tweets (tweet_id, content) VALUES (11, '');
INSERT INTO Tweets (tweet_id, content) VALUES (12, 'short');
INSERT INTO Tweets (tweet_id, content) VALUES (13, 'This is a very long tweet that easily exceeds the limit.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15;

/*
Gold Result:
(13,)
*/

-- Prediction Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15 OR CONTENT IS NULL;

/*
Prediction Result:
(10,)
(13,)
*/