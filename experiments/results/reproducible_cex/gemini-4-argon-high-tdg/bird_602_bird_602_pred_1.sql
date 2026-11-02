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
INSERT INTO users (Id, Reputation, DisplayName) VALUES (1, 100, 'Alice');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (2, 200, 'Bob');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (3, 300, 'Charlie');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (4, 400, 'Diana');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (5, 500, 'Eve');
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId, LastEditorUserId, Title) VALUES (10, 1, 59, 5, 5, 'Post with Score 59');
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId, LastEditorUserId, Title) VALUES (20, 1, 60, 5, 5, 'Post with Score 60');
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId, LastEditorUserId, Title) VALUES (30, 1, 61, 5, 5, 'Post with Score 61');
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId, LastEditorUserId, Title) VALUES (40, 1, 150, 5, 5, 'Post with Score 150');
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId, LastEditorUserId, Title) VALUES (50, 1, NULL, 5, 5, 'Post with NULL Score');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (101, 2, 10, 1, 'History for Score 59');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (102, 2, 20, 2, 'History for Score 60');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (103, 2, 30, 3, 'History for Score 61');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (104, 2, 40, 4, 'History for Score 150');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (105, 2, 50, 5, 'History for Score NULL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PostId, UserId FROM postHistory WHERE PostId IN (SELECT Id FROM posts WHERE Score > 60);

/*
Gold Result:
(30, 3)
(40, 4)
*/

-- Prediction Query
SELECT T1.Id, T1.OwnerUserId FROM posts AS T1 WHERE T1.Score > 60;

/*
Prediction Result:
(30, 5)
(40, 5)
*/