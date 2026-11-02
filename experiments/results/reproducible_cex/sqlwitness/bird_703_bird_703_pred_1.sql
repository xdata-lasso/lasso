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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (20, 14, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'default2', 'default1', 'default2', 20, 19, 21, 20, NULL, NULL), (15, NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default1', 'default1', 'default1', NULL, 21, NULL, 1, 14, 'default2'), (19, 14, NULL, 'default1', NULL, 'default2', NULL, 'default2', 16, 0, 19, NULL, NULL, 'default1'), (0, 15, NULL, 'default1', '2023-01-01 01:00:00.000000', NULL, 'default2', 'default2', 14, 15, 15, NULL, 1, 'default2'), (21, 16, NULL, NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 'default2', NULL, NULL, 20, 16, 19, 'default2'), (14, NULL, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', NULL, 'default2', 15, 14, 21, 0, 21, NULL), (16, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, NULL, 'default1', 'default1', 19, 15, 19, 16, 14, 'default1'), (1, 20, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default2', 'default2', NULL, 1, 0, 16, 19, 15, 'default2'), (2, 19, '2023-01-01 00:00:00.000000', 'default1', NULL, 'default2', NULL, NULL, 16, 0, 15, NULL, 14, NULL), (3, 1, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default1', 'default1', NULL, 14, 19, 16, 14, 1, NULL), (4, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 'default1', 16, 1, 21, 21, 1, NULL), (5, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', 'default1', NULL, 15, 1, 15, 1, 19, 'default2');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (15, 20, NULL, 21, 0, '2023-01-01 01:00:00.000000', 21, NULL, NULL, '2023-01-01 01:00:00.000000', 'default1', NULL, 14, NULL, 21, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 20, NULL, NULL, 'default2'), (14, 16, 14, 21, 15, NULL, NULL, 15, NULL, '2023-01-01 01:00:00.000000', NULL, 'default2', 1, 16, 16, '2023-01-01 01:00:00.000000', '2023-01-01 01:00:00.000000', 19, NULL, 'default1', 'default2'), (0, 0, NULL, 19, 1, NULL, 16, 14, 'default1', '2023-01-01 01:00:00.000000', 'default1', 'default1', NULL, 15, NULL, '2023-01-01 01:00:00.000000', NULL, 21, NULL, NULL, 'default1'), (20, 19, 2, 15, 19, '2023-01-01 00:00:00.000000', 16, 20, NULL, '2023-01-01 01:00:00.000000', NULL, 'default2', 21, 0, 19, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 21, '2023-01-01 01:00:00.000000', 'default1', 'default1'), (19, 15, NULL, 1, 1, '2023-01-01 01:00:00.000000', 0, 19, 'default1', NULL, 'default1', NULL, 1, NULL, 16, NULL, '2023-01-01 00:00:00.000000', 0, '2023-01-01 00:00:00.000000', NULL, NULL);
INSERT INTO tags (id, excerptpostid, tagname, count, wikipostid) VALUES (0, 20, 'default2', 20, 19), (15, 19, 'default2', 21, 15), (16, NULL, NULL, 14, 0), (1, 0, 'default1', 14, 16), (21, 15, 'default2', NULL, 14), (19, NULL, NULL, 0, 21), (14, 14, 'default2', 20, 20), (20, 20, NULL, 0, 1), (2, 15, 'default2', 0, 16), (3, 0, NULL, 19, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(id) FROM tags WHERE Count <= 20 AND Id < 15;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(Id) FROM tags WHERE Id < 15 AND Count < 20;

/*
Prediction Result:
(3,)
*/