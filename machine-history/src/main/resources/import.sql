insert into machineRecord (id, name) values (1, 'Machine 1');
insert into machineRecord (id, name) values (2, 'Machine 2');
insert into machineRecord (id, name) values (3, 'Machine 3');
insert into machineRecord (id, name) values (4, 'Machine 4');
insert into machineRecord (id, name) values (5, 'Machine 5');

insert into mechanicRecord(id, name) values (1, 'Alice');
insert into mechanicRecord(id, name) values (2, 'Bob');
insert into mechanicRecord(id, name) values (3, 'Chuck');

insert into MaintenanceRecord (id, machine_id, mechanic_id,  date,  startingHealth,finalHealth, notes) values (1, 1, 1, '2018-10-01'::timestamp, 1000, 2000, 'Replaced Fan Belt');
insert into MaintenanceRecord (id, machine_id, mechanic_id,  date,  startingHealth,finalHealth, notes) values (2, 2, 1, '2018-10-02'::timestamp, 1000, 2000, 'Replaced Fan Belt');
insert into MaintenanceRecord (id, machine_id, mechanic_id,  date,  startingHealth,finalHealth, notes) values (3, 2, 1, '2018-10-03'::timestamp, 1000, 2000, 'Replaced Fan Belt');
insert into MaintenanceRecord (id, machine_id, mechanic_id,  date,  startingHealth,finalHealth, notes) values (4, 1, 1, '2018-10-04'::timestamp, 1000, 2000, 'Replaced Fan Belt');
insert into MaintenanceRecord (id, machine_id, mechanic_id,  date,  startingHealth,finalHealth, notes) values (5, 3, 1, '2018-10-05'::timestamp, 2342, 235, 'Accidently broke the discombobulator while fixing the thingy');
