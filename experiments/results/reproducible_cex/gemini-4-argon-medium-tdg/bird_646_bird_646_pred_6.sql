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
-- DATASET 1
-- Tests standard join mutant (T1.Id = T2.PostId vs T2.PostId = T2.Id), WHERE boundary conditions (60, 61, NULL), and column swapping (OwnerDisplayName vs UserDisplayName, Text/Body vs Title, T2.Score vs T1.Score).
INSERT INTO users (Id, DisplayName) VALUES (1, 'UserTableDisplay');
INSERT INTO posts (Id, Score, Title, Body, OwnerDisplayName, OwnerUserId) VALUES (1, 61, 'Title_61_Id1', 'Body_1', 'Owner_1', 1);
INSERT INTO posts (Id, Score, Title, Body, OwnerDisplayName, OwnerUserId) VALUES (2, 60, 'Title_60_Boundary', 'Body_2', 'Owner_2', 1);
INSERT INTO posts (Id, Score, Title, Body, OwnerDisplayName, OwnerUserId) VALUES (3, 100, 'Title_100_NoComment', 'Body_3', 'Owner_3', 1);
INSERT INTO posts (Id, Score, Title, Body, OwnerDisplayName, OwnerUserId) VALUES (4, NULL, 'Title_NullScore', 'Body_4', 'Owner_4', 1);
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName, UserId) VALUES (1, 1, 10, 'Comment_SelfMatch_Id1', 'CommentUser_1', 1);
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName, UserId) VALUES (2, 1, 70, 'Comment_StandardJoinOnly', 'CommentUser_2', 1);
INSERT INTO comments (Id, PostId, Score, Text, UserDisplayName, UserId) VALUES (3, NULL, 80, 'Comment_NullPostId', 'CommentUser_3', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Title, T2.UserDisplayName FROM posts AS T1 INNER JOIN comments AS T2 ON T2.PostId = T2.Id WHERE T1.Score > 60;

/*
Gold Result:
('Title_61_Id1', 'CommentUser_1')
('Title_100_NoComment', 'CommentUser_1')
*/

-- Prediction Query
SELECT T2.Title, T1.UserDisplayName FROM comments AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T1.Score > 60;

/*
Prediction Result:
('Title_61_Id1', 'CommentUser_2')
*/