package com.redhat.demo.model;

import javax.persistence.Entity;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

@Entity
public class Machine extends PanacheEntity {

    public String name;
    public long health;

}
