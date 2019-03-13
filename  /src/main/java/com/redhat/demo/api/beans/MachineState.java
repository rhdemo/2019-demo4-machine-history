
package com.redhat.demo.api.beans;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyDescription;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * The representation of the current state of a machine
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "id",
    "name",
    "health"
})
public class MachineState {

    /**
     * The machine ID
     * (Required)
     * 
     */
    @JsonProperty("id")
    @JsonPropertyDescription("The machine ID")
    private Integer id;
    /**
     * The machine name
     * (Required)
     * 
     */
    @JsonProperty("name")
    @JsonPropertyDescription("The machine name")
    private String name;
    /**
     * The machine health
     * (Required)
     * 
     */
    @JsonProperty("health")
    @JsonPropertyDescription("The machine health")
    private Double health;

    /**
     * The machine ID
     * (Required)
     * 
     */
    @JsonProperty("id")
    public Integer getId() {
        return id;
    }

    /**
     * The machine ID
     * (Required)
     * 
     */
    @JsonProperty("id")
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * The machine name
     * (Required)
     * 
     */
    @JsonProperty("name")
    public String getName() {
        return name;
    }

    /**
     * The machine name
     * (Required)
     * 
     */
    @JsonProperty("name")
    public void setName(String name) {
        this.name = name;
    }

    /**
     * The machine health
     * (Required)
     * 
     */
    @JsonProperty("health")
    public Double getHealth() {
        return health;
    }

    /**
     * The machine health
     * (Required)
     * 
     */
    @JsonProperty("health")
    public void setHealth(Double health) {
        this.health = health;
    }

}
