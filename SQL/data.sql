use mydb;
CREATE TABLE users (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
age INT(6) NOT NULL,
email VARCHAR(50)) ;

INSERT INTO users (id, name, age, email)
VALUES ('1','John', '22', 'john@example.com');
