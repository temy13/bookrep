CREATE database bookrep_twitter;
create table bookrep_twitter.favorite(id SERIAL, twitter_id bigint, twitter_id_str varchar(32), created_at datetime, twitter_uid bigint);
