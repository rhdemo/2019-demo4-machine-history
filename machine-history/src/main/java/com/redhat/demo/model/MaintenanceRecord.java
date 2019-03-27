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

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

@Entity
@Table(name = "maintenance_record")
public class MaintenanceRecord extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer id;

    @ManyToOne
    public MachineRecord machine;

    public String mechanic;

    /**
     * The time of the status
     */
    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    public Date date;

    /**
     * The amount of health that was repaired
     */
    public int repair;

}