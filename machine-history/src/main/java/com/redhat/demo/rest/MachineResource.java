package com.redhat.demo.rest;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

import com.redhat.demo.api.Machines;
import com.redhat.demo.api.beans.Machine;
import com.redhat.demo.api.beans.MachineState;
import com.redhat.demo.model.MachineRecord;
import com.redhat.demo.model.MaintenanceRecord;
import io.quarkus.panache.common.Sort;

@RequestScoped
@Path("/machines")
public class MachineResource implements Machines {

    @Inject
    EntityManager entityManager;

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
    public MachineState getMachine(Integer id) {
        MaintenanceRecord mr = MaintenanceRecord.find("machine.id=?1 order by date desc", id).firstResult();
        MachineState ms = new MachineState();
        ms.setHealth(0);
        ms.setName(mr.machine.name);
        ms.setLifetimeCost((Long) entityManager
                .createQuery("select sum(m.repairCost) from MaintenanceRecord m where m.machine.id=:machine")
                .setParameter("machine", id).getSingleResult());
        return ms;
    }
}
