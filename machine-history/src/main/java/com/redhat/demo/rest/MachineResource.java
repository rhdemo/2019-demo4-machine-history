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
}
