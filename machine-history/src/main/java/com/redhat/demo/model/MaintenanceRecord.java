package com.redhat.demo.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

@Table(uniqueConstraints = @UniqueConstraint(columnNames = {"machine_id", "date"}, name = "timestamp_index"))
@Entity
public class MaintenanceRecord extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer id;

    @ManyToOne
    public MachineRecord machine;

    @ManyToOne
    public MechanicRecord mechanic;

    /**
     * The time of the status
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    public Date date;

    /**
     * The original machine health
     */
    public int startingHealth;

    public int finalHealth;

    public String notes;
}