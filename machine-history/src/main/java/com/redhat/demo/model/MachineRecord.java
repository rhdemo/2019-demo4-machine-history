package com.redhat.demo.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

@Entity
@Table(name = "machine_record")
public class MachineRecord extends PanacheEntityBase {
    @Id
    public Integer id;

    public String name;

}
