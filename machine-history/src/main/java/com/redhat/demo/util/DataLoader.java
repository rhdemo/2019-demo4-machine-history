package com.redhat.demo.util;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Random;

import javax.enterprise.event.Observes;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import com.redhat.demo.model.DamageRecord;
import com.redhat.demo.model.MachineRecord;
import com.redhat.demo.model.MaintenanceRecord;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import io.quarkus.runtime.StartupEvent;

/**
 * Utility class for loading data into the DB.
 * 
 * Not directly part of the demo.
 */
public class DataLoader {

    static final String[] MECHANICS = { "Alice", "Bob", "Chuck" };

    static final String[] MACHINES = { "Heavy Duty Sheet Metal Press", "Light Sheet Metal Press", "Bending Unit",
            "Paint Station", "Drill Press", "CNC Lathe", "Boring Machine", "Milling Machine",
            "Injection Moulding Station", "Hydraulic Press" };

    @Inject
    EntityManager em;

    boolean enabled = false;

    static final int DAYS = 600;
    static final int MAX_INTERVAL = 20;

    @Transactional
    void startup(@Observes StartupEvent startup) {
        if(!enabled) {
            return;
        }

        em.createQuery("delete from MaintenanceRecord").executeUpdate();
        em.createQuery("delete from DamageRecord").executeUpdate();
        em.createQuery("delete from MachineRecord").executeUpdate();

        SecureRandom r = new SecureRandom();
        int id = 1;
        for (String name : MACHINES) {
            MachineRecord m = new MachineRecord();
            m.name = name;
            m.id = id++;
            m.persist();

            int dayCount = 600;
            int health = 100;
            int target = r.nextInt(60) + 20;
            do {
                Calendar c = new GregorianCalendar();
                c.add(Calendar.DATE, -dayCount);
                dayCount -= (r.nextInt(MAX_INTERVAL) + 2);
                if (health > target) {
                    DamageRecord d = new DamageRecord();
                    d.damage = r.nextInt(10);
                    health -= d.damage;
                    d.date = c.getTime();
                    d.machine = m;
                    d.persist();
                } else {
                    MaintenanceRecord mr = new MaintenanceRecord();
                    mr.date = c.getTime();
                    mr.machine = m;
                    mr.mechanic = MECHANICS[r.nextInt(MECHANICS.length)];
                    mr.repair = Math.max(r.nextInt(40) + 20, 100 - health);
                    health += mr.repair;
                    mr.persist();
                }

            } while (dayCount >= 0);
        }
    }
}