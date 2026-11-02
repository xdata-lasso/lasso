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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, 2, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default1', 'default2', NULL, NULL, 0, 2, 0, 'default1'), (1, 2, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default2', 'default1', 'default1', 1, 2, NULL, 2, NULL, 'default2'), (2, 0, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default1', NULL, 'default2', NULL, 1, NULL, 1, 0, NULL), (3, 2, '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 'default1', 'default1', 2, NULL, 1, 2, 2, 'default2'), (4, 2, NULL, 'default2', NULL, 'default2', 'default1', 'default2', 1, NULL, 2, 1, 1, 'default2'), (5, 2, NULL, NULL, '2023-01-01 01:00:00.000000', 'default1', 'default2', 'default1', 2, 0, 2, 2, 1, NULL), (6, 2, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', NULL, 'default2', 'default1', 1, 2, 2, 2, 2, 'default1'), (7, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default1', 'default2', 1, 0, 0, 0, 1, 'default1');
INSERT INTO badges (id, userid, name, date) VALUES (2, 0, NULL, '2023-01-01 01:00:00.000000'), (0, 4, 'default1', NULL), (1, 3, 'default2', '2023-01-01 01:00:00.000000'), (3, 0, NULL, NULL), (4, 6, 'default1', '2023-01-01 01:00:00.000000'), (5, NULL, NULL, '2023-01-01 00:00:00.000000'), (6, 6, 'default2', '2023-01-01 00:00:00.000000'), (7, 7, NULL, '2023-01-01 00:00:00.000000'), (8, NULL, 'default1', '2023-01-01 01:00:00.000000'), (9, 6, 'default2', '2023-01-01 01:00:00.000000'), (10, 2, 'default2', '2023-01-01 01:00:00.000000'), (11, 1, 'default1', NULL), (12, 4, 'default1', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id GROUP BY T2.DisplayName ORDER BY COUNT(T1.Id) DESC, T2.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT u.DisplayName FROM users AS u JOIN (SELECT UserId, COUNT(Id) AS badge_count FROM badges GROUP BY UserId ORDER BY badge_count DESC, UserId NULLS LAST LIMIT 1) AS b ON u.Id = b.UserId;

/*
Prediction Result:
('default1',)
*/