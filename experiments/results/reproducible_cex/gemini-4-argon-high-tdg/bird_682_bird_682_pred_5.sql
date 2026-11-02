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
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, Views, UpVotes, DownVotes, AccountId, Age) VALUES (10, 500, '2009-12-31 23:59:59', 'User2009', '2010-05-01 10:00:00', 500, 100, 10, 1001, 40);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, Views, UpVotes, DownVotes, AccountId, Age) VALUES (20, 10, '2010-06-15 12:00:00', 'Winner2010', '2012-01-01 00:00:00', 5, 1, 0, 1002, 20);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, Views, UpVotes, DownVotes, AccountId, Age) VALUES (30, 900, '2010-08-20 08:30:00', 'RunnerUp2010', '2010-09-01 00:00:00', 800, 200, 50, 1003, 35);
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, Views, UpVotes, DownVotes, AccountId, Age) VALUES (40, 1000, '2011-01-01 00:00:00', 'User2011', '2010-07-07 07:07:07', 999, 300, 60, 1004, 50);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, LasActivityDate, Title, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, OwnerDisplayName, LastEditorDisplayName) VALUES (101, 1, '2010-03-10 10:00:00', 999, 9999, 10, '2010-03-10 10:00:00', 'Post by 2009 user', 50, 50, 500, 20, '2010-03-10 10:00:00', 'WrongOwnerName1', 'Editor1');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, LasActivityDate, Title, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, OwnerDisplayName, LastEditorDisplayName) VALUES (201, 1, '2012-05-05 05:05:05', 5, 10, 20, '2012-05-05 05:05:05', 'Winning Post', 1, 1, 100, 30, '2012-05-05 05:05:05', 'WrongOwnerName2', 'Editor2');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, LasActivityDate, Title, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, OwnerDisplayName, LastEditorDisplayName) VALUES (301, 1, '2010-09-15 10:00:00', 800, 5000, 30, '2010-09-15 10:00:00', 'RunnerUp Post', 20, 30, 20, 20, '2010-09-15 10:00:00', 'WrongOwnerName3', 'Editor3');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, LasActivityDate, Title, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, OwnerDisplayName, LastEditorDisplayName) VALUES (401, 1, '2010-04-01 12:00:00', 1000, 10000, 40, '2010-04-01 12:00:00', 'Post by 2011 user', 60, 60, 999, 20, '2010-04-01 12:00:00', 'WrongOwnerName4', 'Editor4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.OwnerUserId, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE STRFTIME('%Y', T1.CreationDate) = '2010' ORDER BY T2.FavoriteCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(20, 'Winner2010')
*/

-- Prediction Query
SELECT T1.Id, T1.OwnerDisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE STRFTIME('%Y', T1.CreaionDate) = '2010' ORDER BY T1.FavoriteCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(401, 'WrongOwnerName4')
*/