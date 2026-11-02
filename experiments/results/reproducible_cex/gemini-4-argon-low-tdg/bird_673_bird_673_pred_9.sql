-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Tie for MAX(Age) across multiple users (kills LIMIT 1 and scalar '=' subquery mutations).
-- 2. Duplicate PostId values across votes (kills AVG(DISTINCT PostId) mutations).
-- 3. NULL PostId in votes (tests AVG ignoring NULLs vs COUNT(*) mistakes).
-- 4. Votes with NULL UserId and UserId of younger/NULL-age users (kills missing WHERE or inverted IN conditions).
-- 5. Non-integer average result (11, 11, 20 -> 14.0, or with others) and distinct column values (kills wrong column or wrong aggregate function like SUM/COUNT/MIN/MAX).
INSERT INTO users (Id, Reputation, Age) VALUES (1, 100, 50);
INSERT INTO users (Id, Reputation, Age) VALUES (2, 200, 50);
INSERT INTO users (Id, Reputation, Age) VALUES (3, 300, 30);
INSERT INTO users (Id, Reputation, Age) VALUES (4, 400, NULL);
INSERT INTO posts (Id, OwnerUserId, Score) VALUES (10, 1, 5);
INSERT INTO posts (Id, OwnerUserId, Score) VALUES (20, 2, 10);
INSERT INTO posts (Id, OwnerUserId, Score) VALUES (35, 3, 15);
INSERT INTO posts (Id, OwnerUserId, Score) VALUES (100, 1, 20);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (1, 10, 2, 1, 50);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (2, 10, 2, 1, 50);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (3, 35, 3, 2, 100);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (4, NULL, 1, 2, 0);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (5, 100, 2, 3, 200);
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (6, 100, 2, NULL, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(PostId) FROM votes WHERE UserId IN (SELECT Id FROM users WHERE Age = (SELECT MAX(Age) FROM users));

/*
Gold Result:
(18.333333333333332,)
*/

-- Prediction Query
SELECT AVG(DISTINCT v.PostId) AS AverageNumberPostsVoted FROM votes AS v JOIN users AS u ON v.UserId = u.Id WHERE u.Age = (SELECT MAX(Age) FROM users);

/*
Prediction Result:
(22.5,)
*/