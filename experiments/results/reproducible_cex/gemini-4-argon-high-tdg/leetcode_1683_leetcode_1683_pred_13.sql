-- Schema DDL
CREATE TABLE "Tweets" ("tweet_id" INTEGER PRIMARY KEY, "content" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Tweets (tweet_id, content) VALUES (1, NULL);
INSERT INTO Tweets (tweet_id, content) VALUES (2, '');
INSERT INTO Tweets (tweet_id, content) VALUES (3, 'a');
INSERT INTO Tweets (tweet_id, content) VALUES (4, 'This is a very long tweet that easily exceeds fifteen characters in total length.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15 OR CONTENT IS NULL;

/*
Prediction Result:
(1,)
(4,)
*/