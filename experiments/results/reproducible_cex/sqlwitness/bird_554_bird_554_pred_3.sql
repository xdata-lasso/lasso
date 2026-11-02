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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, 2, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'default2', 'default1', 2, 1, 2, 0, 1, 'default1'), (2, 1, '2023-01-01 01:00:00.000000', 'default1', NULL, 'default2', 'default2', 'default1', NULL, 0, 1, 0, 0, 'default2'), (1, 2, '2023-01-01 00:00:00.000000', NULL, NULL, NULL, NULL, 'default1', NULL, 0, NULL, 1, NULL, 'default1'), (3, 0, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 1, 2, NULL, NULL, 1, 'default2'), (4, 2, NULL, NULL, NULL, 'default2', 'default1', 'default2', 2, 0, 1, 0, 0, 'default2'), (5, NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default2', 'default1', 'default1', 2, NULL, 0, 2, 2, NULL), (6, 1, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 0, NULL, 2, NULL, 1, 'default1'), (7, 1, '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', NULL, 'default1', 0, 2, 0, 0, 0, 'default2'), (8, 1, NULL, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 1, NULL, 2, 2, NULL, NULL), (9, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', NULL, NULL, NULL, 1, 1, NULL, NULL, 'default2'), (10, 1, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, 'default1', NULL, 1, 1, 0, NULL, 0, NULL), (11, NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, NULL, NULL, NULL, 1, NULL, 1, 0, 0, 'default2'), (12, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', NULL, NULL, 2, NULL, 2, 'default1'), (13, 1, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default2', NULL, 0, NULL, 2, 0, 1, 'default1'), (14, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', 2, 1, 0, 1, 2, 'default1'), (15, 1, '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', 'default1', 'default1', 0, 1, 0, 0, 2, NULL), (16, 1, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default1', 'default1', 1, 2, NULL, NULL, 2, 'default2'), (17, 2, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default1', 'default2', 0, 2, NULL, 0, 0, NULL), (18, 2, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', 2, 2, NULL, 1, NULL, 'default2'), (19, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default1', NULL, 0, NULL, 1, 1, 2, NULL), (20, 0, '2023-01-01 00:00:00.000000', 'default1', NULL, NULL, 'default2', 'default2', 0, 0, NULL, 1, 2, 'default1'), (21, 0, '2023-01-01 01:00:00.000000', NULL, NULL, 'default1', 'default2', 'default1', 1, 2, 1, 1, 2, NULL);
INSERT INTO badges (id, userid, name, date) VALUES (1, 20, NULL, '2023-01-01 01:00:00.000000'), (2, 15, NULL, '2023-01-01 00:00:00.000000'), (0, 9, 'default1', '2023-01-01 01:00:00.000000'), (3, 8, NULL, '2023-01-01 00:00:00.000000'), (4, 9, 'default1', '2023-01-01 01:00:00.000000'), (5, 18, 'default1', '2023-01-01 00:00:00.000000'), (6, 18, NULL, '2023-01-01 00:00:00.000000'), (7, 17, 'default1', NULL), (8, NULL, 'default1', NULL), (9, 6, NULL, '2023-01-01 00:00:00.000000'), (10, 13, 'default1', NULL), (11, 2, 'default1', NULL), (12, 13, NULL, '2023-01-01 00:00:00.000000'), (13, 5, 'default2', '2023-01-01 01:00:00.000000'), (14, 19, 'default1', NULL), (15, 17, 'default2', NULL), (16, 14, NULL, '2023-01-01 00:00:00.000000'), (17, 1, 'default2', '2023-01-01 00:00:00.000000'), (18, 19, 'default2', NULL), (19, 7, NULL, NULL), (20, 19, 'default2', NULL), (21, 9, 'default1', '2023-01-01 00:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id GROUP BY T2.DisplayName ORDER BY COUNT(T1.Id) DESC, T2.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T2.DisplayName FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id GROUP BY T1.UserId ORDER BY COUNT(T1.Id) DESC, T2.DisplayName NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/