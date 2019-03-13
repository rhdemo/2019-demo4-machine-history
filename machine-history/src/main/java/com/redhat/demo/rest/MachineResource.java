package com.redhat.demo.rest;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import com.redhat.demo.api.Machines;
import com.redhat.demo.api.beans.MachineState;
import com.redhat.demo.model.Machine;

public class MachineResource implements Machines {

    @Override
    public List<Long> allMachines() {
        return Machine.<Machine>listAll().stream().map((i) -> i.id).collect(Collectors.toList());
    }

    @Override
    public MachineState get(Integer id) {
        MachineState s = new MachineState();
        s.setHealth(100);
        s.setName("Test Machine");
        s.setId(id);
        return s;
    }
}
