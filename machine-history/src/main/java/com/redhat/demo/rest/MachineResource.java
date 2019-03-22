package com.redhat.demo.rest;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.ws.rs.PathParam;

import com.redhat.demo.api.Machines;
import com.redhat.demo.api.beans.Machine;
import com.redhat.demo.api.beans.MachineState;
import com.redhat.demo.api.beans.MaintenanceData;
import com.redhat.demo.model.MachineRecord;
import com.redhat.demo.model.MaintenanceRecord;
import com.redhat.demo.model.MechanicRecord;
import io.quarkus.panache.common.Sort;

public class MachineResource implements Machines {

    @Override
    public List<Machine> getAllMachines() {
        return MachineRecord.<MachineRecord>listAll().stream().map((i) -> {
            Machine m = new Machine();
            m.setId(i.id);
            m.setName(i.name);
            return m;
        }).collect(Collectors.toList());
    }

    @Override
    public MachineState get(Integer id) {
        MaintenanceRecord history = MaintenanceRecord.find("machine.id=?1", Sort.descending("date"), id).firstResult();
        MachineState s = new MachineState();
        s.setHealth(history.finalHealth);
        s.setName(history.machine.name);
        s.setId(id);
        return s;
    }

    @Override
    public List<MaintenanceData> getHistory(Integer id) {
        return MaintenanceRecord.<MaintenanceRecord>find("machine.id=?1", Sort.descending("date"), id).stream().map((i) -> {
            MaintenanceData m = new MaintenanceData();
            m.setFinalHealth(i.finalHealth);
            m.setStartingHealth(i.startingHealth);
            m.setMechanic(i.mechanic.name);
            m.setNotes(i.notes);
            m.setTime(i.date.getTime());
            return m;
        }).collect(Collectors.toList());
    }

    @Override
    public Integer createRecord(@PathParam("id") Integer id, MaintenanceData body) {
        MaintenanceRecord r = new MaintenanceRecord();
        r.date = new Date();
        r.finalHealth = body.getFinalHealth();
        r.startingHealth = body.getStartingHealth();
        r.mechanic = MechanicRecord.find("name", body.getMechanic()).singleResult();
        r.machine = MachineRecord.findById(id);
        return null;
    }
}
