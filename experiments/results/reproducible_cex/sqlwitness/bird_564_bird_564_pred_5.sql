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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (107829, 2, '2023-01-01 00:00:00.000000', 'default1', NULL, NULL, NULL, 'default2', 107829, 0, 1, 1, 2, 'default1'), (2, 1, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', NULL, 'default2', 1, 107828, 1, NULL, 2, 'default1'), (107828, 0, NULL, 'default1', NULL, 'default2', 'default2', 'default2', 107828, 107829, 1, NULL, NULL, 'default2'), (107830, NULL, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', NULL, NULL, 'default1', 107829, 107828, 1, 107830, 2, 'default2'), (0, 107828, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default1', NULL, NULL, 107828, 107829, 1, 107828, 107829, 'default1'), (1, 0, '2023-01-01 01:00:00.000000', NULL, NULL, 'default1', NULL, NULL, 107829, 107828, 1, 1, 107828, NULL), (3, 0, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', NULL, NULL, 'default1', 107828, 1, 1, 107828, 107829, 'default2'), (4, NULL, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', NULL, 'default2', 'default2', 107829, 107828, 107828, 107830, 0, 'default1'), (5, 1, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default1', 'default1', 'default1', 107830, 0, 107830, 107830, NULL, NULL);
INSERT INTO posts (id, lasteditoruserid, owneruserid, posttypeid, acceptedanswerid, creaiondate, score, viewcount, body, lasactivitydate, title, tags, answercount, commentcount, favoritecount, lasteditdate, communityowneddate, parentid, closeddate, ownerdisplayname, lasteditordisplayname) VALUES (2, 2, 107828, 107829, 107829, NULL, 107829, NULL, 'default2', NULL, NULL, NULL, 107829, NULL, 2, NULL, '2023-01-01 01:00:00.000000', 107829, '2023-01-01 01:00:00.000000', 'default1', NULL), (107829, 2, 107829, 1, 1, '2023-01-01 01:00:00.000000', 0, 107830, 'default2', '2023-01-01 01:00:00.000000', NULL, NULL, 107830, 0, 1, NULL, '2023-01-01 01:00:00.000000', 2, '2023-01-01 00:00:00.000000', 'default2', 'default1'), (107830, NULL, 4, 2, 0, NULL, NULL, 107830, 'default1', NULL, 'default1', 'default1', 0, 1, 107829, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', 107828, '2023-01-01 00:00:00.000000', NULL, 'default1'), (107828, NULL, 1, NULL, 1, '2023-01-01 00:00:00.000000', NULL, 2, NULL, '2023-01-01 00:00:00.000000', 'default2', 'default2', 107829, 107830, 107828, '2023-01-01 00:00:00.000000', NULL, 107828, NULL, 'default1', 'default2'), (0, 2, 2, 107828, 0, NULL, 2, 2, 'default2', NULL, 'default2', 'default2', 107829, 1, 0, '2023-01-01 00:00:00.000000', '2023-01-01 01:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default2', 'default1'), (1, 107830, 107828, 0, 107829, NULL, 107828, 107830, 'default2', NULL, NULL, NULL, 0, 2, 1, '2023-01-01 01:00:00.000000', '2023-01-01 00:00:00.000000', 107829, '2023-01-01 01:00:00.000000', 'default2', 'default2');
INSERT INTO comments (id, postid, userid, score, text, creationdate, userdisplayname) VALUES (107828, 0, 0, 1, NULL, '2023-01-01 00:00:00.000000', NULL), (107829, 1, 0, 2, NULL, NULL, 'default1'), (107830, 107828, 0, 107830, 'default1', '2023-01-01 01:00:00.000000', NULL), (2, 107828, 2, 107830, NULL, '2023-01-01 00:00:00.000000', 'default2'), (1, 1, 107829, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default2'), (0, 1, 107830, 2, NULL, '2023-01-01 01:00:00.000000', 'default2'), (3, 1, 4, 107830, 'default2', NULL, 'default1'), (4, NULL, 1, 1, 'default1', '2023-01-01 00:00:00.000000', 'default1'), (5, 2, 2, 1, 'default1', '2023-01-01 01:00:00.000000', 'default2'), (6, 107829, 107830, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default2'), (7, 107828, 0, 2, 'default2', '2023-01-01 01:00:00.000000', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Text FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId WHERE T1.ParentId = 107829 AND T1.CommentCount = 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT comments.Text FROM posts JOIN comments ON posts.Id = comments.PostId WHERE posts.ParentId = 107829 GROUP BY comments.PostId HAVING COUNT(comments.Id) = 1;

/*
Prediction Result:
('default1',)
*/