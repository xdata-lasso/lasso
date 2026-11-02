-- Schema DDL
CREATE TABLE "USERS" (
    "USER_ID" INT,
    "NAME" TEXT,
    "POINTS" INT,
    PRIMARY KEY ("USER_ID")
);
CREATE TABLE "COMMENTS" (
    "COMMENT_ID" INT,
    "USER_ID" INT,
    "SCORE" INT,
    PRIMARY KEY ("COMMENT_ID"),
    FOREIGN KEY ("USER_ID") REFERENCES "USERS"("USER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO USERS VALUES (1, 19, 0);
INSERT INTO USERS VALUES (0, 20, 1);
INSERT INTO COMMENTS VALUES (1, 0, 1);
INSERT INTO COMMENTS VALUES (2, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.score FROM users AS u INNER JOIN comments AS c ON u.user_id = c.user_id ORDER BY u.points ASC, u.user_id, c.comment_id LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT c.score FROM comments AS c WHERE c.user_id IN (SELECT u.user_id FROM users AS u ORDER BY u.points ASC, u.user_id LIMIT 1);

/*
Prediction Result:
*/