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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (2, 999, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default1', 'default1', 'default2', 1001, 999, 1001, 999, 1000, NULL), (1001, 0, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 1, 1000, 1, 1, 2, 'default2'), (1000, 999, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default1', 'default1', 'default2', 999, 1001, 2, 2, 1001, 'default1'), (1, 0, '2023-01-01 01:00:00.000000', 'default1', NULL, NULL, NULL, NULL, 1001, 0, 1000, 0, 1000, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 1001, NULL, 1000, NULL, '2023-01-01 01:00:00.000000', 1001, 1000, NULL, '2023-01-01 00:00:00.000000', NULL, 'default1', 2, 999, 999, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 2, '2023-01-01 00:00:00.000000', 'default2', 'default1'), (2, 1001, NULL, 1000, 2, '2023-01-01 00:00:00.000000', 1000, 1000, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 1, 1000, 1, NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', 'default1'), (1, 1000, 1001, NULL, NULL, '2023-01-01 01:00:00.000000', NULL, 1, 'default1', NULL, 'default2', 'default1', 999, 0, 2, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 1001, '2023-01-01 00:00:00.000000', NULL, 'default2'), (1000, 1000, 2, 1, 1, '2023-01-01 00:00:00.000000', 1, 0, NULL, '2023-01-01 01:00:00.000000', 'default2', 'default2', 999, 1001, 1001, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 1001, '2023-01-01 01:00:00.000000', NULL, 'default2');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, 2, 1000, 0, NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 'default1'), (1001, 1000, 1, 1, NULL, NULL, NULL, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.UserId FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T3.ViewCount >= 1000 GROUP BY T2.UserId HAVING COUNT(DISTINCT T2.PostHistoryTypeId) = 1;

/*
Gold Result:
(1000,)
*/

-- Prediction Query
SELECT DISTINCT posthistory.userid FROM posthistory INNER JOIN users ON posthistory.userid = users.id WHERE users.views >= 1000 GROUP BY posthistory.userid, posthistory.postid HAVING COUNT(*) = 1;

/*
Prediction Result:
(1,)
*/