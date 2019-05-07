package com.redhat.demo.api;

import com.redhat.demo.api.beans.Machine;
import com.redhat.demo.api.beans.MachineHistory;
import com.redhat.demo.api.beans.MachineState;
import java.lang.Integer;
import java.util.List;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

/**
 * A JAX-RS interface.  An implementation of this interface must be provided.
 */
@Path("/machines")
public interface MachinesResource {
  @GET
  @Produces("application/json")
  List<Machine> getAllMachines();

  @Path("/history/{id}")
  @GET
  @Produces("application/json")
  MachineHistory machineHistory(@PathParam("id") Integer id);

  @Path("/{id}")
  @GET
  @Produces("application/json")
  MachineState currentState(@PathParam("id") Integer id);
}
