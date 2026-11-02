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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 19, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default1', NULL, 'default1', 2, 21, 1, 100, 6, 'default2'), (19, 1, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', NULL, 'default2', NULL, 2, 6, 101, 5, 4, NULL), (65, 6, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default1', 'default2', 'default2', 4, -1, 5, -1, 99, NULL), (66, 66, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default2', 'default1', NULL, 6, NULL, 65, 20, 20, 'default2'), (99, 65, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default2', 'default2', NULL, 101, 2, 6, -1, 66, NULL), (2, 0, NULL, NULL, '2023-01-01 01:00:00.000000', NULL, 'default2', 'default2', 1, 6, 66, NULL, 64, 'default2'), (21, 2, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', 'default2', 'default1', 19, 66, 100, 0, NULL, 'default2'), (64, 5, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', 100, 100, 1, 6, 65, NULL), (6, -1, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'default1', 'default2', 21, 5, 4, 2, 19, 'default1'), (0, 100, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default1', NULL, 'default2', 64, 2, NULL, 21, 5, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (2, 65, 2, 100, 99, '2023-01-01 01:00:00.000000', 5, 101, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default1', 101, 65, 5, NULL, '2023-01-01 00:00:00.000000', 1, '2023-01-01 01:00:00.000000', 'default2', 'default2'), (19, 65, 99, 101, 1, '2023-01-01 00:00:00.000000', 64, 19, NULL, NULL, 'default2', NULL, 65, 1, 100, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, 'default1', 'default2'), (0, 99, 65, 21, 4, '2023-01-01 00:00:00.000000', 1, 21, 'default2', NULL, 'default1', 'default2', 21, NULL, 2, '2023-01-01 00:00:00.000000', NULL, 99, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (100, 1, 64, 100, 100, '2023-01-01 00:00:00.000000', 6, 64, 'default1', '2023-01-01 00:00:00.000000', 'default2', 'default2', 65, NULL, 1, '2023-01-01 01:00:00.000000', NULL, 100, '2023-01-01 00:00:00.000000', NULL, 'default2'), (4, 66, 6, 5, -1, '2023-01-01 00:00:00.000000', 4, 4, 'default2', NULL, NULL, NULL, 2, -1, 1, NULL, '2023-01-01 01:00:00.000000', 66, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Age > 65, 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T1.Score > 20;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.Age > 65 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T1.Score > 5;

/*
Prediction Result:
(50.0,)
*/