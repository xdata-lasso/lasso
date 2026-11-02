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
-- Tests SUM(DISTINCT FavoriteCount) vs SUM(FavoriteCount) across multiple distinct posts,
-- and tests IN subquery vs un-deduplicated JOIN when a single post has multiple matching postHistory rows.
-- Also tests ignoring NULL FavoriteCount and distinguishing FavoriteCount from other integer columns.
INSERT INTO users (Id, Reputation, DisplayName) VALUES (686, 100, 'TargetUser');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount, OwnerUserId) VALUES (1, 1, 99, 100, 5, 2, 10, 686);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount, OwnerUserId) VALUES (2, 1, 88, 200, 3, 4, 10, 686);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount, OwnerUserId) VALUES (3, 1, 77, 300, 1, 0, 25, 686);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount, OwnerUserId) VALUES (4, 1, 66, 400, 0, 1, NULL, 686);
INSERT INTO postHistory (Id, PostId, UserId, CreationDate) VALUES (101, 1, 686, '2011-03-15 10:00:00');
INSERT INTO postHistory (Id, PostId, UserId, CreationDate) VALUES (102, 1, 686, '2011-04-20 12:00:00');
INSERT INTO postHistory (Id, PostId, UserId, CreationDate) VALUES (103, 2, 686, '2011-06-10 08:30:00');
INSERT INTO postHistory (Id, PostId, UserId, CreationDate) VALUES (104, 3, 686, '2011-11-05 19:45:00');
INSERT INTO postHistory (Id, PostId, UserId, CreationDate) VALUES (105, 4, 686, '2011-12-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(DISTINCT FavoriteCount) FROM posts WHERE Id IN (SELECT PostId FROM postHistory WHERE UserId = 686 AND STRFTIME('%Y', CreationDate) = '2011');

/*
Gold Result:
(35,)
*/

-- Prediction Query
SELECT SUM(FavoriteCount) FROM posts WHERE STRFTIME('%Y', CreaionDate) = '2011' AND OwnerUserId = 686;

/*
Prediction Result:
(None,)
*/