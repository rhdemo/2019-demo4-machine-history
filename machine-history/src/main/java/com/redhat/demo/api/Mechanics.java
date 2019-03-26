package com.redhat.demo.api;

import com.redhat.demo.api.beans.Mechanic;
import java.util.List;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

/**
 * A JAX-RS interface.  An implementation of this interface must be provided.
 */
@Path("/mechanics")
public interface Mechanics {
  @GET
  @Produces("application/json")
  List<Mechanic> generatedMethod1();
}
