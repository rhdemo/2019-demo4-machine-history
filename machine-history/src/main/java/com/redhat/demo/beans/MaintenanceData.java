
package com.redhat.demo.beans;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * A record of maintenance performed on a machine
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "id",
    "date",
    "mechanic",
    "repair",
    "finalHealth"
})
public class MaintenanceData {

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("id")
    private Integer id;
    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("date")
    private String date;
    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("mechanic")
    private String mechanic;
    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("repair")
    private Integer repair;
    @JsonProperty("finalHealth")
    private Integer finalHealth;

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("id")
    public Integer getId() {
        return id;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("id")
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("date")
    public String getDate() {
        return date;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("date")
    public void setDate(String date) {
        this.date = date;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("mechanic")
    public String getMechanic() {
        return mechanic;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("mechanic")
    public void setMechanic(String mechanic) {
        this.mechanic = mechanic;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("repair")
    public Integer getRepair() {
        return repair;
    }

    /**
     * 
     * (Required)
     * 
     */
    @JsonProperty("repair")
    public void setRepair(Integer repair) {
        this.repair = repair;
    }

    @JsonProperty("finalHealth")
    public Integer getFinalHealth() {
        return finalHealth;
    }

    @JsonProperty("finalHealth")
    public void setFinalHealth(Integer finalHealth) {
        this.finalHealth = finalHealth;
    }

}
