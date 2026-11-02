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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 1, '2023-01-01 00:00:00.000000', 'Zolomon', '2023-01-01 00:00:00.000000', 'default2', 'Zolomon', NULL, NULL, 1, 0, 1, 0, 'Zolomon'), (0, 0, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'default1', 'default1', 1, 0, 0, 1, 1, 'Zolomon'), (2, NULL, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'default1', NULL, 'default1', 1, NULL, 1, 0, 1, 'default2'), (3, 1, NULL, 'Zolomon', NULL, 'Zolomon', 'default1', 'default2', NULL, 0, 0, 0, 1, NULL), (4, 0, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default2', 'default2', 'default2', 1, 1, NULL, 1, 0, 'Zolomon'), (5, 0, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default1', NULL, NULL, 1, NULL, NULL, 0, NULL, NULL), (6, 1, NULL, 'default1', '2023-01-01 00:00:00.000000', 'Zolomon', 'default2', NULL, 0, NULL, 1, 0, NULL, 'default1'), (7, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', 'Zolomon', 'default1', NULL, 1, NULL, 1, NULL, 'default2'), (8, NULL, NULL, NULL, '2023-01-01 00:00:00.000000', NULL, 'Zolomon', 'Zolomon', 0, 1, 0, 1, NULL, NULL), (9, NULL, '2023-01-01 01:00:00.000000', 'Zolomon', '2023-01-01 00:00:00.000000', NULL, 'default1', NULL, 1, 0, NULL, 1, 1, NULL), (10, 1, NULL, 'default1', NULL, 'default1', 'default1', 'Zolomon', 0, 0, 0, NULL, NULL, NULL), (11, 1, '2023-01-01 01:00:00.000000', 'default2', NULL, 'Zolomon', NULL, 'Zolomon', 0, 0, 0, 1, NULL, 'default1'), (12, 0, '2023-01-01 01:00:00.000000', 'default2', NULL, NULL, NULL, 'Zolomon', 0, 0, 1, 1, 1, 'Zolomon'), (13, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 1, NULL, 0, 1, 1, NULL), (14, 0, '2023-01-01 01:00:00.000000', 'Zolomon', '2023-01-01 01:00:00.000000', 'Zolomon', 'default1', 'default1', 0, 0, 1, 1, 0, 'Zolomon'), (15, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'Zolomon', 'default1', 'Zolomon', 1, 0, 1, 0, 1, 'Zolomon'), (16, NULL, NULL, 'default2', '2023-01-01 00:00:00.000000', 'Zolomon', 'default2', 'default1', 1, 0, NULL, 1, 1, 'default2'), (17, NULL, NULL, 'Zolomon', '2023-01-01 01:00:00.000000', NULL, 'default1', 'default2', 1, 0, 1, 1, NULL, 'default2'), (18, 1, '2023-01-01 01:00:00.000000', 'Zolomon', NULL, NULL, 'default2', 'Zolomon', 0, 1, 1, NULL, NULL, NULL), (19, 0, NULL, NULL, '2023-01-01 01:00:00.000000', 'Zolomon', 'default2', NULL, NULL, 1, 0, 0, NULL, 'default1'), (20, 1, '2023-01-01 01:00:00.000000', 'Zolomon', '2023-01-01 00:00:00.000000', 'default1', NULL, 'default2', NULL, 0, 0, 1, NULL, 'default2'), (21, 1, NULL, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 1, NULL, 0, NULL, NULL, 'default2'), (22, 1, '2023-01-01 00:00:00.000000', 'Zolomon', '2023-01-01 00:00:00.000000', NULL, 'Zolomon', 'default1', NULL, 1, 0, 0, 0, NULL), (23, NULL, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default1', NULL, 'default2', 0, 1, NULL, 1, NULL, NULL), (24, 1, NULL, 'default1', NULL, 'Zolomon', 'Zolomon', 'default1', 0, 1, 1, 1, 0, NULL), (25, 0, NULL, 'Zolomon', NULL, 'default1', 'default2', NULL, 0, NULL, NULL, NULL, 0, NULL), (26, 0, '2023-01-01 01:00:00.000000', 'Zolomon', NULL, 'default2', 'default1', 'default2', NULL, 1, NULL, 0, NULL, 'default1'), (27, 0, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default1', 'default2', 1, 1, 1, NULL, NULL, NULL), (28, 0, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 1, 0, 1, 1, 1, 'Zolomon'), (29, 0, NULL, 'Zolomon', '2023-01-01 00:00:00.000000', 'default1', 'default2', NULL, 0, 1, 0, 1, 1, NULL), (30, NULL, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default2', NULL, 1, 0, NULL, NULL, 0, 'default2'), (31, NULL, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default1', 'default2', 'default1', 1, NULL, 0, 1, 1, NULL), (32, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, 'default2', 'default1', NULL, 0, 0, 1, NULL, NULL), (33, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 'Zolomon', NULL, 1, 0, 1, 0, 0, NULL);
INSERT INTO badges (id, userid, name, date) VALUES (1, 33, 'default1', '2023-01-01 01:00:00.000000'), (0, 20, 'default2', '2023-01-01 00:00:00.000000'), (2, 3, NULL, '2023-01-01 00:00:00.000000'), (3, 16, 'Zolomon', NULL), (4, 2, 'Zolomon', NULL), (5, 13, 'default2', '2023-01-01 00:00:00.000000'), (6, 8, 'Zolomon', NULL), (7, 29, 'Zolomon', NULL), (8, 28, 'default1', '2023-01-01 01:00:00.000000'), (9, 16, 'Zolomon', '2023-01-01 00:00:00.000000'), (10, 3, 'default1', '2023-01-01 00:00:00.000000'), (11, 18, 'Zolomon', NULL), (12, 13, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Date - T2.CreationDate FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.DisplayName = 'Zolomon';

/*
Gold Result:
(0,)
(None,)
(None,)
(None,)
(None,)
*/

-- Prediction Query
SELECT JULIANDAY(T1.Date) - JULIANDAY(T2.CreationDate) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.DisplayName = 'Zolomon';

/*
Prediction Result:
(-0.04166666651144624,)
(None,)
(None,)
(None,)
(None,)
*/