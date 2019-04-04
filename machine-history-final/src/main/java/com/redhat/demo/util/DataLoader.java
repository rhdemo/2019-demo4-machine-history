package com.redhat.demo.util;

import java.security.SecureRandom;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.enterprise.event.Observes;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import com.redhat.demo.model.MachineRecord;
import com.redhat.demo.model.MaintenanceRecord;

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
    static final int MAX_INTERVAL = 30;

    @Transactional
    void startup(@Observes StartupEvent startup) {
        if(!enabled) {
            return;
        }

        em.createQuery("delete from MaintenanceRecord").executeUpdate();
        em.createQuery("delete from MachineRecord").executeUpdate();

        SecureRandom r = new SecureRandom();
        int id = 1;
        for (String name : MACHINES) {
            MachineRecord m = new MachineRecord();
            m.name = name;
            m.id = id++;
            m.persist();

            int dayCount = 600;
            do {
                Calendar c = new GregorianCalendar();
                c.add(Calendar.DATE, -dayCount);
                dayCount -= (r.nextInt(MAX_INTERVAL) + 2);

                MaintenanceRecord mr = new MaintenanceRecord();
                mr.date = c.getTime();
                mr.machine = m;
                mr.mechanic = MECHANICS[r.nextInt(MECHANICS.length)];
                mr.repair = r.nextInt(40) + 20;
                mr.health = r.nextInt(50) + 50;

                mr.persist();

            } while (dayCount >= 0);
        }
    }
}