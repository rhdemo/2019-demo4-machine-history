
package com.redhat.demo.beans;

import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * The history of a machine
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "maintenance",
    "name"
})
public class MachineHistory {

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("maintenance")
    private List<MaintenanceData> maintenance = new ArrayList<MaintenanceData>();
    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("name")
    private String name;

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("maintenance")
    public List<MaintenanceData> getMaintenance() {
        return maintenance;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("maintenance")
    public void setMaintenance(List<MaintenanceData> maintenance) {
        this.maintenance = maintenance;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("name")
    public String getName() {
        return name;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("name")
    public void setName(String name) {
        this.name = name;
    }

}
