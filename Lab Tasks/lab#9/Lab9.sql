create table users (
    user_id INT PRIMARY KEY,
    username VARCHAR(35) NOT NULL,
    password VARCHAR(35) NOT NULL,
    email VARCHAR(35) NOT NULL,
    salary INT NOT NULL

);


create table summary (
    id INT PRIMARY KEY,
    total_users INT NOT NULL,
    Yahoo INT NOT NULL,
    Hotmail INT NOT NULL,
    Gmail INT NOT NULL

);




users (user_id , username , password , email , salary)


create table summary ( id , total_users , Yahoo , Hotmail , Gmail)


---------------------------------------------------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE insert_into_summary (IN id INT, total_user INT, Yahoo INT, Hotmail INT, Gmail INT)
BEGIN
    INSERT INTO summary VALUES ( id , total_users , Yahoo , Hotmail , Gmail);
END$$
DELIMITER ;

call insert_into_summary(1 , 2  ,1 , 0 , 1);



---------------------------------------------------------------------------------------------------------



DELIMITER $$
CREATE PROCEDURE insert_into_user (IN user_id INT , username  VARCHAR(35), password  VARCHAR(35), email  VARCHAR(35) , salary INT)
BEGIN
    INSERT INTO users VALUES (user_id , username , password , email , salary);
END$$
DELIMITER ;


call insert_into_user(1 , 'abc123'  ,'def321' , 'abc123@yahoo.com' , 30000);

call insert_into_user(2 , 'xyz789'  ,'asd123' , 'xyz789@gmail.com' , 50000);


---------------------------------------------------------------------------------------------------------


DELIMITER $$
CREATE PROCEDURE row_count (out num INT )
BEGIN
    select count(*) from users;
END$$
DELIMITER ;


call row_count(@out);
-- select @out;

---------------------------------------------------------------------------------------------------------


DELIMITER $$
CREATE PROCEDURE average_sal (out avg_sal INT )
BEGIN
    select AVG(salary) from users;
END$$
DELIMITER ;


call average_sal(@out);


---------------------------------------------------------------------------------------------------------



DELIMITER $$
CREATE PROCEDURE minmax (out min_sal INT , max_sal INT )
BEGIN
    select min(salary) INTO min_sal from users; 
    select max(salary) INTO max_sal from users;
END$$
DELIMITER ;


call minmax(@min_sal , @max_sal);

select @min_sal , @max_sal;


--xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx--

DELIMITER $$
CREATE PROCEDURE minmax ()
BEGIN
    select min(salary) AS min_sal , max(salary) AS max_sal from users;
END$$
DELIMITER ;


call minmax();


---------------------------------------------------------------------------------------------------------


DELIMITER $$
CREATE TRIGGER inserting_user AFTER INSERT ON users
FOR EACH ROW BEGIN
    update summary
    set total_users = total_users + 1;
END $$

DELIMITER ;



DELIMITER $$
CREATE TRIGGER deleting_user AFTER DELETE ON users
FOR EACH ROW BEGIN
    update summary
    set total_users = total_users - 1;
END $$

DELIMITER ;





---------------------------------------------------------------------------------------------------------------------------



DELIMITER $$
CREATE PROCEDURE delete_from_user (IN user_id_from_ftn INT)
BEGIN
    DELETE FROM users WHERE user_id = user_id_from_ftn;
END$$
DELIMITER ;


---------------------------------------------------------------------------------------------------------------------------


call insert_into_user(3 , 'asdf1'  ,'def321' , 'asdf1@yahoo.com' , 10000);
call insert_into_user(4 , 'asdf2'  ,'def321' , 'asdf2@yahoo.com' , 20000);
call insert_into_user(5 , 'asdf3'  ,'def321' , 'asdf3@gmail.com' , 30000);
call insert_into_user(6 , 'asdf4'  ,'def321' , 'asdf4@gmail.com' , 40000);
call insert_into_user(7 , 'asdf5'  ,'def321' , 'asdf5@hotmail.com' , 50000);
call insert_into_user(8 , 'asdf6'  ,'def321' , 'asdf6@hotmail.com' , 60000);






call delete_from_user(3);
call delete_from_user(4);
call delete_from_user(5);
call delete_from_user(6);























