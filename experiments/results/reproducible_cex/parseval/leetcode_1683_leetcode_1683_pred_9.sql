-- Schema DDL
CREATE TABLE "Tweets" ("tweet_id" INTEGER PRIMARY KEY, "content" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: tweets --
INSERT INTO "tweets" ("tweet_id", "content") VALUES (1, '+7Aw?U_A??A?o?/#');

INSERT INTO "tweets" ("tweet_id", "content") VALUES (2, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TWEET_ID FROM TWEETS WHERE LENGTH(CONTENT) > 15;

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH A AS (SELECT TWEET_ID, CONTENT, SUBSTRING(' ,CONTENT,', 16) AS S FROM TWEETS) SELECT TWEET_ID FROM A WHERE S <> '';

/*
Prediction Result:
*/