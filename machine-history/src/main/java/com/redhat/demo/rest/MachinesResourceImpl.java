package com.redhat.demo.rest;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Collectors;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.ws.rs.Path;

import com.redhat.demo.api.MachinesResource;
import com.redhat.demo.api.beans.Machine;
import com.redhat.demo.api.beans.MachineHistory;
import com.redhat.demo.api.beans.MachineState;
import com.redhat.demo.api.beans.MaintenanceData;
import com.redhat.demo.model.MachineRecord;
import com.redhat.demo.model.MaintenanceRecord;

import io.quarkus.panache.common.Sort;

@RequestScoped
@Path("/machines")
public class MachinesResourceImpl implements MachinesResource {

    @Inject
    EntityManager entityManager;

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

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
    public MachineHistory machineHistory(Integer id) {
        MachineRecord m = MachineRecord.findById(id);
        MachineHistory history = new MachineHistory();
        List<MaintenanceData> maint = MaintenanceRecord.<MaintenanceRecord>find("machine = ?1", Sort.descending("date"), m)
            .page(0, 5)
            .stream().map(mr -> {
                MaintenanceData data = new MaintenanceData();
                data.setId(mr.id);
                data.setDate(dateFormat.format(mr.date));
                data.setRepair(mr.repair);
                data.setMechanic(mr.mechanic);
                return data;
            }).collect(Collectors.toList());
        history.setMaintenance(maint);
        return history;
    }

    MachineState calculateState(Integer machineId) {
        MaintenanceRecord record = MaintenanceRecord.find("maaachine.id=?1", machineId).firstResult();
        MachineState ms = new MachineState();
        ms.setId(machineId);
        ms.setName(record.machine.name);
        return ms;
    }
}
