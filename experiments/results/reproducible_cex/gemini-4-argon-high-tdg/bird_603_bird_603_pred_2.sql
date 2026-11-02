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
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (100, 500, '2009-01-01 00:00:00', 'OwnerUser');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (686, 1200, '2009-06-01 00:00:00', 'TargetEditor');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId) VALUES (1, 1, '2010-01-10 10:00:00', 50, 100, 100, 2, 3, 10, 100);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId) VALUES (2, 1, '2010-02-10 10:00:00', 60, 200, 100, 4, 5, 10, 100);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId) VALUES (3, 1, '2010-03-10 10:00:00', 70, 300, 100, 6, 7, 25, 100);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, CreationDate, UserId) VALUES (101, 2, 1, '2011-03-15 10:00:00', 686);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, CreationDate, UserId) VALUES (102, 5, 1, '2011-04-20 12:00:00', 686);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, CreationDate, UserId) VALUES (103, 2, 2, '2011-07-01 08:30:00', 686);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, CreationDate, UserId) VALUES (104, 2, 3, '2011-11-11 11:11:11', 686);
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