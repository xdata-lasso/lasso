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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (3720, 3719, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', NULL, 'default1', 'default1', 3720, 3721, 3720, 3720, NULL, 'default1'), (1, 3721, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', NULL, 'default2', 'default2', 3721, 3719, 3720, 3719, 3719, 'default2'), (3719, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, NULL, NULL, 'default2', 3719, 3721, 1, 3719, 3721, 'default1'), (0, 3720, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default2', NULL, 'default2', 3719, 0, 3719, 3719, NULL, 'default1'), (3721, 3720, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', 'default1', 0, 1, 0, 3719, NULL, NULL), (2, 1, '2023-01-01 00:00:00.000000', 'default2', NULL, NULL, NULL, NULL, 0, 0, 1, 3720, 3720, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (3719, 3720, 2, 3721, NULL, '2023-01-01 00:00:00.000000', 3720, 3719, 'default1', '2023-01-01 00:00:00.000000', 'default1', NULL, 1, 0, 3721, NULL, '2023-01-01 00:00:00.000000', 1, '2023-01-01 01:00:00.000000', NULL, 'default1'), (3720, 0, 3720, 1, NULL, NULL, 0, 0, NULL, NULL, 'default1', 'default1', 3720, 1, NULL, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 3721, NULL, NULL, 'default1');
INSERT INTO posthistory (id, postid, userid, posthistorytypeid, revisionguid, creationdate, text, comment, userdisplayname) VALUES (0, NULL, 3721, NULL, 'default1', NULL, 'default1', NULL, 'default1'), (1, 3719, NULL, 3720, 'default1', NULL, 'default2', NULL, 'default2'), (3720, 3720, 3721, 3719, 'default2', NULL, 'default1', 'default1', NULL);
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (3721, 3719, 3719, 0, 'default1', '2023-01-01 01:00:00.000000', 'default2'), (1, 3719, 1, 3719, 'default2', '2023-01-01 01:00:00.000000', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostHistoryTypeId, (SELECT COUNT(DISTINCT UserId) FROM comments WHERE PostId = 3720) AS NumberOfUsers FROM postHistory AS T1 WHERE T1.PostId = 3720;

/*
Gold Result:
(3719, 0)
*/

-- Prediction Query
SELECT ph.PostHistoryTypeId, COUNT(DISTINCT c.UserId) AS CommentCount FROM postHistory AS ph INNER JOIN comments AS c ON ph.PostId = c.PostId WHERE ph.PostId = 3720 GROUP BY ph.PostHistoryTypeId;

/*
Prediction Result:
*/