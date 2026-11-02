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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, NULL, 'Mornington', 'default2', 0, -1, NULL, NULL, 0, NULL), (0, 0, NULL, 'Mornington', '2023-01-01 01:00:00.000000', 'Mornington', 'default2', 'Amos', NULL, -1, -1, -1, NULL, NULL), (-1, -1, '2023-01-01 00:00:00.000000', 'default1', NULL, 'Mornington', 'default2', 'default2', NULL, -1, 0, NULL, 1, NULL), (2, -1, NULL, 'default1', NULL, 'Mornington', 'default1', 'Amos', 0, 0, 1, NULL, -1, 'Mornington'), (3, NULL, '2023-01-01 00:00:00.000000', 'Amos', NULL, 'Mornington', NULL, 'Mornington', 1, NULL, 0, -1, 0, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 3, 3, 1, NULL, '2023-01-01 00:00:00.000000', -1, 0, NULL, NULL, NULL, NULL, 0, -1, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', 'Mornington', 'default1'), (-1, 2, NULL, 0, NULL, NULL, 0, 1, 'default1', '2023-01-01 01:00:00.000000', 'default2', 'default2', -1, 1, NULL, NULL, NULL, NULL, NULL, 'default1', 'default1'), (1, 2, NULL, 0, NULL, '2023-01-01 00:00:00.000000', 1, NULL, 'Mornington', NULL, 'default2', 'default2', 0, -1, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', NULL, NULL, NULL, NULL), (2, -1, NULL, 1, NULL, '2023-01-01 00:00:00.000000', 1, -1, 'default1', '2023-01-01 00:00:00.000000', 'Mornington', 'default1', 0, NULL, -1, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 0, '2023-01-01 01:00:00.000000', NULL, 'Mornington'), (3, 1, 2, 1, NULL, NULL, NULL, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default1', 'default1', 1, -1, 1, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 1, '2023-01-01 00:00:00.000000', 'Amos', 'Amos'), (4, 0, 3, -1, 0, NULL, -1, 1, NULL, '2023-01-01 01:00:00.000000', 'Amos', 'Amos', 0, -1, 1, NULL, '2023-01-01 00:00:00.000000', 0, '2023-01-01 01:00:00.000000', NULL, NULL), (5, 1, 3, 1, 0, '2023-01-01 00:00:00.000000', -1, NULL, NULL, NULL, NULL, 'Mornington', 1, 0, 0, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', 'default2'), (6, 1, 1, 0, 0, NULL, 1, -1, 'Amos', '2023-01-01 01:00:00.000000', 'default1', 'Mornington', -1, NULL, NULL, '2023-01-01 00:00:00.000000', '2023-01-01 00:00:00.000000', 0, NULL, 'Amos', NULL), (7, NULL, 2, NULL, -1, '2023-01-01 01:00:00.000000', 0, NULL, 'Amos', '2023-01-01 00:00:00.000000', 'default1', 'default2', -1, NULL, 0, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 1, '2023-01-01 01:00:00.000000', 'Amos', 'Amos');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, 1, 2, 0, 'Mornington', NULL, 'default2', 'Mornington', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(T1.DisplayName = 'Mornington', T3.ViewCount, 0)) - SUM(IIF(T1.DisplayName = 'Amos', T3.ViewCount, 0)) AS diff FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T3.Id = T2.PostId;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT (SUM(CASE WHEN users.DisplayName = 'Mornington' THEN posts.ViewCount ELSE 0 END) - SUM(CASE WHEN users.DisplayName = 'Amos' THEN posts.ViewCount ELSE 0 END)) AS ViewCountDifference FROM posts INNER JOIN users ON posts.OwnerUserId = users.Id;

/*
Prediction Result:
(-1,)
*/