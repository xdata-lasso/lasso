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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (199, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 'default1', NULL, 0, 199, NULL, 0, 1, 'default1'), (200, 201, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, NULL, NULL, 199, 201, 1, 199, NULL, 'default1'), (1, 201, NULL, 'default1', NULL, 'default1', 'default1', NULL, 201, 200, 0, 1, NULL, 'default2'), (0, 201, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', NULL, 'default2', 'default1', 201, 200, 1, 200, 201, 'default2'), (201, 200, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, 'default1', NULL, 0, NULL, 201, 1, 200, 'default2'), (2, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 'default2', NULL, 'default1', 200, 201, 1, 0, NULL, 'default2'), (3, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default1', 'default2', NULL, 200, 1, 200, 201, 1, 'default2'), (4, 199, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', 'default1', NULL, NULL, 199, 1, 200, 1, 'default1'), (5, NULL, NULL, 'default2', NULL, NULL, NULL, NULL, 200, 1, 199, 0, 199, 'default1'), (6, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default2', NULL, 201, 1, 201, 0, 201, NULL), (7, 0, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'default1', 'default1', NULL, 1, NULL, 201, 0, 1, 'default1'), (8, NULL, NULL, NULL, NULL, 'default2', 'default2', 'default1', 1, 0, 200, 201, 1, 'default1'), (9, 201, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'default2', 'default1', NULL, 0, 201, NULL, 200, NULL), (10, 200, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default1', 'default2', 'default2', 1, 200, NULL, NULL, 199, 'default1'), (11, 200, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', 'default2', 'default1', 201, 199, 0, NULL, 199, NULL);
INSERT INTO badges (id, userid, name, date) VALUES (200, 7, 'default2', '2023-01-01 00:00:00.000000'), (0, 201, 'default2', NULL), (199, 1, NULL, NULL), (201, 11, NULL, '2023-01-01 00:00:00.000000'), (1, 8, 'default1', '2023-01-01 01:00:00.000000'), (2, 8, 'default1', '2023-01-01 00:00:00.000000'), (3, 5, 'default1', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T1.Id) AS REAL) / COUNT(DISTINCT T2.DisplayName) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.Views > 200;

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT AVG(badge_count) AS average_number_of_badges FROM (SELECT UserId, COUNT(Id) AS badge_count FROM badges WHERE UserId IN (SELECT Id FROM users WHERE Views > 200) GROUP BY UserId) AS user_badge_counts;

/*
Prediction Result:
(1.0,)
*/