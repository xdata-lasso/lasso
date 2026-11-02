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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (2, 1, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default2', NULL, 'default1', 2, 1, 1, 0, 2, 'default1'), (1, NULL, '2023-01-01 01:00:00.000000', NULL, NULL, 'default2', 'default2', 'default2', 0, 2, 0, 0, NULL, NULL), (0, NULL, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default1', 'default2', NULL, 2, 2, 0, 1, 2, 'default2'), (3, 2, '2023-01-01 00:00:00.000000', 'default1', NULL, NULL, NULL, 'default1', 1, 2, 2, 2, NULL, 'default1');
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (0, 3, 3, 1, 1, NULL, 2, 0, NULL, NULL, 'default1', NULL, 0, 0, 1, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', 'default1'), (1, 3, 3, 2, NULL, '2023-01-01 00:00:00.000000', 0, 0, NULL, '2023-01-01 00:00:00.000000', 'default1', NULL, 2, 1, 2, NULL, '2023-01-01 01:00:00.000000', 2, '2023-01-01 01:00:00.000000', 'default1', NULL), (2, 1, 1, 2, NULL, NULL, 1, 0, 'default2', '2023-01-01 00:00:00.000000', NULL, 'default1', NULL, 0, 2, '2023-01-01 01:00:00.000000', NULL, NULL, '2023-01-01 01:00:00.000000', NULL, 'default2');
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (2, 0, 0, 0, 'default1', NULL, 'default1'), (1, 1, 2, 0, 'default1', NULL, NULL), (0, NULL, 1, 2, 'default1', NULL, NULL), (3, 1, 3, NULL, NULL, NULL, 'default1'), (4, NULL, NULL, 0, NULL, '2023-01-01 01:00:00.000000', 'default1'), (5, NULL, 3, 1, 'default2', '2023-01-01 00:00:00.000000', 'default2'), (6, 1, 0, NULL, 'default1', '2023-01-01 00:00:00.000000', NULL), (7, NULL, 0, 2, NULL, '2023-01-01 00:00:00.000000', NULL), (8, 1, 2, 2, NULL, NULL, NULL), (9, 1, 3, 2, NULL, '2023-01-01 01:00:00.000000', 'default1'), (10, NULL, NULL, 2, 'default2', NULL, 'default2'), (11, 1, 1, 2, NULL, NULL, NULL), (12, 1, 2, 2, 'default2', '2023-01-01 00:00:00.000000', 'default1'), (13, NULL, 2, 1, 'default1', NULL, NULL), (14, 0, NULL, NULL, NULL, NULL, 'default1'), (15, 0, 3, 1, 'default1', '2023-01-01 01:00:00.000000', NULL), (16, 2, 2, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default2'), (17, 1, 0, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default1'), (18, 0, 3, 1, 'default1', '2023-01-01 01:00:00.000000', 'default1'), (19, NULL, 2, 0, 'default1', '2023-01-01 01:00:00.000000', 'default1'), (20, 2, NULL, 2, 'default2', '2023-01-01 00:00:00.000000', 'default2'), (21, 1, 2, 0, 'default1', NULL, 'default1'), (22, 1, 3, 2, 'default2', '2023-01-01 00:00:00.000000', NULL), (23, NULL, NULL, 1, NULL, '2023-01-01 00:00:00.000000', 'default1'), (24, NULL, 0, NULL, NULL, '2023-01-01 00:00:00.000000', 'default1'), (25, 0, 3, NULL, 'default2', '2023-01-01 00:00:00.000000', NULL), (26, 1, NULL, 0, 'default1', '2023-01-01 01:00:00.000000', NULL), (27, 0, NULL, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default1'), (28, 1, 1, 2, 'default1', '2023-01-01 00:00:00.000000', 'default2'), (29, 2, 0, 1, NULL, NULL, 'default2'), (30, 1, NULL, 2, 'default1', '2023-01-01 01:00:00.000000', 'default1'), (31, NULL, 0, 1, NULL, '2023-01-01 01:00:00.000000', NULL), (32, 1, NULL, 1, 'default2', '2023-01-01 01:00:00.000000', 'default1'), (33, 2, 1, 2, NULL, '2023-01-01 00:00:00.000000', 'default1'), (34, NULL, 2, 1, 'default1', '2023-01-01 01:00:00.000000', 'default2'), (35, 2, 2, 2, 'default2', NULL, 'default2'), (36, NULL, NULL, 2, 'default2', '2023-01-01 00:00:00.000000', 'default2'), (37, 1, NULL, 1, NULL, '2023-01-01 00:00:00.000000', 'default2'), (38, NULL, 1, 1, NULL, NULL, NULL), (39, 0, 3, NULL, NULL, '2023-01-01 00:00:00.000000', 'default1'), (40, 0, 1, 2, 'default2', '2023-01-01 01:00:00.000000', 'default1'), (41, 1, 0, 2, 'default2', '2023-01-01 00:00:00.000000', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Title FROM posts WHERE Id = (SELECT PostId FROM comments ORDER BY Score DESC, comments.id NULLS LAST LIMIT 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT posts.Title FROM comments INNER JOIN posts ON comments.PostId = posts.Id ORDER BY comments.Score DESC, comments.id NULLS LAST, posts.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/