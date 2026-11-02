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
INSERT INTO users (Id, DisplayName, Views, Reputation) VALUES (1, 'Harvey Motulsky', 10, 10);
INSERT INTO users (Id, DisplayName, Views, Reputation) VALUES (2, 'Noah Snyder', 500, 500);
INSERT INTO users (Id, DisplayName, Views, Reputation) VALUES (3, 'Other User', 9999, 9999);
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount, OwnerUserId, LastEditorUserId, OwnerDisplayName) VALUES (101, 40, 5, 1, 1, 1, 2, 2, 'Noah Snyder');
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount, OwnerUserId, LastEditorUserId, OwnerDisplayName) VALUES (102, 45, 5, 1, 1, 1, 2, 2, 'Noah Snyder');
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount, OwnerUserId, LastEditorUserId, OwnerDisplayName) VALUES (103, 50, 5, 1, 1, 1, 2, 2, 'Noah Snyder');
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount, OwnerUserId, LastEditorUserId, OwnerDisplayName) VALUES (104, 100, 500, 50, 50, 50, 1, 1, 'Harvey Motulsky');
INSERT INTO posts (Id, ViewCount, Score, AnswerCount, CommentCount, FavoriteCount, OwnerUserId, LastEditorUserId, OwnerDisplayName) VALUES (105, 9999, 999, 99, 99, 99, 3, 3, 'Other User');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (1, 101, 1, 'Noah Snyder');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (2, 102, 1, 'Noah Snyder');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (3, 103, 1, 'Noah Snyder');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (4, 104, 2, 'Harvey Motulsky');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName) VALUES (5, 105, 3, 'Other User');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'Harvey Motulsky' OR T1.DisplayName = 'Noah Snyder' GROUP BY T1.DisplayName ORDER BY SUM(T3.ViewCount) DESC, T1.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('Harvey Motulsky',)
*/

-- Prediction Query
SELECT T1.Title FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'Harvey Motulsky' OR T2.DisplayName = 'Noah Snyder' ORDER BY T1.ViewCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/