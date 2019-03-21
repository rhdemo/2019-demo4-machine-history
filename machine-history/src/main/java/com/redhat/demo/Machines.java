package com.redhat.demo;

import com.redhat.demo.beans.MachineState;
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
  List<Integer> generatedMethod1();

  @Path("/{id}")
  @GET
  MachineState getsTheMachineState(@PathParam("id") Object id);
}
