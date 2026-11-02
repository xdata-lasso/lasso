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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (-1, 1001, NULL, '2011', '2011-10-27 00:00:00.000000', '%Y', '%Y', NULL, 1001, 2, 100, 101, -1, '%Y'), (1, -1, '2011-10-27 00:00:00.000000', 'default2', NULL, '2011', 'default1', 'default2', 1001, 99, 100, 999, 101, NULL), (2, 0, '2011-10-27 00:00:00.000000', '%Y', NULL, 'default1', '%Y', 'default2', 2, 100, 101, 0, 1000, '2011'), (0, 100, NULL, '2011', NULL, NULL, 'default1', NULL, 1, -1, 999, 1, 1, 'default2');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (1000, NULL, -1, -1, 1000, '2023-01-01 00:00:00.000000', 1000, 101, '2011', '2011-10-27 00:00:00.000000', '%Y', 'default2', NULL, 101, 2, NULL, '2023-01-01 01:00:00.000000', 99, '2023-01-01 00:00:00.000000', 'default1', 'default1'), (101, -1, 2, 999, -1, NULL, 101, 0, '2011', '2011-10-27 00:00:00.000000', NULL, NULL, 99, -1, 1001, '2023-01-01 01:00:00.000000', '2011-10-27 00:00:00.000000', -1, '2011-10-27 00:00:00.000000', 'default1', 'default2'), (-1, NULL, NULL, 1000, 1, '2011-10-27 00:00:00.000000', 100, 999, 'default2', '2011-10-27 00:00:00.000000', 'default2', '%Y', 101, 1000, NULL, '2023-01-01 00:00:00.000000', '2011-10-27 00:00:00.000000', -1, '2023-01-01 00:00:00.000000', NULL, 'default2'), (100, -1, 0, 99, 1, '2023-01-01 01:00:00.000000', 2, 1, '%Y', '2023-01-01 00:00:00.000000', '2011', 'default2', 0, NULL, 100, '2023-01-01 01:00:00.000000', NULL, 1001, '2023-01-01 00:00:00.000000', '2011', 'default1'), (2, -1, -1, 1000, NULL, NULL, 2, 1, '%Y', NULL, '2011', 'default1', 99, 99, 0, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 100, '2023-01-01 00:00:00.000000', 'default2', '2011'), (99, 0, 1, -1, 999, '2023-01-01 00:00:00.000000', 2, 101, 'default2', '2023-01-01 00:00:00.000000', '2011', 'default1', 1000, 2, 2, '2011-10-27 00:00:00.000000', '2023-01-01 01:00:00.000000', 101, NULL, 'default2', 'default2'), (0, -1, NULL, -1, 99, NULL, NULL, 101, '2011', '2023-01-01 01:00:00.000000', '2011', 'default2', 99, 999, 100, NULL, '2023-01-01 00:00:00.000000', 1000, '2023-01-01 00:00:00.000000', 'default2', '%Y'), (1, -1, 0, 1, 1001, '2011-10-27 00:00:00.000000', 1000, 2, '2011', '2011-10-27 00:00:00.000000', '%Y', NULL, 1, -1, 2, '2011-10-27 00:00:00.000000', '2023-01-01 00:00:00.000000', 100, '2011-10-27 00:00:00.000000', 'default1', NULL), (999, -1, 2, 2, 1000, NULL, -1, 1, 'default2', '2023-01-01 01:00:00.000000', NULL, NULL, -1, 1, 99, '2011-10-27 00:00:00.000000', '2011-10-27 00:00:00.000000', 2, '2023-01-01 00:00:00.000000', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(STRFTIME('%Y', T2.CreaionDate) = '2011' AND T1.Reputation > 1000, 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN users.reputation > 1000 THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(posts.id) AS percentage FROM posts INNER JOIN users ON posts.owneruserid = users.id;

/*
Prediction Result:
(28.571428571428573,)
*/