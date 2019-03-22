package com.redhat.demo.model;

import javax.persistence.Column;
import javax.persistence.Entity;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

@Entity
public class Mechanic extends PanacheEntity {

    @Column(nullable = false)
    public String name;

}