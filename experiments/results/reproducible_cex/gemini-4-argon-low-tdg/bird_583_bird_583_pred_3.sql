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
-- Tests basic aggregation, SUM(DISTINCT) vs SUM(ALL), GROUP BY WebsiteUrl vs GROUP BY User.Id, and DisplayName filtering.
INSERT INTO users (Id, DisplayName, WebsiteUrl, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (1, 'Yevgeny', 'http://siteA.com', 100, 10, 5, 1, 25, 1001);
INSERT INTO users (Id, DisplayName, WebsiteUrl, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (2, 'Yevgeny', 'http://siteA.com', 200, 20, 6, 2, 30, 1002);
INSERT INTO users (Id, DisplayName, WebsiteUrl, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (3, 'Yevgeny', 'http://siteB.com', 300, 30, 7, 3, 35, 1003);
INSERT INTO users (Id, DisplayName, WebsiteUrl, Reputation, Views, UpVotes, DownVotes, Age, AccountId) VALUES (4, 'OtherUser', 'http://siteA.com', 400, 40, 8, 4, 40, 1004);
INSERT INTO posts (Id, OwnerUserId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount, PostTypeId) VALUES (10, 1, 5, 50, 1, 2, 3, 1);
INSERT INTO posts (Id, OwnerUserId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount, PostTypeId) VALUES (11, 1, 5, 60, 2, 3, 4, 1);
INSERT INTO posts (Id, OwnerUserId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount, PostTypeId) VALUES (12, 2, 10, 70, 3, 4, 5, 2);
INSERT INTO posts (Id, OwnerUserId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount, PostTypeId) VALUES (13, 3, -3, 80, 0, 1, 0, 1);
INSERT INTO posts (Id, OwnerUserId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount, PostTypeId) VALUES (14, 4, 100, 90, 5, 6, 7, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T1.Score), T2.WebsiteUrl FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'Yevgeny' GROUP BY T2.WebsiteUrl;

/*
Gold Result:
(20, 'http://siteA.com')
(-3, 'http://siteB.com')
*/

-- Prediction Query
SELECT SUM(T2.Score), T1.WebsiteUrl FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.LastEditorUserId WHERE T1.DisplayName = 'Yevgeny';

/*
Prediction Result:
(None, None)
*/