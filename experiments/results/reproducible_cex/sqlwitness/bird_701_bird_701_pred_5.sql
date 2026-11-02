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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (-1, 99, '2023-01-01 00:00:00.000000', NULL, NULL, NULL, 'default2', 'default1', -1, 101, 101, 1, 49, 'default2');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1, NULL, -1, 51, 2, '2023-01-01 00:00:00.000000', 99, 49, 'default1', NULL, NULL, NULL, NULL, 50, 99, '2023-01-01 00:00:00.000000', NULL, NULL, '2023-01-01 00:00:00.000000', NULL, 'default2'), (100, NULL, -1, 100, 50, '2023-01-01 00:00:00.000000', 0, -1, 'default1', '2023-01-01 01:00:00.000000', 'default1', NULL, 0, 49, 2, NULL, NULL, -1, '2023-01-01 01:00:00.000000', 'default1', 'default2'), (0, -1, -1, 49, 2, '2023-01-01 00:00:00.000000', 1, -1, NULL, '2023-01-01 01:00:00.000000', 'default1', 'default2', 0, 51, -1, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 101, '2023-01-01 01:00:00.000000', NULL, NULL), (-1, -1, -1, 100, 50, NULL, 50, 99, 'default1', '2023-01-01 01:00:00.000000', 'default1', NULL, 1, 101, 51, '2023-01-01 00:00:00.000000', NULL, -1, NULL, 'default1', 'default2'), (2, -1, NULL, 99, -1, '2023-01-01 01:00:00.000000', 2, 0, 'default1', NULL, 'default1', 'default1', NULL, -1, 100, NULL, '2023-01-01 01:00:00.000000', 0, '2023-01-01 00:00:00.000000', NULL, 'default2'), (50, -1, NULL, 2, 51, '2023-01-01 01:00:00.000000', 51, 101, 'default2', NULL, 'default2', NULL, 50, 99, 2, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 0, '2023-01-01 00:00:00.000000', NULL, 'default2'), (49, NULL, NULL, NULL, 2, '2023-01-01 00:00:00.000000', 50, 100, NULL, NULL, 'default1', 'default2', 2, 1, 49, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 51, '2023-01-01 01:00:00.000000', NULL, 'default1'), (51, NULL, -1, 2, 100, NULL, 100, 51, 'default2', '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, 49, 0, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, NULL), (99, -1, -1, 49, 50, '2023-01-01 01:00:00.000000', NULL, 2, NULL, '2023-01-01 00:00:00.000000', 'default1', 'default2', 1, 2, 2, NULL, NULL, 51, '2023-01-01 00:00:00.000000', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.Score >= 50 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN (SELECT MAX(Reputation) AS max_reputation FROM users) AS T3 ON T1.Reputation = T3.max_reputation;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN p.Score > 50 THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(*) AS Percentage FROM posts AS p JOIN users AS u ON p.OwnerUserId = u.Id WHERE u.Reputation = (SELECT MAX(Reputation) FROM users);

/*
Prediction Result:
(33.333333333333336,)
*/