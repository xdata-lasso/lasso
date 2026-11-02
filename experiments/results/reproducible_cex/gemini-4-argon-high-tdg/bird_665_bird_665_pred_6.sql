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
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (1, 100, '2009-01-01 00:00:00', 'User1');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, LasActivityDate, AnswerCount, CommentCount, FavoriteCount, LastEditDate) VALUES (10, 5, '2008-05-01 10:00:00', 10, 100, 1, '2008-06-01 10:00:00', 2, 8, 5, '2008-06-01 10:00:00');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, LasActivityDate, AnswerCount, CommentCount, FavoriteCount, LastEditDate) VALUES (20, 5, '2009-05-01 10:00:00', 20, 200, 1, '2009-06-01 10:00:00', 1, 9, 6, '2009-06-01 10:00:00');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, LasActivityDate, AnswerCount, CommentCount, FavoriteCount, LastEditDate) VALUES (30, 1, '2010-05-01 10:00:00', 1, 1, 1, '2010-06-01 10:00:00', 3, 1, 1, '2010-06-01 10:00:00');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, ViewCount, OwnerUserId, LasActivityDate, AnswerCount, CommentCount, FavoriteCount, LastEditDate) VALUES (40, 1, '2010-07-01 10:00:00', 0, 0, 1, '2010-07-01 10:00:00', 5, 0, 0, '2010-07-01 10:00:00');
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (101, '2010-03-15 12:00:00', 10, 30, 5);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (102, '2010-07-20 14:30:00', 20, 40, 5);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (103, '2010-11-05 09:15:00', 20, 30, 5);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (104, '2010-04-10 08:00:00', 30, 10, 1);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (105, '2009-12-31 23:59:59', 10, 20, 1);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (106, '2011-01-01 00:00:00', 20, 10, 1);
INSERT INTO postLinks (Id, CreationDate, PostId, RelatedPostId, LinkTypeId) VALUES (107, '2010-08-08 08:00:00', 40, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T1.Id) AS REAL) / 12 FROM postLinks AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.AnswerCount <= 2 AND STRFTIME('%Y', T1.CreationDate) = '2010';

/*
Gold Result:
(0.25,)
*/

-- Prediction Query
SELECT CAST(COUNT(T2.Id) AS REAL) / 12 FROM posts AS T1 INNER JOIN postLinks AS T2 ON T1.Id = T2.PostId WHERE T1.AnswerCount <= 2 AND STRFTIME('%Y', T1.CreaionDate) = '2010';

/*
Prediction Result:
(0.0,)
*/