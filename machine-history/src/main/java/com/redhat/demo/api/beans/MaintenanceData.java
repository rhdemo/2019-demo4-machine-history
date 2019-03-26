
package com.redhat.demo.api.beans;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyDescription;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * A record of maintenance performed on a machine
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "time",
    "mechanic",
    "startingHealth",
    "finalHealth",
    "Notes",
    "repairCost"
})
public class MaintenanceData {

    /**
     * The time of the maintenance in unix epoch format
     * (Required)
     * 
     */
    @JsonProperty("time")
    @JsonPropertyDescription("The time of the maintenance in unix epoch format")
    private Integer time;
    /**
     * The mechanic name
     * (Required)
     * 
     */
    @JsonProperty("mechanic")
    @JsonPropertyDescription("The mechanic name")
    private String mechanic;
    /**
     * The starting health of the machine
     * (Required)
     * 
     */
    @JsonProperty("startingHealth")
    @JsonPropertyDescription("The starting health of the machine")
    private Integer startingHealth;
    /**
     * The health of the machine after the maintenance
     * (Required)
     * 
     */
    @JsonProperty("finalHealth")
    @JsonPropertyDescription("The health of the machine after the maintenance")
    private Integer finalHealth;
    /**
     * The maintenance notes
     * 
     */
    @JsonProperty("Notes")
    @JsonPropertyDescription("The maintenance notes")
    private String notes;
    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("repairCost")
    private Integer repairCost;

    /**
     * The time of the maintenance in unix epoch format
     * (Required)
     * 
     */
    @JsonProperty("time")
    public Integer getTime() {
        return time;
    }

    /**
     * The time of the maintenance in unix epoch format
     * (Required)
     * 
     */
    @JsonProperty("time")
    public void setTime(Integer time) {
        this.time = time;
    }

    /**
     * The mechanic name
     * (Required)
     * 
     */
    @JsonProperty("mechanic")
    public String getMechanic() {
        return mechanic;
    }

    /**
     * The mechanic name
     * (Required)
     * 
     */
    @JsonProperty("mechanic")
    public void setMechanic(String mechanic) {
        this.mechanic = mechanic;
    }

    /**
     * The starting health of the machine
     * (Required)
     * 
     */
    @JsonProperty("startingHealth")
    public Integer getStartingHealth() {
        return startingHealth;
    }

    /**
     * The starting health of the machine
     * (Required)
     * 
     */
    @JsonProperty("startingHealth")
    public void setStartingHealth(Integer startingHealth) {
        this.startingHealth = startingHealth;
    }

    /**
     * The health of the machine after the maintenance
     * (Required)
     * 
     */
    @JsonProperty("finalHealth")
    public Integer getFinalHealth() {
        return finalHealth;
    }

    /**
     * The health of the machine after the maintenance
     * (Required)
     * 
     */
    @JsonProperty("finalHealth")
    public void setFinalHealth(Integer finalHealth) {
        this.finalHealth = finalHealth;
    }

    /**
     * The maintenance notes
     * 
     */
    @JsonProperty("Notes")
    public String getNotes() {
        return notes;
    }

    /**
     * The maintenance notes
     * 
     */
    @JsonProperty("Notes")
    public void setNotes(String notes) {
        this.notes = notes;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("repairCost")
    public Integer getRepairCost() {
        return repairCost;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("repairCost")
    public void setRepairCost(Integer repairCost) {
        this.repairCost = repairCost;
    }

}
