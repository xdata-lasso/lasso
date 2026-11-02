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
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (1, 100, 'Mornington', 999, 10, 1);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (2, 200, 'Amos', 888, 20, 2);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (3, 300, 'OtherUser', 777, 30, 3);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, OwnerDisplayName, LastEditorDisplayName) VALUES (10, 1, 5, 15, 2, 1, 2, 0, 2, 'Amos', 'Amos');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, OwnerDisplayName, LastEditorDisplayName) VALUES (20, 1, 8, 25, 3, 2, 4, 1, 3, 'OtherUser', 'OtherUser');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, OwnerDisplayName, LastEditorDisplayName) VALUES (30, 1, 3, 12, 1, 0, 1, 0, 1, 'Mornington', 'Mornington');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, OwnerDisplayName, LastEditorDisplayName) VALUES (40, 1, 50, 100, 1, 5, 10, 3, 1, 'Mornington', 'Mornington');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, UserDisplayName) VALUES (100, 2, 10, 1, 'WrongName1');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, UserDisplayName) VALUES (101, 2, 20, 1, 'WrongName2');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, UserDisplayName) VALUES (102, 2, 30, 2, 'WrongName3');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, UserDisplayName) VALUES (103, 2, 40, 3, 'Mornington');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(T1.DisplayName = 'Mornington', T3.ViewCount, 0)) - SUM(IIF(T1.DisplayName = 'Amos', T3.ViewCount, 0)) AS diff FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T3.Id = T2.PostId;

/*
Gold Result:
(28,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN users.DisplayName = 'Mornington' THEN posts.ViewCount ELSE 0 END) - SUM(CASE WHEN users.DisplayName = 'Amos' THEN posts.ViewCount ELSE 0 END)) AS ViewCountDifference FROM posts INNER JOIN users ON posts.OwnerUserId = users.Id;

/*
Prediction Result:
(97,)
*/