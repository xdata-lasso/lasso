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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, NULL, NULL, NULL, '2023-01-01 00:00:00.000000', 'default1', 'default2', 'default1', 2, 2, 1, 1, NULL, NULL), (0, 0, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', NULL, NULL, NULL, 2, 0, 0, 1, 'default2'), (2, 1, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, 'default1', NULL, 0, 0, NULL, 0, NULL, 'default1'), (3, 1, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default1', NULL, 'default2', 0, 1, 0, 0, NULL, 'default1'), (4, 0, NULL, 'default1', '2023-01-01 01:00:00.000000', 'default1', 'default2', 'default2', 1, NULL, 0, 0, 0, 'default2'), (5, 2, NULL, 'default2', NULL, 'default2', 'default1', 'default1', 2, 1, NULL, 1, 0, NULL), (6, 2, NULL, 'default2', NULL, 'default1', 'default1', 'default1', 2, 0, NULL, 1, 2, 'default1'), (7, 0, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', 0, 0, 0, 2, NULL, NULL), (8, 1, '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 'default2', NULL, 1, 0, 1, NULL, 1, 'default2');
INSERT INTO badges (id, userid, name, date) VALUES (0, 6, NULL, '2023-01-01 00:00:00.000000'), (1, 4, NULL, '2023-01-01 01:00:00.000000'), (2, 7, NULL, NULL), (3, 5, NULL, '2023-01-01 01:00:00.000000'), (4, 8, 'default1', '2023-01-01 01:00:00.000000'), (5, 2, 'default1', '2023-01-01 00:00:00.000000'), (6, 3, 'default2', '2023-01-01 01:00:00.000000'), (7, 6, 'default2', '2023-01-01 01:00:00.000000'), (8, 3, 'default2', NULL), (9, 1, 'default1', '2023-01-01 01:00:00.000000'), (10, NULL, NULL, '2023-01-01 01:00:00.000000'), (11, NULL, 'default2', '2023-01-01 00:00:00.000000'), (12, 7, 'default2', '2023-01-01 00:00:00.000000'), (13, 1, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId GROUP BY T1.DisplayName ORDER BY COUNT(T1.Id) DESC, T1.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT u.DisplayName FROM badges AS b INNER JOIN users AS u ON b.UserId = u.Id GROUP BY b.UserId, u.DisplayName ORDER BY COUNT(b.Id) DESC, u.DisplayName NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/