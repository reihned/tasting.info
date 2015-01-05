CREATE DATABASE tastings;
CREATE TABLE wines ( w_id serial primary key, name varchar(100), maker varchar(100), year int, img_url text, description text, snippet varchar 140, tags text );
CREATE TABLE makers ( m_id serial primary key, name varchar(100), region varchar(250), website_url text, img_url text, about text );
CREATE TABLE reviews ( r_id serial primary key, w_id int, date_posted date, review text );
CREATE TABLE tags ( t_id serial primary key, tag varchar(50) );
