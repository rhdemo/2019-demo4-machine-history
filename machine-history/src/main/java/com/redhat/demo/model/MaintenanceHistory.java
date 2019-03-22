package com.redhat.demo.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

@Table(uniqueConstraints = @UniqueConstraint(columnNames = {"machine_id", "date"}, name = "timestamp_index"))
@Entity
public class MaintenanceHistory extends PanacheEntity {

    @ManyToOne
    public Machine machine;

    @ManyToOne
    public Mechanic mechanic;

    /**
     * The time of the status
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false)
    public Date date;

    /**
     * The original machine health
     */
    public int originalHealth;

    public int finalHealth;

    public String notes;
}