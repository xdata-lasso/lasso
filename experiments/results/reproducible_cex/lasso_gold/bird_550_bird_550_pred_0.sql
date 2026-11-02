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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3295, 3299, '1970-10-08', 'Steve Wright', '1974-03-12', 'http://cross.biz/', '67998 Jeffrey Highway
Hernandezmouth, CO 62872', 'decision', 3303, 3307, 3311, 3315, 3319, 'http://www.brown.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3296, 3304.0, '1970-10-09', 'Eric Duncan', '1974-03-13', 'http://www.bailey-montoya.biz/', '641 Shaw Trail
Port Dennis, OH 26467', 'reveal', 3322.0, 3328.0, 3334.0, 3340.0, 3346.0, 'http://brock.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3297, 3309.0, '1970-10-10', 'Claudia Jones', '1974-03-14', 'http://www.delgado.biz/', '983 Charles Trail
Morrisshire, CO 15250', 'hour', 3341.0, 3349.0, 3357.0, 3365.0, 3373.0, 'http://www.payne.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3298, 3314.0, '1970-10-11', 'John Freeman', '1974-03-15', 'http://williams.net/', '5355 Kayla Extension Suite 979
South Brady, GU 31104', 'clearly', 3360.0, 3370.0, 3380.0, 3390.0, 3400.0, 'https://www.hale.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3342, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, 3326, 3330, '1978-07-16', 3334, 3338, 'animal', 3342, '1982-11-20', 'Herpetologist', 'argue', 3346, 3350, 3354, 3295, '1986-04-01', '1990-08-05', 3358, '1994-01-09', 'James Nelson', 'Ethan Delacruz');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3323, 3331.0, 3337.0, '1978-07-17', 3345.0, 3351.0, 'especially', 3342, '1982-11-21', 'Engineer, control and instrumentation', 'make', 3371.0, 3377.0, 3383.0, 3295, '1986-04-02', '1990-08-06', 3395.0, '1994-01-10', 'Mary Lin', 'Charlotte Mason');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3324, 3336.0, 3344.0, '1978-07-18', 3356.0, 3364.0, 'conference', 3342, '1982-11-22', 'Waste management officer', 'real', 3396.0, 3404.0, 3412.0, 3295, '1986-04-03', '1990-08-07', 3432.0, '1994-01-11', 'Sean Banks', 'Timothy Smith');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3325, 3341.0, 3351.0, '1978-07-19', 3367.0, 3377.0, 'as', 3342, '1982-11-23', 'Geoscientist', 'you', 3421.0, 3431.0, 3441.0, 3295, '1986-04-04', '1990-08-08', 3469.0, '1994-01-12', 'James Bray', 'Joseph Cook');
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (3362, 'Christopher Reed', 3366, 0, 3370);
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (3363, 'Mario Young', 3373.0, 0, 3381.0);
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (3364, 'Kathryn Cain', 3380.0, 0, 3392.0);
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (3365, 'Sherry Zamora', 3387.0, 0, 3403.0);
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (3374, 'Christopher Reed', 3437, NULL, 3370);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Body FROM posts WHERE id = (SELECT ExcerptPostId FROM tags ORDER BY Count DESC, tags.id NULLS LAST LIMIT 1);

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Body FROM tags AS T1 INNER JOIN posts AS T2 ON T1.ExcerptPostId = T2.Id ORDER BY T1.Count DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('animal',)
*/