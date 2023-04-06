create table employees (
    emp_num numeric(4) not null primary key,
    birth_date date not null,
    first_name varchar(14),
    last_name varchar(16),
    sex enum('M', 'F'),
    hire_date date
);

create table departments(
    dept_num char(4) not null primary key,
    dept_name varchar(40)
);

create table dept_manager(
    dept_num char(4),
    emp_num numeric,    
    from_date date,
    to_date date,    
    index(emp_num),
    index(dept_num),
    constraint pk_dept_manager primary key (emp_num , dept_num),
    constraint fk_dept_manager_emp foreign key(emp_num) references employees(emp_num),
    constraint fk_dept_manager_dpt foreign key(dept_num) references departments(dept_num)    
);

create table dept_emp(
    dept_num char(4),
    emp_num numeric,    
    from_date date,
    to_date date,    
    index(emp_num),
    index(dept_num),
    constraint pk_dept_emp primary key (emp_num , dept_num),
    constraint fk_dept_emp_emp foreign key(emp_num) references employees(emp_num),
    constraint fk_dept_emp_dpt foreign key(dept_num) references departments(dept_num)    
);



create table titles(
    emp_num numeric,
    title varchar(50),
    from_date date,
    to_date date,
    index(emp_num),
    constraint pk_titles primary key (emp_num , title),
    constraint fk_titles_emp foreign key(emp_num) references employees(emp_num)
);

create table salaries(
    emp_num numeric,
    salary numeric,
    from_date date,
    to_date date,
    index(emp_num),
    index(from_date),
    index(to_date),
    constraint pk_salaries primary key (emp_num , from_date , to_date),
    constraint fk_salaries_emp foreign key(emp_num) references employees(emp_num)
);






