package com.redhat.demo.rest;

import java.util.List;
import java.util.stream.Collectors;

import com.redhat.demo.api.Machines;
import com.redhat.demo.api.beans.MachineState;
import com.redhat.demo.model.Machine;
import com.redhat.demo.model.MaintenanceHistory;

import io.quarkus.panache.common.Sort;

public class MachineResource implements Machines {

    @Override
    public List<Long> allMachines() {
        return Machine.<Machine>listAll().stream().map((i) -> i.id).collect(Collectors.toList());
    }

    @Override
    public MachineState get(Integer id) {
        MaintenanceHistory history = MaintenanceHistory.find("machine.id=?1", Sort.descending("date"), id.longValue()).firstResult();
        MachineState s = new MachineState();
        s.setHealth(history.finalHealth);
        s.setName(history.machine.name);
        s.setId(id);
        return s;
    }
}
