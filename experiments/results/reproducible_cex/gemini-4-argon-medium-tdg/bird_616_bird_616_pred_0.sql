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
INSERT INTO users (Id, Reputation, DisplayName) VALUES (1, 100, 'User1');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (2, 200, 'User2');
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, OwnerUserId) VALUES (10, 1, '2010-07-19 19:19:56.0', 999, 1);
INSERT INTO posts (Id, PostTypeId, CreaionDate, Score, OwnerUserId) VALUES (20, 1, '2010-01-01 00:00:00.0', 888, 2);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (100, 10, 5, 'Valid comment 1', '2010-07-19 19:19:56.0', 1);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (101, 10, 5, 'Valid comment 2 (duplicate score)', '2010-07-19 19:19:56.0', 2);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (102, 20, 12, 'Valid comment 3 on different post', '2010-07-19 19:19:56.0', 1);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (103, NULL, 77, 'Comment with NULL PostId', '2010-07-19 19:19:56.0', 1);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (104, 10, 33, 'Comment with earlier date', '2010-07-19 19:19:55.0', 1);
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId) VALUES (105, 10, 44, 'Comment with later date', '2010-07-19 19:19:57.0', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Score FROM comments AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T1.CreationDate = '2010-07-19 19:19:56.0';

/*
Gold Result:
(5,)
(5,)
(12,)
*/

-- Prediction Query
SELECT comments.Score FROM comments INNER JOIN posts ON comments.PostId = posts.Id WHERE posts.CreaionDate = '2010-07-19 19:19:56.0';

/*
Prediction Result:
(5,)
(5,)
(33,)
(44,)
*/