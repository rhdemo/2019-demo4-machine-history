create table machine_record(id int not null primary key, name varchar not null);

create table maintenance_record(id serial not null primary key, 
    machine_id int not null references machine_record, 
    date date not null, repair int not null, 
    mechanic varchar not null);

create table damage_record(id serial not null primary key, 
    machine_id int not null references machine_record, 
    date date not null, 
    damage int not null);