package com.redhat.demo.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

/**
 * DamageRecord
 */
@Entity
@Table(name = "damage_record")
public class DamageRecord extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer id;

    @ManyToOne
    public MachineRecord machine;

    @Temporal(TemporalType.DATE)
    public Date date;

    public int damage;
}