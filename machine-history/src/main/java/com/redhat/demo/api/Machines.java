package com.redhat.demo.api;

import com.redhat.demo.api.beans.Machine;
import com.redhat.demo.api.beans.MachineState;
import com.redhat.demo.api.beans.MaintenanceData;
import java.lang.Integer;
import java.lang.Object;
import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

/**
 * A JAX-RS interface.  An implementation of this interface must be provided.
 */
@Path("/machines")
public interface Machines {
  @GET
  @Produces("application/json")
  List<Machine> getAllMachines();

  @Path("/{id}")
  @GET
  @Produces("application/json")
  MachineState getById(@PathParam("id") Object id);

  /**
   * Returns all maintenance records for the machine, in descending order
   */
  @Path("/records/{id}")
  @GET
  @Produces("application/json")
  @Consumes("application/json")
  List<MaintenanceData> getHistory();

  @Path("/records/{id}")
  @POST
  @Produces("application/json")
  @Consumes("application/json")
  Integer createRecord(MaintenanceData body);
}
