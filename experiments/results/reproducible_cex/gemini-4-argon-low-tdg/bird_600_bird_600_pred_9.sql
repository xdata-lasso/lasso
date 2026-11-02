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
-- Tests basic matching, multiplicity (DISTINCT vs ALL, INNER JOIN vs missing join), boundary values (61216, 61218), and column confusion (ViewCount vs Score/AnswerCount/CommentCount/FavoriteCount, PostId vs RelatedPostId/Id).
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount) VALUES (1, 111, 10, 1, 2, 3);
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount) VALUES (2, 222, 20, 4, 5, 6);
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount) VALUES (61216, 333, 30, 7, 8, 9);
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount) VALUES (61217, 999, 50, 11, 12, 13);
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount) VALUES (61218, 444, 40, 14, 15, 16);
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (101, 61217, 1, 1);
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (102, 61217, 2, 3);
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (103, 61216, 61217, 1);
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (104, 61218, 61217, 1);
INSERT INTO postLinks (Id, PostId, RelatedPostId, LinkTypeId) VALUES (61217, 1, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ViewCount FROM posts AS T1 INNER JOIN postLinks AS T2 ON T1.Id = T2.PostId WHERE T2.PostId = 61217;

/*
Gold Result:
(999,)
(999,)
*/

-- Prediction Query
SELECT ViewCount FROM posts WHERE Id IN (SELECT RelatedPostId FROM postLinks WHERE PostId = 61217);

/*
Prediction Result:
(111,)
(222,)
*/