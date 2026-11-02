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
-- DATASET 4
INSERT INTO users (Id, Reputation, DisplayName) VALUES (1, 1, 'Community');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (2, 50, 'Bob');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, LastEditorUserId, Title, Tags, OwnerDisplayName, LastEditorDisplayName) VALUES (10, 4, 2, 2, 'Post 10', 'java', 'Bob', 'Bob');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, LastEditorUserId, Title, Tags, OwnerDisplayName, LastEditorDisplayName) VALUES (20, 4, 1, 1, 'Post 20', 'r', 'Community', 'Community');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, LastEditorUserId, Title, Tags, OwnerDisplayName, LastEditorDisplayName) VALUES (30, 4, 2, 2, 'Post 30', 'r', 'Community', 'Community');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, UserDisplayName, Text) VALUES (100, 5, 10, 1, 'Bot', 'Community edited Post 10');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, UserDisplayName, Text) VALUES (200, 5, 20, 2, 'Community', 'Bob edited Post 20');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, UserDisplayName, Text) VALUES (300, 5, 30, 1, 'Bot', 'Community edited Post 30');
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (500, 'r', 100, 10, 20);
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (600, 'java', 200, 20, 10);
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (700, 'c++', 300, 30, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T3.TagName = 'r', 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN tags AS T3 ON T3.ExcerptPostId = T2.PostId WHERE T1.DisplayName = 'Community';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.TagName = 'r' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percentage FROM posts AS T1 INNER JOIN users AS T3 ON T1.OwnerUserId = T3.Id INNER JOIN posts AS T4 ON T4.Id = T1.Id INNER JOIN tags AS T2 ON T2.ExcerptPostId = T4.Id WHERE T3.DisplayName = 'Community';

/*
Prediction Result:
(0.0,)
*/