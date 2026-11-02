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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (2, 11, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'default2', NULL, 4, 9, 11, 1, 0, NULL), (9, 11, '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 'default1', NULL, NULL, 10, -1, 0, 6, NULL), (1, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 'default1', 'default2', NULL, 11, 0, 4, 9, 'default2'), (10, 5, NULL, 'default2', '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 5, 6, 1, 10, 6, NULL), (4, 5, '2023-01-01 01:00:00.000000', 'default1', NULL, NULL, 'default2', 'default2', 6, 0, 1, 5, 5, 'default2'), (0, 6, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, 'default1', NULL, 10, 0, 0, 10, 0, 'default1');
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (-1, NULL, NULL, 5, 'default2', '2023-01-01 00:00:00.000000', NULL), (0, NULL, 10, 5, 'default2', '2023-01-01 00:00:00.000000', NULL), (4, NULL, 1, 9, 'default2', '2023-01-01 00:00:00.000000', NULL), (6, NULL, 2, -1, NULL, '2023-01-01 01:00:00.000000', 'default2'), (1, NULL, 0, 5, 'default2', '2023-01-01 00:00:00.000000', 'default1'), (2, NULL, 9, 0, 'default2', '2023-01-01 00:00:00.000000', 'default1'), (10, NULL, 2, -1, 'default2', '2023-01-01 01:00:00.000000', 'default2'), (9, NULL, 4, 1, NULL, '2023-01-01 01:00:00.000000', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.UpVotes = 0, 1, 0)) AS REAL) / COUNT(T1.Id) AS per FROM users AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.UserId WHERE T2.Score BETWEEN 5 AND 10;

/*
Gold Result:
(0.3333333333333333,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN users.UpVotes = 0 THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(users.Id) AS Percentage FROM comments INNER JOIN users ON comments.UserId = users.Id WHERE comments.Score BETWEEN 5 AND 10;

/*
Prediction Result:
(33.333333333333336,)
*/