package com.redhat.demo.api;

import com.redhat.demo.api.beans.MachineState;
import java.lang.Integer;
import java.lang.Object;
import java.util.List;
import javax.ws.rs.GET;
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
  List<Integer> getAllIds();

  @Path("/{id}")
  @GET
  @Produces("application/json")
  MachineState getById(@PathParam("id") Object id, @PathParam("id") Object id);
}
