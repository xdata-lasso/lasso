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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 9, NULL, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 'default1', 10, 9, -1, -1, 2, 'default1'), (4, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 6, NULL, NULL, 1, 9, 'default1'), (0, 5, NULL, NULL, NULL, 'default1', 'default1', 'default1', 11, 9, -1, 0, 4, NULL), (-1, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', 'default1', 'default1', -1, 0, 10, 1, 4, 'default1'), (2, 0, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default2', 'default1', NULL, 4, -1, 4, 10, 'default1'), (10, 9, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, 'default1', NULL, 5, 4, 1, 10, 9, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (4, -1, -1, 5, NULL, '2023-01-01 01:00:00.000000', 11, 6, 'default1', '2023-01-01 01:00:00.000000', NULL, 'default2', 11, 6, 1, NULL, '2023-01-01 01:00:00.000000', 9, '2023-01-01 01:00:00.000000', 'default2', 'default1'), (2, NULL, 10, 5, 10, '2023-01-01 01:00:00.000000', 6, 1, NULL, '2023-01-01 00:00:00.000000', 'default1', NULL, 0, -1, 2, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 6, NULL, 'default1', 'default2'), (9, NULL, NULL, 9, 9, '2023-01-01 00:00:00.000000', -1, 4, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 5, 2, 10, '2023-01-01 00:00:00.000000', NULL, 11, '2023-01-01 00:00:00.000000', 'default1', NULL), (11, -1, 2, 6, 2, '2023-01-01 00:00:00.000000', 4, -1, 'default1', '2023-01-01 01:00:00.000000', NULL, NULL, 5, 2, 4, NULL, NULL, 11, '2023-01-01 00:00:00.000000', NULL, 'default2'), (0, 4, 4, 5, 2, '2023-01-01 00:00:00.000000', -1, 0, 'default1', NULL, 'default1', 'default2', 0, 1, NULL, '2023-01-01 00:00:00.000000', NULL, 4, '2023-01-01 01:00:00.000000', 'default1', 'default1');
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (0, 11, 4, NULL, 'default2', NULL, 'default2'), (1, 2, 1, 0, 'default2', '2023-01-01 00:00:00.000000', 'default2'), (-1, 0, -1, 4, 'default1', '2023-01-01 01:00:00.000000', NULL), (2, 11, -1, 5, 'default1', '2023-01-01 00:00:00.000000', 'default1'), (11, 11, NULL, 0, 'default1', NULL, NULL), (10, 0, -1, -1, NULL, '2023-01-01 00:00:00.000000', 'default2'), (9, 4, 4, -1, 'default1', '2023-01-01 00:00:00.000000', NULL), (5, 0, 10, 0, NULL, '2023-01-01 00:00:00.000000', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T1.UpVotes = 0, 1, 0)) AS REAL) / COUNT(T1.Id) AS per FROM users AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.UserId WHERE T2.Score BETWEEN 5 AND 10;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT (CAST(COUNT(DISTINCT c.UserId) AS REAL) * 100.0 / CAST((SELECT COUNT(DISTINCT UserId) FROM comments WHERE Score BETWEEN 5 AND 10) AS REAL)) AS percentage FROM comments AS c JOIN users AS u ON c.UserId = u.Id WHERE c.Score BETWEEN 5 AND 10 AND u.UpVotes = 0;

/*
Prediction Result:
(100.0,)
*/